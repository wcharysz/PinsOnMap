//
//  LifeSpan.swift
//  PinsOnMap
//
//  Created by Wojciech Charysz on 22.04.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import Foundation

protocol LifeSpanProtocol: Codable {
    var begin: Date? {get set}
    var end: Date? {get set}
    var isEnded: Bool {get set}
}

/**
 This struct is used during JSON parsing and conforms to Codable protocol. It contains a begin and the end date of the Place.
 */
struct LifeSpan: LifeSpanProtocol {
    
    /// The begin date of the Place. It's based on a year value only.
    var begin: Date?
    
    /// The end date of the Place. It's based on a year and month values only.
    var end: Date?
    
    /// The boolean value if the Place isn't operating anymore.
    var isEnded = false
    
    enum CodingKeys: String, CodingKey {
        case begin
        case end
        case isEnded = "ended"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            isEnded = try container.decode(Bool.self, forKey: .isEnded)
        } catch {
            isEnded = false
        }
        
        do {
            let beginString = try container.decode(String.self, forKey: .begin)
            let beginDate = DateFormatter.yyyy.date(from: beginString)
            begin = beginDate
        } catch {
            begin = nil
        }

        do {
            let endString = try container.decode(String.self, forKey: .end)
            let endDate = DateFormatter.yyyyMM.date(from: endString)
            end = endDate
        } catch {
            end = nil
        }
    }
}
