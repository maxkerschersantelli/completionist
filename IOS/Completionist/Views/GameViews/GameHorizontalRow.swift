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
    @ObservedObject var imageLoader: ImageLoader = ImageLoader()
    
    var body: some View{
        ZStack(alignment: .bottomLeading) {
                if (imageLoader.image != nil) {
                    GeometryReader { geometry in
                        Image(uiImage: self.imageLoader.image!)
                            .resizable(resizingMode: Image.ResizingMode.stretch)
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: geometry.size.height)
                            .clipped()
                    }
                }
                VStack(alignment: .leading) {
                    Text(game.name)
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .lineLimit(1)
                    Text(game.releaseDateText)
                        .font(.subheadline)
                        .foregroundColor(Color.white)
                        .lineLimit(2)
                    Text(game.company)
                        .font(.caption)
                        .foregroundColor(Color.white)
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity, alignment: .bottomLeading)
                .padding(EdgeInsets.init(top: 16, leading: 16, bottom: 16, trailing: 16))
                .background(Rectangle().foregroundColor(Color.black).opacity(0.6).blur(radius: 2.5))
            }
            .background(Color.secondary)
            .cornerRadius(10)
            .shadow(radius: 20)
            .padding(EdgeInsets.init(top: 8, leading: 0, bottom: 8, trailing: 0))
            .frame(height: 100)
            .onAppear {
                if let url = self.game.coverURL {
                    self.imageLoader.downloadImage(url: url)
                }
            }
        }
}
