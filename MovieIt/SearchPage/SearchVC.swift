//
//  SearchVC.swift
//  MovieIt
//
//  Created by 효우 on 2022/05/11.
//

import Foundation
import UIKit
import CoreLocation

class SearchVC: UIViewController, MTMapViewDelegate {
    
    var locationManager : CLLocationManager!

    
    @IBOutlet weak var locationSearchBar: UISearchBar!
    
    
    @IBOutlet var subView: UIView!
    var mapView: MTMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView = MTMapView(frame: subView.frame)
        mapView.delegate = self
        mapView.baseMapType = .standard
        self.view.addSubview(mapView)
        
        mapView.currentLocationTrackingMode = .onWithHeading
        mapView.showCurrentLocationMarker = true
        
        let poiItem1 = MTMapPOIItem()
        poiItem1.itemName = "롯데시네마 합정"
        poiItem1.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.55158, longitude: 126.91330))
        poiItem1.markerType = .redPin
        
        let poiItem2 = MTMapPOIItem()
        poiItem2.itemName = "롯데시네마 홍대"
        poiItem2.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.56064, longitude: 126.93057))
        poiItem2.markerType = .redPin
        
        mapView.addPOIItems([poiItem1, poiItem2])
        mapView.fitAreaToShowAllPOIItems()
        
        hideKeyboard()
    }
    
    
    
    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
        let currentLocation = location?.mapPointGeo()
        if let latitude = currentLocation?.latitude, let longitude = currentLocation?.longitude{
            print("MTMapView updateCurrentLocation (\(latitude),\(longitude)) accuracy (\(accuracy))")
        }
    }
    

        
}

extension SearchVC: UISearchBarDelegate {
    
}

extension SearchVC: CLLocationManagerDelegate {
    func getLocationUsagePermission() {
        self.locationManager.requestWhenInUseAuthorization()
    }

}

extension SearchVC {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: #selector(SearchVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc override func dismissKeyboard() {
        view.endEditing(true)
    }
}
