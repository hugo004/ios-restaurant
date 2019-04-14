//
//  MapViewController.swift
//  ios-restaurant
//
//  Created by rzc on 11/4/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit
import MapKit

class MapAnnotation: NSObject, MKAnnotation {
    var title: String!;
    var coordinate: CLLocationCoordinate2D;
    var location: CLLocation!;

    init(restaurant: Restaurant) {

        self.title = restaurant.name;
        let lat = CLLocationDegrees(restaurant.lat);
        let long = CLLocationDegrees(restaurant.long);
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long);
        self.location = CLLocation(latitude: lat, longitude: long);
    }
}

class MapViewModel {
    
    var restaurant: Restaurant!;
    var restaurantLocation: CLLocation!;
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant;
        
        let lat = CLLocationDegrees(restaurant.lat);
        let long = CLLocationDegrees(restaurant.long);
        self.restaurantLocation = CLLocation(latitude: lat, longitude: long);

    }
    
    func direction(startPlacemark: CLPlacemark, endPlacemark: CLPlacemark) -> MKDirections {
        
        let startPlacemarkMK = MKPlacemark(placemark: startPlacemark);
        let startItem = MKMapItem(placemark: startPlacemarkMK);
    
        let endPlacemarkMK = MKPlacemark(placemark: endPlacemark);
        let endItem = MKMapItem(placemark: endPlacemarkMK);
    
    
        let request = MKDirections.Request();
        request.source = startItem;
        request.destination = endItem;
        request.transportType = .automobile;
    
    //calculate direction
        let direction = MKDirections(request: request);
    
        return direction;
    }

}

class MapViewController: UIViewController, MKMapViewDelegate {

    var mapView: MKMapView!
    var model: MapViewModel!;
    var userLocation: CLLocation!;
    
    init(restaurant: Restaurant, userLocation: CLLocation) {
        super.init(nibName: nil, bundle: nil);
        self.userLocation = userLocation;
        model = MapViewModel(restaurant: restaurant);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMapView();
        
        self.navigationItem.title = Helper.Localized(key: "restaurant_map");
    }
    
    func initMapView() {
        

        
        mapView = MKMapView(frame: self.view.frame);
        mapView.delegate = self;
        mapView.mapType = .standard;
        mapView.userTrackingMode = .follow;
        
        self.view.addSubview(mapView);
        
        mapView.addAnnotation(MapAnnotation(restaurant: model.restaurant));
        
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000);
        mapView.setRegion(region, animated: true);
        
        displayPath(from: userLocation, to: model.restaurantLocation);
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        
        if (view.annotation?.isKind(of: MapAnnotation.self))! {
            let coordinate = view.annotation?.coordinate;
            
            let restaurantLocation = CLLocation(latitude: coordinate!.latitude , longitude: coordinate!.longitude);
            displayPath(from: mapView.userLocation.location!, to: restaurantLocation);
        }
        
    }
    

    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let location = userLocation.location;
        let coordinate = location!.coordinate;
        
        
        let radius = 100;
        let overlayCircle = MKCircle(center: coordinate, radius: CLLocationDistance(radius));
        mapView.addOverlay(overlayCircle);
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        //render path line
        if overlay.isKind(of: MKPolyline.self)
        {
            let pathRenderer = MKPolylineRenderer(overlay: overlay);
            pathRenderer.strokeColor = UIColor(red:0.94, green:0.42, blue:0.14, alpha:1.0);
            pathRenderer.lineWidth = 3;
            
            return pathRenderer;
        }
        
        //rendering circle color
        if overlay.isKind(of: MKCircle.self)
        {
            let circleRenderer = MKCircleRenderer(overlay: overlay);
            circleRenderer.strokeColor = UIColor(red:0.94, green:0.42, blue:0.14, alpha:1.0);
            circleRenderer.lineWidth = 1;
            
            circleRenderer.fillColor = UIColor(displayP3Red: 246, green: 149, blue: 114, alpha: 0.4);
            
            return circleRenderer;
        }
        
        return MKOverlayRenderer(overlay: overlay);
    }
    
    
    func displayPath(from: CLLocation, to: CLLocation) {
        let geoCoder = CLGeocoder();
        
        geoCoder.reverseGeocodeLocation(from) { (placemarks, error) in
            let fromMark = placemarks?.first;
            
            geoCoder.reverseGeocodeLocation(to, completionHandler: { (placemarks, error) in
                let toMark = placemarks?.first;
                
                let direction = self.model.direction(startPlacemark: fromMark!, endPlacemark: toMark!);
                direction.calculate(completionHandler: { (response, error) in
                    if error != nil {
                        print("calculate error", error.debugDescription);
                        return;
                    }
                    
                    let route = response?.routes.first;
                    self.mapView.addOverlay(route!.polyline, level: MKOverlayLevel.aboveRoads);
                    let region = MKCoordinateRegion((route?.polyline.boundingMapRect)!);
                    self.mapView.setRegion(region, animated: true);
                    
                })
            })
        }
    }
}
