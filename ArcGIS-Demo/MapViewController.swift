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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //set background to purple
        view.backgroundColor = .purple
        
        //initialize and declare the mapview to a new map view
        mapView = AGSMapView()
        
        //set up the map
        setupMap()
        
        //set the view to the map view
        self.view = (mapView)
        
        
        
        
        
        
        
        
    }
    
    private func setupMap() {
        mapView.map = AGSMap(basemapType: .navigationVector, latitude: 34.02700, longitude: -118.80543, levelOfDetail: 13)
        
        let featureServiceURL = URL(string: "https://services3.arcgis.com/GVgbJbqm8hXASVYi/arcgis/rest/services/Trailheads/FeatureServer/0")!
        let trailheadsTable = AGSServiceFeatureTable(url: featureServiceURL)
        mapView.map!.operationalLayers.add(AGSFeatureLayer(featureTable: trailheadsTable))
    }
}
