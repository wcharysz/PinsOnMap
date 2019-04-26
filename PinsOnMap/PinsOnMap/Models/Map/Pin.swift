//
//  Pin.swift
//  PinsOnMap
//
//  Created by Wojciech Charysz on 22.04.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import Foundation
import MapKit

/**
 This is a model of map's pin based on the Place struct. It implements MKAnnotation protocol.
*/
class Pin: NSObject, MKAnnotation {
    
    /// The latitude and longitude associated with the Place location.
    var coordinate: CLLocationCoordinate2D
    
    /// A title of the pin. It's displayed when the user taps on the pin. The title represents a name of the Place.
    var title: String?
    
    /// A subtile of the pin. It's displayed together with the title. The subtitle represents an address of the Place.
    var subtitle: String?
    
    /// A life span of the pin. It defines how long the pin will be displayed on the map. The default value is 30 seconds.
    var lifeSpan: TimeInterval = 30
    
    /**
     The custom initialisation method of the Pin class.
     
     In this method is calculated:
     - The location of the pin. If one of the coordinates is missing then the Pin isn't created and the method returns nil.
     - The life span of the pin based on how many years is the Place opened. Each year counts for 1s to the life span.
     
     - Parameter place: The Place struct which contains necessary information.
     - Parameter openFrom: The date when the Place was first time opened.
     
    */
    init?(_ place: Place?, openFrom: Date?) {
        
        guard let latitudeString = place?.coordinates?.latitude,
            let latitude = Double(latitudeString),
            let longitudeString = place?.coordinates?.longitude,
            let longitude = Double(longitudeString) else {
            return nil
        }
        
        self.coordinate = CLLocationCoordinate2DMake(latitude, longitude) 
        self.title = place?.name
        self.subtitle = place?.address
        
        if let openFrom = openFrom, let begin = place?.lifeSpan?.begin {
            let components = Calendar.current.dateComponents([.year], from: openFrom, to: begin)
            self.lifeSpan = TimeInterval(components.year ?? 30)
        }
        
        super.init()
    }
    
}
