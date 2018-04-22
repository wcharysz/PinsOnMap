//
//  Area.swift
//  PinsOnMap
//
//  Created by Wojciech Charysz on 21.04.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import Foundation

protocol AreaProtocol: Codable {
    var pid: String? {get set}
    var name: String? {get set}
    var sortName: String? {get set}
}

struct Area: AreaProtocol {
    var pid: String?
    var name: String?
    var sortName: String?
    
    enum CodingKeys: String, CodingKey {
        case pid = "id"
        case name
        case sortName = "sort-name"
    }
}
