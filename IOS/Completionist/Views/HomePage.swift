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
    @State var xboxGames: [Game] = []
    @State var ps4Games: [Game] = []
    @State var switchGames: [Game] = []
    @EnvironmentObject var session: SessionStore
    
    func getPS4GameData(){
        print("getGameData")
        GameStore.shared.fetchPopularGames(for: .ps4) { [self]  (result) in
            
            switch result {
            case .success(let games):
                self.ps4Games = games
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        print("finishGameData")
    }
    
    func getXboxGameData(){
        print("getGameData")
        GameStore.shared.fetchPopularGames(for: .xboxone) { [self]  (result) in
            
            switch result {
            case .success(let games):
                self.xboxGames = games
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        print("finishGameData")
    }
    
    func getSwitchGameData(){
        print("getGameData")
        GameStore.shared.fetchPopularGames(for: .nswitch) { [self]  (result) in
            
            switch result {
            case .success(let games):
                self.switchGames = games
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        print("finishGameData")
    }
    
    var body: some View {
        VStack{
            NavigationView{
                VStack{
                    Text("PS4")
                    GamePlatformList(platform: .ps4)
                    Text("Xbox One")
                    GamePlatformList(platform: .xboxone)
                    Text("Switch")
                    GamePlatformList(platform: .nswitch)
                }
            }
        }
    }
    
}

