//
//  Networking.swift
//  PinsOnMap
//
//  Created by Wojciech Charysz on 22.04.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import Foundation

/**
 This class is used to send asynchronous place query requests to musicbrainz.org API.
 
*/
class Networking {
    
    /// This is base URL of the musicbrainz.org API.
    static let baseURLString = "https://musicbrainz.org/ws/2/"
    
    /// This enum contains path to specific API requests. Currently it has only path for the place requests.
    enum ApiURL: String {
        case place = "place/?query="
    }
    
    /**
     This is JSONDecoder with date decoding set to ISO8601.
    */
    lazy var decoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        return jsonDecoder
    }()
    
    /**
     This is a private method to get raw URL API string for each case of the ApiURL enum.
    */
    private func getURLString(for type: ApiURL) -> String {
        let urlString = Networking.baseURLString + type.rawValue
        
        return urlString
    }
    
    /**
     This is a method to download "places" from the musicbrainz.org based on its names. Inside it's used URLSession to retrieve the content.
     
     - Parameter name: The text which contains the name of the place.
     - Parameter limit: The limit of the query result.
     - Parameter offset: The offset of the query.
     - Parameter completion: The completion closure.
     - Parameter places: The struct Places which represents parsed JSON result. It can be nil if there are no results or no connection to the server.
    */
    func downloadPlaces(forName name: String, queryLimit limit: Int, offsetNumber offset: Int, completion: @escaping (_ places: Places?) -> Void)  {
        var urlString = getURLString(for: .place) + name
        urlString += "&limit=" + String(limit)
        urlString += "&offset=" + String(offset)
        urlString += "&fmt=json"
        
        guard let url = URL(string: urlString) else {
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
