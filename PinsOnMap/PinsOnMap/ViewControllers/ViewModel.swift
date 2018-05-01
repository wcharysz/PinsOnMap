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
    
    let queryLimit = 100
    let queryOffset = 20
    
    var numberOfQueries: Int {
        return queryLimit / queryOffset
    }
    
    var places: [Places] = [] {
        didSet {
            let currentPlaces = places
            
            for place in currentPlaces {
                
                let filteredPlaces = place.places?.filter({ (spot) -> Bool in
                    guard let begin = spot.lifeSpan?.begin, let openFrom = openFrom else {
                        return false
                    }
                    
                    return begin >= openFrom
                })
                
                if let newPins = filteredPlaces?.map({ (spot) -> Pin? in
                    return Pin(spot, openFrom: openFrom)
                }) {
                    mapPins.append(contentsOf: newPins)
                }
            }
        }
    }
    
    var mapPins: [Pin?] = [] {
        didSet {
            let currentPins = mapPins
            let annotations = currentPins.compactMap{$0}
            
            DispatchQueue.main.async {
                self.delegate.mapView.addAnnotations(annotations)
                self.delegate.mapView.showAnnotations(annotations, animated: true)
                
                for annotation in annotations {
                    Timer.scheduledTimer(withTimeInterval: annotation.lifeSpan, repeats: false, block: { (timer) in
                        self.delegate.mapView.removeAnnotation(annotation)
                    })
                }
            }
        }
    }
    
    func downloadPlaces(forQuery query: String) {
        let networking = Networking()
        
        places.removeAll()
        mapPins.removeAll()
        
        for offset in 0...numberOfQueries {
            networking.downloadPlaces(forName: query, queryLimit: 100, offsetNumber: offset) { (places) in
                if let newPlaces = places {
                    self.places.append(newPlaces)
                }
            }
        }
    }
    
}
