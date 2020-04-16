//
//  MapViewModel.swift
//  ArcGIS-Demo
//
//  Created by Brandon Cortes on 12/31/19.
//  Copyright © 2019 BMS. All rights reserved.
//

import Foundation
import ArcGIS

struct MapViewModel{

    var mapplication: Map!
    var auth: AGS!
    /*
     
     //make the map view variable
     var mapView: AGSMapView!
     private var featureTable: AGSServiceFeatureTable!
     private var featureLayer: AGSFeatureLayer!
     private var lastQuery: AGSCancelable!
     private var selectedFeature: AGSArcGISFeature!
     private let featureServiceURL = "https://sampleserver6.arcgisonline.com/arcgis/rest/services/Earthquakes_Since1970/FeatureServer/0"
     
     init(auth: AGS) {
         super.init(nibName: nil, bundle: nil)
         self.auth = auth
         self.map.featureServiceURL = "https://sampleserver6.arcgisonline.com/arcgis/rest/services/Earthquakes_Since1970/FeatureServer/0"
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         //set background to purple
         view.backgroundColor = .purple
         
         
         //initialize and declare the mapview to a new map view
         mapView = AGSMapView()
         
         //set up the map
         setupMap()
         
         //setupLocationDisplay()
         
         
         //set the view to the map view
         self.view = mapView
         
     }
     

     */
    
    init(auth: AGS) {
        //super.init(nibName: nil, bundle: nil)
        self.auth = auth
        self.mapplication.featureServiceURL = "https://sampleserver6.arcgisonline.com/arcgis/rest/services/Earthquakes_Since1970/FeatureServer/0" ?? "https://sampleserver6.arcgisonline.com/arcgis/rest/services/Earthquakes_Since1970/FeatureServer/0"
    }

    //MARK: Setup map
    public mutating func setupMap() {
        
        //create new mapview
        mapplication.mapView = AGSMapView()
        
        //create new portal with item id
        let portalItem = AGSPortalItem(portal: auth!.portal, itemID: "2f1fd68a58a14656bd6625cd681873e5")
        
        //additional item IDs for other web maps
        //8dda0e7b5e2d4fafa80132d59122268c
        //ce8a38475bc0443aaac04b025b522494
        
        //load in a map using the portal
        let portalMap = AGSMap(item: portalItem)
        
        // set the map to be displayed in an AGSMapView
        mapplication.mapView.map = portalMap

        //create the new basemap layer to display
        let baseMapLayer = AGSBasemap(item: portalItem)
        
        //add the new basemap layer to the map
        mapplication.mapView.map?.basemap = baseMapLayer
        
        //create new feature table with a given url
        mapplication.featureTable = AGSServiceFeatureTable(url: URL(string: mapplication.featureServiceURL)!)
        
        //the feature layer
        let featureLayer = AGSFeatureLayer(featureTable: mapplication.featureTable)
        
        //add the feature layer to the map
        mapplication.mapView.map!.operationalLayers.add(featureLayer)
        
        //////mapplication.mapView.touchDelegate = self
        
        //store the feature layer for later use
        mapplication.featureLayer = featureLayer
    }
    
    //MARK: Refresh map
    public func RefreshMap() {
        //the portal item
        let portalItem = AGSPortalItem(portal: auth!.portal, itemID: "2f1fd68a58a14656bd6625cd681873e5")
        
        //the screen size
        let frameSize: CGPoint = CGPoint(x: UIScreen.main.bounds.size.width*0.5,y: UIScreen.main.bounds.size.height*0.5)
        
        // center point of the screen
        let screenlocation = mapplication.mapView.screen(toLocation: frameSize)
        
        //load a new map from the portal
        let portalMap = AGSMap(item: portalItem)
        
        //set the point of the map view to the location representing the center of the screen from above
        mapplication.mapView.setViewpointCenter(screenlocation, completion: nil)
        
        //set the map to the newly loaded map
        mapplication.mapView.map = portalMap
        
        //load a new basemap form the portal
        let newBasemapLayer = AGSBasemap(item: portalItem)
        
        //set the basemap to the newly loaded basemap
        mapplication.mapView.map?.basemap = newBasemapLayer
    }
    
    //MARK: setup location display
    func setupLocationDisplay() {
        
        //set the location to pan to your current location
        mapplication.mapView.locationDisplay.autoPanMode = AGSLocationDisplayAutoPanMode.recenter
    
        //start the location display
        mapplication.mapView.locationDisplay.start { (error:Error?) -> Void in }
    }
        
    //MARK: Show alert
    func showAlert(withStatus: String) -> UIAlertController {
        
        //make a new alert controller
        let alertController = UIAlertController(title: "Alert", message:
            withStatus, preferredStyle: UIAlertController.Style.alert)
        
        //add an action to the alert controller
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
        
        //return it to the viewcontroller to present
        return alertController
        //////present(alertController, animated: true, completion: nil)
    }
    
    //MARK: Show Callout
    func showCallout(_ feature: AGSFeature, tapLocation: AGSPoint?) {
        
        //get the string for the title
        let title = feature.attributes["name"] as! String
        
        //set the callout title to the title variable
        mapplication.mapView.callout.title = title
        
        //hide the acessory button
        mapplication.mapView.callout.isAccessoryButtonHidden = true
        
        //set the details for the callout
        mapplication.mapView.callout.detail = "x: \(feature.attributes["latitude"] ?? "Unknown") - y: \(feature.attributes["longitude"] ?? "Unknown")"
        
        //set the delegate
        //////self.mapView.callout.delegate = self
        mapplication.mapView.callout.show(for: feature, tapLocation: tapLocation, animated: true)
    }
    
    // MARK: - AGSGeoViewTouchDelegate
    mutating func geoView(_ geoView: AGSGeoView, didTapAtScreenPoint screenPoint: CGPoint, mapPoint: AGSPoint) {
        
        //the last query
        if let lastQuery = mapplication.lastQuery {
            lastQuery.cancel()
        }
        
        //hide the callout
        mapplication.mapView.callout.dismiss()
        
        /*
        
        //set the last query equal to the current query
        self.mapplication.lastQuery = self.mapplication.mapView.identifyLayer(self.mapplication.featureLayer, screenPoint: screenPoint, tolerance: 12, returnPopupsOnly: false, maximumResults: 1) { (identifyLayerResult: AGSIdentifyLayerResult) in
            if let error = identifyLayerResult.error {
                print(error)
            } else if let features = identifyLayerResult.geoElements as? [AGSArcGISFeature],
                let feature = features.first {
                
                //show callout for the first feature
                self.showCallout(feature, tapLocation: mapPoint)
                
                //update selected feature
                self.mapplication.selectedFeature = feature
            }
            else
            {
                print("didnt tap on feature")
                
                //if the callout is not shown, show the callout with the coordinates of the tapped location
                if self.mapplication?.mapView.callout.isHidden ?? false {
                    self.mapplication?.mapView.callout.title = "Location"
                    self.mapplication?.mapView.callout.detail = String(format: "x: %.2f, y: %.2f", mapPoint.x, mapPoint.y)
                    self.mapplication?.mapView.callout.isAccessoryButtonHidden = true
                    self.mapplication?.mapView.callout.show(at: mapPoint, screenOffset: CGPoint.zero, rotateOffsetWithMap: false, animated: true)
                } else {  //hide the callout
                    self.mapplication?.mapView.callout.dismiss()
                }
            }
        }
 
         */
    }
    
    
}
