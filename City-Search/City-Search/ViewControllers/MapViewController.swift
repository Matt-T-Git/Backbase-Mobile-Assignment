//
//  MapViewController.swift
//  City-Search
//
//  Created by Mathew Thomas on 02/02/2021.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var coordinate: Coord?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Center map on city
        let cityLocation = CLLocationCoordinate2D(latitude: coordinate?.lat ?? 0.000, longitude: coordinate?.lon ?? 0.000)
        let region = MKCoordinateRegion( center: cityLocation, latitudinalMeters: CLLocationDistance(exactly: 5000)!, longitudinalMeters: CLLocationDistance(exactly: 5000)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
}
