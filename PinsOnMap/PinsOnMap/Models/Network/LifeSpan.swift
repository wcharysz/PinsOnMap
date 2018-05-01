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

struct LifeSpan: LifeSpanProtocol {
    var begin: Date?
    var end: Date?
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
