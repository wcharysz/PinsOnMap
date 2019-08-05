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

/**
 This struct is used during JSON parsing and conforms to Codable protocol. It's a container for the Places objects.
*/
struct Places: PlacesProtocol {
    
    /// The creation date of the Places list. It's received from the server.
    var created: Date?
    
    /// The count number of the chunk.
    var count: Int?
    
    /// The offset number of the downloaded Places.
    var offset: Int?
    
    /// The array of Place's model.
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
        
        var createdString = try container.decode(String.self, forKey: .created)
        let formatter = ISO8601DateFormatter()
        
        if #available(iOS 11, *) {
           formatter.formatOptions.insert(.withFractionalSeconds)
        } else {
            //remove miliseconds, otherwise ISO8601DateFormatter won't convert it.
            let range = createdString.startIndex..<createdString.endIndex
            let trimmedDate = createdString.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression, range: range)
            createdString = trimmedDate
        }
        
        created = formatter.date(from: createdString)
    }
}
