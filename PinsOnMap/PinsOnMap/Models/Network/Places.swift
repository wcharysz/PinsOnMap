//
//  Places.swift
//  PinsOnMap
//
//  Created by Wojciech Charysz on 21.04.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import Foundation

protocol PlacesProtocol: Codable {
    var created: Date? {get set}
    var count: Int? {get set}
    var offset: Int? {get set}
    var places: [Place]? {get set}
}

struct Places: PlacesProtocol {
    var created: Date?
    var count: Int?
    var offset: Int?
    var places: [Place]?
    
    enum CodingKeys: String, CodingKey {
        case created
        case count
        case offset
        case places
    }
}
