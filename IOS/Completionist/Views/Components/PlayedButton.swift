//
//  PlayedButton.swift
//  Completionist
//
//  Created by Max Kerscher-Santelli on 5/26/20.
//  Copyright © 2020 Max Kerscher-Santelli. All rights reserved.
//

import Foundation
import SwiftUI

struct PlayedButton: View {
    var gameID: Int
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        Button(action: played){
            Text("Played")
        }
    }
    
    func played(){
        session.played(id: self.gameID)
    }
}

