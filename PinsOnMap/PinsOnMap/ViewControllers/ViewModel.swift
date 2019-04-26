//
//  ViewModel.swift
//  PinsOnMap
//
//  Created by Wojciech Charysz on 22.04.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import Foundation

/**
 This is a class, which provides content for the ViewController.
*/
class ViewModel {
    
    /// A weak reference to the instance of the ViewController.
    unowned var delegate: ViewController
    
    init(_ viewController: ViewController) {
        delegate = viewController
    }
    
    /// The start date for the searched Places. It's set to 1990 year.
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
    
    /// A container for Places models. After it's set the array is filtered out of Places which are open earlier than the date defined by openFrom property. From the rest of the places are created Pin objects and added to the mapPins property.
    var places: [Places] = [] {
        didSet {
            let currentPlaces = places
            
            for place in currentPlaces {
                
                var filteredPlaces = place.places
                
                filteredPlaces?.removeAll(where: { (spot) -> Bool in
                    guard let begin = spot.lifeSpan?.begin, let openFrom = openFrom else {
                        return true
                    }
                    
                    return begin <= openFrom
                })
                
                if let newPins = filteredPlaces?.map({ (spot) -> Pin? in
                    return Pin(spot, openFrom: openFrom)
                }) {
                    mapPins.append(contentsOf: newPins)
                }
            }
        }
    }
    
    /// A container for Pin models. After it's set from the array are removed any nils and on the main DispatchQueue are added Pins and displayed. The next step is to schedule a timer which will remove the pins from the map view according to its lifeSpan.
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
                        let remaining = self.delegate.mapView.annotations
                        self.delegate.mapView.showAnnotations(remaining, animated: true)
                    })
                }
            }
        }
    }
    
    /** This method clears out properties for places and mapPins and downloads new places from the musicbrainz.org.
     
     - Parameter query: The text which should contain place's name.
    */
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
