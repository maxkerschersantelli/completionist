//
//  GamePlatformList.swift
//  Completionist
//
//  Created by Max Kerscher-Santelli on 5/26/20.
//  Copyright © 2020 Max Kerscher-Santelli. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase
import GoogleSignIn
import IGDB_SWIFT_API

struct GamePlatformList: View {
    @State var platform: Platform
    @State var games: [Game] = []
    
    @EnvironmentObject var session: SessionStore
    
    func getGameData(){
        print("getGameData")
        GameStore.shared.fetchPopularGames(for: platform) { [self]  (result) in
            
            switch result {
            case .success(let games):
                self.games = games
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        print("finishGameData")
    }
    
    var body: some View {
        Group{
            GameHorizontalList(games: self.$games)
        }
        .onAppear{
            if(self.games.count < 1){
                self.getGameData()
            }
        }
        
    }
}
