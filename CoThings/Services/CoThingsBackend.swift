//
//  CoThingsService.swift
//  CoThings
//
//  Created by Umur Gedik on 2020/05/16.
//  Copyright © 2020 Rainlab. All rights reserved.
//

import Combine

enum ConnectionStatus: String {
    case connecting
    case ready
    case failed
}

struct UpdateError: Error {
    var localizedDescription: String {
        "failed to update room"
    }
}

protocol CoThingsBackend {
    var status: ConnectionStatus { get }
    var statusPublisher: AnyPublisher<ConnectionStatus, Never> { get }

    var rooms: [Room] { get }
    var roomsPublisher: AnyPublisher<[Room], Never> { get }

    func increasePopulation(room: Room, completionHandler: @escaping (Result<Void, UpdateError>) -> Void)
    func decreasePopulation(room: Room, completionHandler: @escaping (Result<Void, UpdateError>) -> Void)
}