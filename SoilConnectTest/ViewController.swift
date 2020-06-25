//
//  ViewController.swift
//  SoilConnectTest
//
//  Created by Adwait Y Sankhé on 6/24/20.
//  Copyright © 2020 Adwait Y Sankhé. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    private let mapView: MKMapView = MKMapView(frame: .zero)
    private let locationManager: CLLocationManager =  CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        setupAutoResizingMask()
        setupConstraints()
        setupInitialLocation()
        setupLocationManagerProperties()
        // Do any additional setup after loading the view.
    }
    
    private func addViews() {
        view.addSubview(mapView)
    }
    
    private func setupAutoResizingMask() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    private func setupInitialLocation() {
        let initialLocation = CLLocationCoordinate2D(latitude: 40.7579787, longitude: -73.9877366)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: initialLocation, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    private func setupLocationManagerProperties() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        let lastLocation = userLocation.coordinate
        let center = CLLocationCoordinate2D(latitude: lastLocation.latitude, longitude: lastLocation.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
    }
}
