//
//  FriendLocationViewController.swift
//  FriendsBook
//
//  Created by adem.turkoglu on 6.06.2021.
//

import UIKit
import MapKit

class FriendLocationViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    var location: Geo?
    var person: Person! {
        didSet {
            location = person.address?.geo
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let latValue = Double(location?.lat ?? "0")
        let lngValue = Double(location?.lng ?? "0")
        let initialLocation = CLLocation(latitude: latValue!, longitude: lngValue!)
        let initialLocation2D = CLLocationCoordinate2D(latitude: latValue!, longitude: lngValue!)
        mapView.centerToLocation(initialLocation)
        let personAdress = PersonAddress(
            title: person.name,
            locationName: person.address?.zipcode,
          coordinate: initialLocation2D)
        mapView.addAnnotation(personAdress)
    }
}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
