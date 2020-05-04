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
            Text("First View")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("first")
                        Text("First")
                    }
                }
                .tag(0)
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
    
    func getDataBase (){
        let wrapper:IGDBWrapper = IGDBWrapper()
        var ref: DatabaseReference!
        //var IGDB_User_Key: String
        ref = Database.database().reference()
        
        ref.child("IGDB_User_Key").observeSingleEvent(of: .value, with: { (snapshot) in
          wrapper.userKey = snapshot.value as? String ?? ""

          }) { (error) in
            print(error.localizedDescription)
        }
          
        let apicalypse = APICalypse()
            .search(searchQuery: "Halo")
            .fields(fields: "*")
            .sort(field: "release_dates.date", order: .ASCENDING)

        wrapper.search(apiCalypse: apicalypse, result: { searchResults in
            print(searchResults)
        }) { error in
            print(error)
        }
    }
    
    func signOut(){
        session.signOut()
    }
}
