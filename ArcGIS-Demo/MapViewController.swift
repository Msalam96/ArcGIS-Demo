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
    
    var auth: AGS?
    
    var login = LoginViewController()
    
    //make the map view variable
    var mapView: AGSMapView!
    private weak var activeSelectionQuery: AGSCancelable?
    
    private var featureTable: AGSServiceFeatureTable!
    private var featureLayer: AGSFeatureLayer!
    private var lastQuery: AGSCancelable!
    
    private var types = ["Destroyed", "Major", "Minor", "Affected", "Inaccessible"]
    private var selectedFeature: AGSArcGISFeature!
    private let optionsSegueName = "OptionsSegue"
    
    private let featureServiceURL = "https://sampleserver6.arcgisonline.com/arcgis/rest/services/Earthquakes_Since1970/FeatureServer/0"
    //"https://sampleserver6.arcgisonline.com/arcgis/rest/services/DamageAssessment/FeatureServer/0"
    
    init(auth: AGS) {
        super.init(nibName: nil, bundle: nil)
        self.auth = auth
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
        //self.mapView.map?.basemap.load(completion: nil)
        self.mapView.map!.load(completion: nil)
        //var point = AGSPointBuilder(0,0)
        
        
        print(login.auth.portal.user?.fullName)
        
        
    }
    
    public func setupMap() {
        mapView.map = AGSMap(basemapType: .navigationVector, latitude: 34.02700, longitude: -118.80543, levelOfDetail: 13)
        
        self.featureTable = AGSServiceFeatureTable(url: URL(string: featureServiceURL)!)
        let featureLayer = AGSFeatureLayer(featureTable: self.featureTable)
        
        self.mapView.map!.operationalLayers.add(featureLayer)
        
        self.mapView.map = self.mapView.map
        self.mapView.touchDelegate = self
        
        //store the feature layer for later use
        self.featureLayer = featureLayer
        
        
    }
    
    @objc public func setupLocationDisplay() {
        mapView.locationDisplay.autoPanMode = AGSLocationDisplayAutoPanMode.recenter
    
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
