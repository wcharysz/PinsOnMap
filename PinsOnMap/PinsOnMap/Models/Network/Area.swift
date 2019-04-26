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

/**
 This struct is used during JSON parsing and conforms to Codable protocol. It contains: pid (place Id), name and sortName.
 */
struct Area: AreaProtocol {
    
    /// A Place identification string.
    var pid: String?
    
    /// A Place name.
    var name: String?
    
    /// A Place sort name.
    var sortName: String?
    
    enum CodingKeys: String, CodingKey {
        case pid = "id"
        case name
        case sortName = "sort-name"
    }
}
