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
        VStack{
            Button(action: played){
                if(session.playedGames[self.gameID] != nil){
                    Text("Played")
                }else{
                    Text("Not Played")
                }
                
            }
        }
    }
    
    func played(){
        session.played(id: self.gameID)
    }
}

