//
//  Place.swift
//  PinsOnMap
//
//  Created by Wojciech Charysz on 21.04.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import Foundation

protocol PlaceProtocol: Codable {
    var pid: String? {get set}
    var type: String? {get set}
    var score: Int? {get set}
    var name: String? {get set}
    var address: String? {get set}
    var coordinates: Coordinates? {get set}
    var area: Area? {get set}
    var lifeSpan: LifeSpan? {get set}
}

/**
 This struct is used during JSON parsing and conforms to Codable protocol.
 
 It represents the Place data and contains following properties:
 - pid: The Place Identification string.
 - type: The Place type string.
 - score: The Place score number.
 - name: The Place name string.
 - address: The Place address string.
 - coordinates: The Place latitude and longitude.
 - area: The Place Area model.
 - lifeSpan: The Place LifeSpan model.
 
 All parameters can be nil, but in such case this object would be useless.
 */
struct Place: PlaceProtocol {
    var pid: String?
    var type: String?
    var score: Int?
    var name: String?
    var address: String?
    var coordinates: Coordinates?
    var area: Area?
    var lifeSpan: LifeSpan?
    
    enum CodingKeys: String, CodingKey {
        case pid = "id"
        case type
        case score
        case name
        case address
        case coordinates
        case area
        case lifeSpan = "life-span"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        pid = try container.decodeIfPresent(String.self, forKey: .pid)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        score = try container.decodeIfPresent(Int.self, forKey: .score)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        address = try container.decodeIfPresent(String.self, forKey: .address)
        coordinates = try container.decodeIfPresent(Coordinates.self, forKey: .coordinates)
        area = try container.decodeIfPresent(Area.self, forKey: .area)
        lifeSpan = try container.decodeIfPresent(LifeSpan.self, forKey: .lifeSpan)
    }
}
