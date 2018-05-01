//
//  ViewController.swift
//  PinsOnMap
//
//  Created by Wojciech Charysz on 21.04.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let pinViewIdentifier = "pinViewIdentifier"
    
    lazy var viewModel: ViewModel = {
        return ViewModel(self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView.register(MKPinAnnotationView.self, forAnnotationViewWithReuseIdentifier: pinViewIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            return
        }
        
        let annotations = viewModel.mapPins.compactMap{$0}
        mapView.removeAnnotations(annotations)
        viewModel.downloadPlaces(forQuery: query)
        searchBar.resignFirstResponder()
    }
    
    //MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let pinView = mapView.dequeueReusableAnnotationView(withIdentifier: pinViewIdentifier, for: annotation) as? MKPinAnnotationView else {
            return nil
        }
        
        pinView.pinTintColor = MKPinAnnotationView.greenPinColor()
        pinView.canShowCallout = true
        
        return pinView
    }
}

