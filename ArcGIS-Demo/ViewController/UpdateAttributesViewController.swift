/*
import UIKit
import ArcGIS

class UpdateAttributesViewController: UIViewController, AGSGeoViewTouchDelegate, AGSCalloutDelegate {
    @IBOutlet private weak var mapView: AGSMapView!
    
    private var map: AGSMap!
    private var featureTable: AGSServiceFeatureTable!
    private var featureLayer: AGSFeatureLayer!
    private var lastQuery: AGSCancelable!
    
    private var types = ["Destroyed", "Major", "Minor", "Affected", "Inaccessible"]
    private var selectedFeature: AGSArcGISFeature!
    private let optionsSegueName = "OptionsSegue"
    
    private let featureServiceURL = "https://sampleserver6.arcgisonline.com/arcgis/rest/services/DamageAssessment/FeatureServer/0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.map = AGSMap(basemap: .oceans())
        //set initial viewpoint
        self.map.initialViewpoint = AGSViewpoint(center: AGSPoint(x: 544871.19, y: 6806138.66, spatialReference: .webMercator()), scale: 2e6)
        
        self.featureTable = AGSServiceFeatureTable(url: URL(string: featureServiceURL)!)
        let featureLayer = AGSFeatureLayer(featureTable: self.featureTable)
        
        self.map.operationalLayers.add(featureLayer)
        
        self.mapView.map = self.map
        self.mapView.touchDelegate = self
        
        //store the feature layer for later use
        self.featureLayer = featureLayer
    }
    
    func showCallout(_ feature: AGSFeature, tapLocation: AGSPoint?) {
        let title = feature.attributes["typdamage"] as! String
        self.mapView.callout.title = title
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
        }
    }

}
 */
