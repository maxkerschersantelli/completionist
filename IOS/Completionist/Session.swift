//
//  Session.swift
//  Completionist
//
//  Created by Max Kerscher-Santelli on 4/15/20.
//  Copyright © 2020 Max Kerscher-Santelli. All rights reserved.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import Combine
import GoogleSignIn

// TODO: Google sign in:
// https://firebase.google.com/docs/auth/ios/google-signin
struct User {
    var uid: String
    var email: String?
    
    static let `default` = Self(
        uid: "sdfdsaf",
        email: "ben.mcmahen@gmail.com"
    )

    init(uid: String, email: String?) {
        self.uid = uid
        self.email = email
    }
}

/**
 * SessionStore manages the firebase user session. It contains the current user. It
 * also provides functions for signing up, signing in, etc.
 */

class SessionStore : ObservableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    var isLoggedIn = false { didSet { self.didChange.send(self) }}
    var playedGames : NSDictionary = NSDictionary.init();
    @Published var session: User? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    
    init(session: User? = nil) {
        self.session = session
    }
    
    func listen () {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                print("Got user \(user.email)")
                self.isLoggedIn = true
                self.session = User(
                    uid: user.uid,
                    email: user.email
                )
                self.getPlayedGames()
            } else {
                self.isLoggedIn = false
                self.session = nil
            }
        }
    }
    
    func signInWithGoogle () {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
//            self.isLoggedIn = false
//            self.session = nil
            return true
        } catch {
            return false
        }
    }
    
    // stop listening for auth changes
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
    
    func signUp(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func signIn(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func played(id: Int){
        print("adding game")
        print(String(id))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM-dd-yyyy HH:mm"
        Database.database().reference().child("users").child(self.session!.uid).child("playedGames").child(String(id)).setValue(["playedLevel": "Played", "rating": 5, "dateAdded": dateFormatter.string(from: Date())])
        self.getPlayedGames()
    }
    
    func getPlayedGames(){
        print("getplayedGames")
        Database.database().reference().child("users").child(self.session!.uid).child("playedGames").observeSingleEvent(of: .value, with: { (snapshot) in
            self.playedGames = snapshot.value as! NSDictionary
            print(self.playedGames)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
