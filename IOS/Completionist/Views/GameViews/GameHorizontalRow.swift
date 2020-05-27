//
//  GameHorizontalRow.swift
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

struct GameHorizontalRow: View {
    var game: Game
    
    var body: some View{
        Text(game.name)
    }
}
