//
//  AGS.swift
//  ArcGIS-Demo
//
//  Created by Mohammed Salam on 12/31/19.
//  Copyright © 2019 BMS. All rights reserved.
//

import Foundation
import ArcGIS

struct AGS {
    let clientID = "e6Lfvlw05UccMiiU"
    let redirectURL = "ArcGIS-Demo://auth"
    let portal = AGSPortal(url: URL(string: "https://www.arcgis.com")!, loginRequired: true)
    var activeChallenge:AGSAuthenticationChallenge?
}
