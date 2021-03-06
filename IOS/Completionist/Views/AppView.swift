//
//  AppView.swift
//  Completionist
//
//  Created by Max Kerscher-Santelli on 4/15/20.
//  Copyright © 2020 Max Kerscher-Santelli. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase
import GoogleSignIn
import IGDB_SWIFT_API

struct App: View {
    @State private var selection = 0
    @State var apiKey: String = ""
    @EnvironmentObject var session: SessionStore
    
    func getDataBase (){
        if(apiKey != ""){
            return
        }
        print("getDataBase Start")
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("IGDB_User_Key").observeSingleEvent(of: .value, with: { (snapshot) in
            GameStore.shared.setApiKey(apiKey: snapshot.value as? String ?? "")
            self.apiKey = snapshot.value as? String ?? ""
          }) { (error) in
            print(error.localizedDescription)
        }
        print("getDataBase end")
    }

    var body: some View {
        Group{
            if(apiKey != ""){
                TabView(selection: $selection){
                    HomePage().tabItem {
                        VStack {
                            Image("first")
                            Text("Home")
                        }
                    }.tag(0)
                    SearchPage().tabItem {
                        VStack {
                            Image("second")
                            Text("Search")
                        }
                    }.tag(1)
                    ProfilePage().tabItem{
                        VStack {
                            Image("second")
                            Text("Profile")
                        }
                    }.tag(2)
                }
            }else{
                Loading()
            }
        }
        .onAppear(perform: getDataBase)
    }
    
    func signOut(){
        session.signOut()
    }
}
