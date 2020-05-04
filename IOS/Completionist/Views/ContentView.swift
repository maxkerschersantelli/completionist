//
//  ContentView.swift
//  Completionist
//
//  Created by Max Kerscher-Santelli on 4/15/20.
//  Copyright © 2020 Max Kerscher-Santelli. All rights reserved.
//

import SwiftUI
import Firebase
import GoogleSignIn
import Foundation


struct ContentView : View {

  @EnvironmentObject var session: SessionStore
    
  

  func getUser () {
    session.listen()
  }

  var body: some View {
    Group {
      if (session.session != nil) {
        App()
      } else {
        AuthenticationScreen()
      }
    }.onAppear(perform: getUser)
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
