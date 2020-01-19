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
    private let optionsSegueName = "OptionsSegue"
    //"https://sampleserver6.arcgisonline.com/arcgis/rest/services/DamageAssessment/FeatureServer/0"
    private var attributesArray : NSMutableDictionary?
    
    init(auth: AGS) {
        super.init(nibName: nil, bundle: nil)
        self.auth = auth
        //self.map.featureServiceURL = "https://sampleserver6.arcgisonline.com/arcgis/rest/services/Earthquakes_Since1970/FeatureServer/0"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set background to purple
        view.backgroundColor = .purple
        self.navigationItem.title = "Map"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Current Location", style: .plain, target: self, action: #selector(self.setupLocationDisplay))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(self.RefreshMap))
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        
        //license the app with the supplied License key
       do {
        let result = try AGSArcGISRuntimeEnvironment.setLicenseKey("runtimelite,1000,rud7613398925,none,D7MFA0PL4S6LLAMEY139")
        print("License Result : \(result.licenseStatus)")
       }
       catch let error as NSError {
        print("error: \(error)")
       }
        
        //initialize and declare the mapview to a new map view
        mapView = AGSMapView()
        
        mapView.wrapAroundMode = AGSWrapAroundMode.enabledWhenSupported
        
        
        //set up the map
        setupMap()
        //set the view to the map view
        self.view = mapView
    }
    
    //MARK: Refresh map
    @objc public func RefreshMap() {
        
        let portalItem = AGSPortalItem(portal: auth!.portal, itemID: "cac570efac634702ac08aa6022220738")
        let frameSize: CGPoint = CGPoint(x: UIScreen.main.bounds.size.width*0.5,y: UIScreen.main.bounds.size.height*0.5)
        
        let screenlocation = mapView.screen(toLocation: frameSize)
        
        //releases the map in memory
        mapView.map = nil
        
        //make a new map and assign it
        let portalMap = AGSMap(item: portalItem)
        self.mapView.setViewpointCenter(screenlocation, completion: nil)
        mapView.map = portalMap
        
        let newBasemapLayer = AGSBasemap(item: portalItem)
        self.mapView.map?.basemap = newBasemapLayer
        
        self.featureTable = AGSServiceFeatureTable(url: URL(string: featureServiceURL)!)
        let featureLayer = AGSFeatureLayer(featureTable: self.featureTable)
        
        self.mapView.map!.operationalLayers.add(featureLayer)
    }
    
    //MARK: Setup mapa
    public func setupMap() {
        
        let portalItem = AGSPortalItem(portal: auth!.portal, itemID: "cac570efac634702ac08aa6022220738")
        let portalMap = AGSMap(item: portalItem)
        portalMap.basemap = .navigationVector()
        
        // set the map to be displayed in an AGSMapView
        mapView.map = portalMap
        
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
    func showCallout(_ feature: AGSFeature, tapLocation: AGSPoint?, isTrue: Bool) {
        let title = feature.attributes["name"] as! String
        self.mapView.callout.title = title
        //self.mapView.callout.isAccessoryButtonHidden = false
        
        var detailString = ""
        for(key,value) in feature.attributes {
            detailString += "\(key): \(value)\n"
        }
        self.mapView.callout.detail = detailString
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 160, y: 285)
        label.textAlignment = .center
        label.text = "I'm a test label"
        
        let tableView = DetailViewController(attributesDictionary: feature.attributes)
        tableView.reloadData()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        self.mapView.callout.customView = tableView
        
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
                self?.showCallout(feature, tapLocation: mapPoint, isTrue: true)
                //update selected feature
                self?.selectedFeature = feature
            }
            else
            {
                print("didnt tap on feature")
                self?.mapView.callout.customView = nil
                //if the callout is not shown, show the callout with the coordinates of the tapped location
                if self?.mapView.callout.isHidden ?? false {
                    self?.mapView.callout.title = "Location"
                    self?.mapView.callout.detail = String(format: "x: %.2f, y: %.2f", mapPoint.x, mapPoint.y)
                    //self?.mapView.callout.isAccessoryButtonHidden = false
                    self?.mapView.callout.show(at: mapPoint, screenOffset: CGPoint.zero, rotateOffsetWithMap: false, animated: true)
                } else {  //hide the callout
                    self?.mapView.callout.dismiss()
                }
            }
        }
    }
}
