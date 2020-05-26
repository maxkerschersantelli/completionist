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
    @EnvironmentObject var session: SessionStore
    
    

    var body: some View {
        TabView(selection: $selection){
            HomePage().tabItem {
                    VStack {
                        Image("first")
                        Text("First")
                    }
                }.tag(0)
            HStack{
            Text("Second View")
            .font(.title)
            
            Button(action: signOut){
                Text("Sign Out")
            }
            
            }.tabItem {
                VStack {
                    Image("second")
                    Text("Second")
                }
            }.tag(1)
        }
    }
    
    func signOut(){
        session.signOut()
    }
}
