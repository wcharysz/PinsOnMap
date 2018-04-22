//
//  LifeSpan.swift
//  PinsOnMap
//
//  Created by Wojciech Charysz on 22.04.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import Foundation

protocol LifeSpanProtocol: Codable {
    var begin: Date {get set}
    var end: Date {get set}
    var isEnded: Bool {get set}
}

struct LifeSpan: LifeSpanProtocol {
    var begin: Date
    var end: Date
    var isEnded = false
    
    enum CodingKeys: String, CodingKey {
        case begin
        case end
        case isEnded = "ended"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isEnded = try container.decode(Bool.self, forKey: .isEnded)
        let beginString = try container.decode(String.self, forKey: .begin)
        
        guard let beginDate = DateFormatter.yyyy.date(from: beginString) else {
            throw DecodingError.dataCorruptedError(forKey: .begin, in: container, debugDescription: "Begin date format does not match yyyy")
        }
        
        begin = beginDate
        
        let endString = try container.decode(String.self, forKey: .end)
        
        guard let endDate = DateFormatter.yyyyMM.date(from: endString) else {
            throw DecodingError.dataCorruptedError(forKey: .end, in: container, debugDescription: "End date format does not match yyyy-MM")
        }
        
        end = endDate
    }
}
