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
    
    lazy var openFrom: Date? = {
        var dateComponenets = DateComponents()
        dateComponenets.calendar = Calendar(identifier: .gregorian)
        dateComponenets.year = 1990
        
        return dateComponenets.date
    }()
    
    var places: [Places] = [] {
        didSet {
            places = places.filter({ (group) -> Bool in
                return group.places?.filter({ (place) -> Bool in
                    guard let begin = place
                    
                    return place.lifeSpan?.begin > openFrom
                })
            })
        }
    }
    
    func downloadPlaces(forQuery query: String, completion:@escaping (_ places: Places?) -> Void) {
        let networking = Networking()
        
        places.removeAll()
        
        networking.downloadPlaces(forName: query, queryLimit: 100, offsetNumber: <#T##Int#>, completion: <#T##(Places?) -> Void#>)

 
    }
    
}
