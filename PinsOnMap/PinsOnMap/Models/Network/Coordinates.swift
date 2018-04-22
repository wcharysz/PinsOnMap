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
    var latitude: CLLocationDegrees? {get set}
    var longitude: CLLocationDegrees? {get set}
}

struct Coordinates: CoordinatesProtocol {
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
}
