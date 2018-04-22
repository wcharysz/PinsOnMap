//
//  Pin.swift
//  PinsOnMap
//
//  Created by Wojciech Charysz on 22.04.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import Foundation
import MapKit

class Pin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init?(_ place: Place) {
        guard let latitude = place.coordinates?.latitude, let longitude = place.coordinates?.longitude else {
            return nil
        }
        
        self.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        self.title = place.name
        self.subtitle = place.address
        
        super.init()
    }
    
}
