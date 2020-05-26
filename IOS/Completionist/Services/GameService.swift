//
//  GameService.swift
//  Completionist
//
//  Created by Max Kerscher-Santelli on 5/25/20.
//  Copyright © 2020 Max Kerscher-Santelli. All rights reserved.
//

import Foundation

protocol GameService {
    func fetchPopularGames(for platform: Platform, completion: @escaping (Result<[Game], Error>) -> Void)
    func fetchGame(id: Int, completion: @escaping (Result<Game, Error>) -> Void)
}
