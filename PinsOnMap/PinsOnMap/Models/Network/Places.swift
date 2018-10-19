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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decodeIfPresent(Int.self, forKey: .count)
        offset = try container.decodeIfPresent(Int.self, forKey: .offset)
        places = try container.decodeIfPresent([Place].self, forKey: .places)
        
        let createdString = try container.decode(String.self, forKey: .created)
        let formatter = ISO8601DateFormatter()
        
        //remove miliseconds
        let range = createdString.startIndex..<createdString.endIndex
        let trimmedDate = createdString.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression, range: range)
        
        created = formatter.date(from: trimmedDate)
    }
}
