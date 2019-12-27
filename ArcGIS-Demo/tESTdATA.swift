
import Foundation
import ArcGIS

public class TestData : NSObject {
    
    static let sharedTestData = TestData()
    private override init() {} // make sure no one outside can init this object.
    
    var isUserLoggedIn = false     // so other views can know login succeeded
    var portal:AGSPortal!          // if a user is logged in then this is the Portal
    
    let forceUserToLogin = false
    let useCustomLoginView = true
    let portalURL:String = "http://www.arcgis.com"
    let clientId:String = "e6Lfvlw05UccMiiU"
    
    // A list of basemaps on my AGOL account to use when we are not logged in
    // "image", "title", "itemId"
}
