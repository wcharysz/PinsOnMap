//
//  Coordinates.swift
//  PinsOnMap
//
//  Created by Wojciech Charysz on 21.04.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import Foundation
import CoreLocation

protocol CoordinatesProtocol: Codable {
    var latitude: String? {get set}
    var longitude: String? {get set}
}

struct Coordinates: CoordinatesProtocol {
    var latitude: String?
    var longitude: String?
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try container.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try container.decodeIfPresent(String.self, forKey: .longitude)
    }
}
