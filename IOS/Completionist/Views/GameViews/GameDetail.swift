//
//  GameDetail.swift
//  Completionist
//
//  Created by Max Kerscher-Santelli on 5/25/20.
//  Copyright © 2020 Max Kerscher-Santelli. All rights reserved.
//

import Foundation
import SwiftUI

struct GameDetail: View {
    @ObservedObject var imageLoader = ImageLoader()
      
    var gameId: Int
    @State var game: Game
    
    var body: some View {
        Group {
            List {
                PosterView(image: self.imageLoader.image)
                    .onAppear {
                        if let url = self.game.coverURL {
                            self.imageLoader.downloadImage(url: url)
                        }
                }
                
                GameSectionView(game: self.game)
                PlayedButton(gameID: self.game.id)
            }
        }
        .edgesIgnoringSafeArea([.top])
        .onAppear {
            GameStore.shared.fetchGame(id: self.gameId) {[self] (result) in
                
                switch result {
                case .success(let game):
                    self.game = game
                    
                case .failure(let error): print(error.localizedDescription)
                }
            }
        }
    }
}

struct PosterView: View {
    
    var image: UIImage?
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
                .aspectRatio(500/750, contentMode: .fit)
            
            if (image != nil) {
                Image(uiImage: self.image!)
                    .resizable()
                    .aspectRatio(500/750, contentMode: .fit)
            }
        }
        
    }
    
}


struct GameSectionView: View {
    
    var game: Game
    
    var body: some View {
        Section {
            Text(game.summary)
                .font(.body)
                .lineLimit(nil)
            
            if (!game.storyline.isEmpty) {
                Text(game.storyline)
                    .font(.body)
                    .lineLimit(nil)
                
            }
            Text(game.genreText)
                .font(.subheadline)
            Text(game.releaseDateText)
                .font(.subheadline)
            Text(game.company)
                .font(.subheadline)
        }
    }
}

struct GameDetail_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
