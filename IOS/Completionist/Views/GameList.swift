//
//  GameList.swift
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

struct GameList: View {
    @State var games: [Game] = []
    
    func getGameData(){
        print("getGameData")
        GameStore.shared.fetchPopularGames(for: .ps4) { [self]  (result) in
            
            switch result {
            case .success(let games):
                self.games = games
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    var body: some View{
        Group{
            if(games.count < 1){
                Text("gameList is loading")
            }else{
                NavigationView{
                    List(games) { game in
                        NavigationLink(destination: GameDetail(gameId: game.id, game: game)) {
                            GameRow(game: game)
                        }
                    }
                }.navigationBarTitle(Text("Home Page").foregroundColor(Color.black))
            }
        }.onAppear(perform: getGameData)
    }
}
