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
    
    var body: some View {
        VStack(){
            GameList()
        }
    }
    
}

