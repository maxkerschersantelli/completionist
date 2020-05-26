//
//  HomePage.swift
//  Completionist
//
//  Created by Max Kerscher-Santelli on 5/25/20.
//  Copyright © 2020 Max Kerscher-Santelli. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase
import GoogleSignIn
import IGDB_SWIFT_API

struct HomePage: View {
    
    @EnvironmentObject var session: SessionStore
    @State var apiKey: String = ""
    func getDataBase (){
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
                VStack(){
                    GameList()
                }
            }else{
                Loading()
            }
        }
        .onAppear(perform: getDataBase)
    }
        
}
