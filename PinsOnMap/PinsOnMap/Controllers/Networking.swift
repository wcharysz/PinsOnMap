//
//  Networking.swift
//  PinsOnMap
//
//  Created by Wojciech Charysz on 22.04.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import Foundation

class Networking {
    
    static let baseURLString = "https://musicbrainz.org/ws/2/"
    
    enum ApiURL: String {
        case place = "place/?query="
    }
    
    lazy var decoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        return jsonDecoder
    }()
    
    private func getURLString(for type: ApiURL) -> String {
        let urlString = Networking.baseURLString + type.rawValue
        
        return urlString
    }
    
    func downloadPlaces(forName name: String, completion: @escaping (_ places: Places?) -> Void)  {
        guard let url = URL(string: getURLString(for: .place)) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let result = try self.decoder.decode(Places.self, from: data)
                completion(result)
            } catch {
                completion(nil)
            }
         }
        
        task.resume()
    }
}
