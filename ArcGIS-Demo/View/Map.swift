//
//  Map.swift
//  ArcGIS-Demo
//
//  Created by Brandon Cortes on 1/2/20.
//  Copyright © 2020 BMS. All rights reserved.
//

import Foundation
import ArcGIS

struct Map {
    
    var mapView: AGSMapView!
    var featureTable: AGSServiceFeatureTable!
    var featureLayer: AGSFeatureLayer!
    var lastQuery: AGSCancelable!
    var selectedFeature: AGSArcGISFeature!
    var featureServiceURL: String!
    
}
