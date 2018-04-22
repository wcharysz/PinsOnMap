//
//  ViewModel.swift
//  PinsOnMap
//
//  Created by Wojciech Charysz on 22.04.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import Foundation

class ViewModel {
    
    unowned var delegate: ViewController
    
    init(_ viewController: ViewController) {
        delegate = viewController
    }
    
    func downloadPlaces(forQuery query: String, completion:@escaping (_ places: Places?) -> Void) {
        let networking = Networking()
        
        networking.downloadPlaces(forName: query) { (places) in
            completion(places)
        }
    }
    
}
