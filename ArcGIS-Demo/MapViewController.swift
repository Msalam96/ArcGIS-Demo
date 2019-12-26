//
//  MapViewController.swift
//  ArcGIS-Demo
//
//  Created by Brandon Cortes on 12/20/19.
//  Copyright © 2019 BMS. All rights reserved.
//

import Foundation
import UIKit
import ArcGIS


class MapViewController : UIViewController {
    
    //make the map view variable
    var mapView: AGSMapView!
    private weak var activeSelectionQuery: AGSCancelable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //set background to purple
        view.backgroundColor = .purple
        
        
        //initialize and declare the mapview to a new map view
        mapView = AGSMapView()
        
        //set up the map
        setupMap()
        setupLocationDisplay()
        
        
        //set the view to the map view
        self.view = mapView
        
        //let navigationController = UINavigationController(rootViewController: self)
        //navigationController.tabBarItem.title = "Map"
        
        navigationItem.title = "Map"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(RefreshMap))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Current Location", style: .plain, target: self, action: #selector(setupLocationDisplay))
        
    
        
        
    }
    
    @objc private func RefreshMap() {
        //self.mapView.map?.basemap.load(completion: nil)
        self.mapView.map!.load(completion: nil)
        
        
    }
    
    private func setupMap() {
        mapView.map = AGSMap(basemapType: .navigationVector, latitude: 34.02700, longitude: -118.80543, levelOfDetail: 13)
        
        let featureServiceURL = URL(string: "https://services3.arcgis.com/GVgbJbqm8hXASVYi/arcgis/rest/services/Trailheads/FeatureServer/0")!
        let trailheadsTable = AGSServiceFeatureTable(url: featureServiceURL)
        mapView.map!.operationalLayers.add(AGSFeatureLayer(featureTable: trailheadsTable))
    }
    
    @objc func setupLocationDisplay() {
    mapView.locationDisplay.autoPanMode = AGSLocationDisplayAutoPanMode.compassNavigation
    
    mapView.locationDisplay.start { [weak self] (error:Error?) -> Void in
            if let error = error {
                self?.showAlert(withStatus: error.localizedDescription)
            }
        }
    }
        
    func showAlert(withStatus: String) {
        let alertController = UIAlertController(title: "Alert", message:
            withStatus, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
//    func geoView(_ geoView: AGSGeoView, didTapAtScreenPoint screenPoint: CGPoint, mapPoint: AGSPoint) {
//        //cancel the active query if it hasn't been completed yet
//        if let activeSelectionQuery = activeSelectionQuery {
//            activeSelectionQuery.cancel()
//        }
//
//        guard let map = mapView.map,
//            let featureLayer = featureLayer else {
//                return
//        }
//
//        //tolerance level
//        let toleranceInPoints: Double = 12
//        //use tolerance to compute the envelope for query
//        let toleranceInMapUnits = toleranceInPoints * mapView.unitsPerPoint
//        let envelope = AGSEnvelope(xMin: mapPoint.x - toleranceInMapUnits,
//                                   yMin: mapPoint.y - toleranceInMapUnits,
//                                   xMax: mapPoint.x + toleranceInMapUnits,
//                                   yMax: mapPoint.y + toleranceInMapUnits,
//                                   spatialReference: map.spatialReference)
//
//        //create query parameters object
//        let queryParams = AGSQueryParameters()
//        queryParams.geometry = envelope
//        
//        //run the selection query
//        activeSelectionQuery = featureLayer.selectFeatures(withQuery: queryParams, mode: .new) { [weak self] (queryResult: AGSFeatureQueryResult?, error: Error?) in
//            if let error = error {
//                self?.presentAlert(error: error)
//            }
//            if let result = queryResult {
//                print("\(result.featureEnumerator().allObjects.count) feature(s) selected")
//            }
//        }
//    }
}
