//
//  GameHorizontalList.swift
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

struct GameHorizontalList: View {
    @Binding var games: [Game]
    
    var body: some View{
        Group{
            if(games.count < 1){
                Text("gameList is loading")
            }else{
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(games){game in
                            NavigationLink(destination: GameDetail(gameId: game.id, game: game)) {
                                GameHorizontalRow(game: game)
                            }
                        }
                    }
                }
            }
        }
    }
}

