/*
 
 
 
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


 class MapViewController : UIViewController,AGSGeoViewTouchDelegate, AGSCalloutDelegate {
     
     //models
     var auth: AGS?
     var map: Map!
     
     //make the map view variable
     var mapView: AGSMapView!
     private var featureTable: AGSServiceFeatureTable!
     private var featureLayer: AGSFeatureLayer!
     private var lastQuery: AGSCancelable!
     private var selectedFeature: AGSArcGISFeature!
     private let featureServiceURL = "https://sampleserver6.arcgisonline.com/arcgis/rest/services/Earthquakes_Since1970/FeatureServer/0"
     //"https://sampleserver6.arcgisonline.com/arcgis/rest/services/DamageAssessment/FeatureServer/0"
     
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
     
     @objc public func RefreshMap() {
         
         let portalItem = AGSPortalItem(portal: auth!.portal, itemID: "2f1fd68a58a14656bd6625cd681873e5")
         let frameSize: CGPoint = CGPoint(x: UIScreen.main.bounds.size.width*0.5,y: UIScreen.main.bounds.size.height*0.5)
         
         var screenlocation = mapView.screen(toLocation: frameSize)
         
         let portalMap = AGSMap(item: portalItem)
         self.mapView.setViewpointCenter(screenlocation, completion: nil)
         mapView.map = portalMap
         
     
         let newBasemapLayer = AGSBasemap(item: portalItem)
         self.mapView.map?.basemap = newBasemapLayer
         
     }
     
     public func setupMap() {
         
         let portalItem = AGSPortalItem(portal: auth!.portal, itemID: "2f1fd68a58a14656bd6625cd681873e5")
         
         //8dda0e7b5e2d4fafa80132d59122268c
         //ce8a38475bc0443aaac04b025b522494
         
         let portalMap = AGSMap(item: portalItem)
         
         portalMap.basemap = .navigationVector()
         //self.setupLocationDisplay()
         
          // set the map to be displayed in an AGSMapView
         mapView.map = portalMap
         
         //let map = AGSMap(basemapType: .navigationVector, latitude: 34.02700, longitude: -118.80543, levelOfDetail: 13)
         //let basemap = AGSBasemapType(.navigationVector)
         
         //remove the existing basemap layer
         //self.mapView.removeMapLayerWithName(kBasemapLayerName)
         
         //add new Layer
         let newBasemapLayer = AGSBasemap(item: portalItem)
         
         self.mapView.map?.basemap = newBasemapLayer
         self.mapView.map?.basemap = .streetsNightVector()
         
         //self.mapView.insertMapLayer(newBasemapLayer, withName: kBasemapLayerName, atIndex: 0);
         
         
         
         
         self.featureTable = AGSServiceFeatureTable(url: URL(string: featureServiceURL)!)
         let featureLayer = AGSFeatureLayer(featureTable: self.featureTable)
         
         self.mapView.map!.operationalLayers.add(featureLayer)
         
         self.mapView.map = self.mapView.map
         self.mapView.touchDelegate = self
         
         //store the feature layer for later use
         self.featureLayer = featureLayer
         
         
     }
     
     //MARK: setup location display
     @objc public func setupLocationDisplay() {
         mapView.locationDisplay.autoPanMode = AGSLocationDisplayAutoPanMode.recenter
     
     mapView.locationDisplay.start { [weak self] (error:Error?) -> Void in
             if let error = error {
                 self?.showAlert(withStatus: error.localizedDescription)
             }
         }
     }
         
     //MARK: Show alert
     func showAlert(withStatus: String) {
         let alertController = UIAlertController(title: "Alert", message:
             withStatus, preferredStyle: UIAlertController.Style.alert)
         alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
         present(alertController, animated: true, completion: nil)
     }
     
     //MARK: Show Callout
     func showCallout(_ feature: AGSFeature, tapLocation: AGSPoint?) {
         let title = feature.attributes["name"] as! String
         print(feature.attributes)
         self.mapView.callout.title = title
         self.mapView.callout.isAccessoryButtonHidden = true
         self.mapView.callout.detail = "x: \(feature.attributes["latitude"] ?? "Unknown") - y: \(feature.attributes["longitude"] ?? "Unknown")"
         self.mapView.callout.delegate = self
         self.mapView.callout.show(for: feature, tapLocation: tapLocation, animated: true)
     }
     
     // MARK: - AGSGeoViewTouchDelegate
     func geoView(_ geoView: AGSGeoView, didTapAtScreenPoint screenPoint: CGPoint, mapPoint: AGSPoint) {
         
         if let lastQuery = self.lastQuery {
             lastQuery.cancel()
         }
         
         //hide the callout
         self.mapView.callout.dismiss()
         
         self.lastQuery = self.mapView.identifyLayer(self.featureLayer, screenPoint: screenPoint, tolerance: 12, returnPopupsOnly: false, maximumResults: 1) { [weak self] (identifyLayerResult: AGSIdentifyLayerResult) in
             if let error = identifyLayerResult.error {
                 print(error)
             } else if let features = identifyLayerResult.geoElements as? [AGSArcGISFeature],
                 let feature = features.first {
                 //show callout for the first feature
                 self?.showCallout(feature, tapLocation: mapPoint)
                 //update selected feature
                 self?.selectedFeature = feature
             }
             else
             {
                 print("didnt tap on feature")
                 
                 //if the callout is not shown, show the callout with the coordinates of the tapped location
                 if self?.mapView.callout.isHidden ?? false {
                     self?.mapView.callout.title = "Location"
                     self?.mapView.callout.detail = String(format: "x: %.2f, y: %.2f", mapPoint.x, mapPoint.y)
                     self?.mapView.callout.isAccessoryButtonHidden = true
                     self?.mapView.callout.show(at: mapPoint, screenOffset: CGPoint.zero, rotateOffsetWithMap: false, animated: true)
                 } else {  //hide the callout
                     self?.mapView.callout.dismiss()
                 }
             }
         }
     }
 }

 
 
 
 */




/*
 
 
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


 class MapViewController : UIViewController,AGSGeoViewTouchDelegate, AGSCalloutDelegate {
     
     //models
     var auth: AGS?
     var mapplication: MapViewModel!
     
     init(auth: AGS) {
         super.init(nibName: nil, bundle: nil)
         self.auth = auth
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         //set background to purple
         view.backgroundColor = .purple
         
         //make new mapviewmodel
         mapplication = MapViewModel(auth: self.auth!)
         
         //run setup on the map
         mapplication.setupMap()
         
         //set the touch delegate to this class
         mapplication.mapplication.mapView.touchDelegate = self
         
         //set the callout delegate to this class
         mapplication.mapplication.mapView.callout.delegate = self
         
         //set the initial location to the users location
         mapplication.setupLocationDisplay()
         
         //set the view to the map view
         self.view = mapplication.mapplication.mapView
         
     }
     
     @objc public func RefreshMap() {
         mapplication.RefreshMap()
     }
     
     //MARK: setup location display
     @objc public func setupLocationDisplay() {
         mapplication.setupLocationDisplay()
     }
         
     //MARK: Show alert
     func showAlert(withStatus: String) {
         present(mapplication.showAlert(withStatus: withStatus), animated: true, completion: nil)
     }
     
 }

 
 
 */
