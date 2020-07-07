//
//  ProfilePage.swift
//  Completionist
//
//  Created by Max Kerscher-Santelli on 7/6/20.
//  Copyright © 2020 Max Kerscher-Santelli. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase
import GoogleSignIn
import IGDB_SWIFT_API

struct ProfilePage: View {
    @EnvironmentObject var session: SessionStore

    var body: some View {
        VStack{
            Text("Profile Pgae")
            Button(action: signOut){
                Text("Sign Out")
            }
        }
    }
    
    func signOut(){
        session.signOut()
    }
}
