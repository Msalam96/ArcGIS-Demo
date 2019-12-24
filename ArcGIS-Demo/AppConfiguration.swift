//
//  AppConfiguration.swift
//  ArcGIS-Demo
//
//  Created by Mohammed Salam on 12/20/19.
//  Copyright © 2019 BMS. All rights reserved.
//

import Foundation

struct AppConfiguration {
    static let trafficLayerURL = URL(string: "https://traffic.arcgis.com/arcgis/rest/services/World/Traffic/MapServer")!
    static let clientID: String = "e6Lfvlw05UccMiiU"
    static let urlScheme: String = "ArcGIS-Demo"
    static let urlAuthPath: String = "ArcGIS-Demo://auth"
    static let keychainIdentifier: String = "\(Bundle.main.bundleIdentifier!).keychainIdentifier"
}
