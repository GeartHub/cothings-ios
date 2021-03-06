//
//  RoomsController.swift
//  CoThings
//
//  Created by Umur Gedik on 2020/05/15.
//  Copyright © 2020 Rainlab. All rights reserved.
//

import Foundation
import Combine

class RoomsController: ObservableObject {
    let session: PlaceSession
    
    @Published var rooms: [String: [Room]] = [:]
    @Published var groups: [String] = []
    @Published var groupPopulations: [String: Int] = [:]
    
    private var roomsSubscription: AnyCancellable!
        
    init(session: PlaceSession) {
        self.session = session
        
        roomsSubscription = session.$rooms
            .sink { rooms in
                let sortedRooms = rooms.sorted {$0.name < $1.name}
                self.rooms = Dictionary(grouping: sortedRooms, by: { $0.group })
                
                self.groups = NSOrderedSet(array: rooms.map(\.group), copyItems: true).array as! [String]
                
                var groupPopulations = [String: Int]()
                for group in self.groups {
                    let population = self.rooms[group]!.reduce(0, {$0 + $1.population})
                    groupPopulations[group] = population
                }
                
                self.groupPopulations = groupPopulations
            }
    }
}
