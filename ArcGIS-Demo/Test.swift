import UIKit
import ArcGIS

class Test: UIViewController, UITextFieldDelegate, AGSAuthenticationManagerDelegate {

    var activeChallenge:AGSAuthenticationChallenge?
    var authenticationManager:AGSAuthenticationManager = AGSAuthenticationManager.shared()
    var isLoggingIn:Bool = false
    var isKeyboardShowing = false
    var testData:TestData = TestData.sharedTestData;
    var lastSelectedPortalItem:Int = 0
    
    private let credential = AGSCredential(user: "brandontod97", password: "wyrsuz-wyhwo6-Wefmyw")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.authenticationManager.delegate = self
        self.setupOAuth()
        self.continueLoginWithCredentials()
    }


    /**
     * didReceiveAuthenticationChallenge is called by AGSAuthenticationManager when it needs to ask the user
     * to authenticate.
     */
    func authenticationManager(_ authenticationManager: AGSAuthenticationManager, didReceive challenge: AGSAuthenticationChallenge) {
        
        print("didReceiveAuthenticationChallenge asking to login with " + self.authenticationTypeFromChallengeType(challengeType: challenge.type) + " authentication")
        self.activeChallenge = challenge
        switch challenge.type {
            
        case AGSAuthenticationChallengeType.oAuth:
             self.activeChallenge!.continueWithDefaultHandling()
            
        case AGSAuthenticationChallengeType.clientCertificate,
             AGSAuthenticationChallengeType.usernamePassword,
             AGSAuthenticationChallengeType.untrustedHost:
            self.isLoggingIn = true
            if self.testData.useCustomLoginView {
                print("Using custom challenge handler")
            } else {
                print("Using default challenge handler")
                self.activeChallenge!.continueWithDefaultHandling()
            }
            
        default:
            print("Unknown challenge handler")
        }
    }
    
    func setupOAuth() {
        let oauthConfiguration = AGSOAuthConfiguration(portalURL: NSURL(string: self.testData.portalURL)! as URL, clientID: self.testData.clientId, redirectURL: "ArcGIS-Demo://auth")
        authenticationManager.oAuthConfigurations.add(oauthConfiguration)
    }

    func getOrCreatePortal () -> AGSPortal {
        if (self.testData.portal == nil) {
            self.testData.portal = AGSPortal (url: NSURL(string: self.testData.portalURL)! as URL, loginRequired: false)
//            self.testData.portal.credential = AGSCredential(user: "theUser", password: "thePassword")
        }
        print(testData.portal)
        return self.testData.portal
    }
    
    /**
     * Force a login to the Po rtal.
     */
    func loginToPortal () {
        
        self.getOrCreatePortal()
        self.testData.portal.load() { (error) in
            if error == nil {
                if self.testData.portal.loadStatus == AGSLoadStatus.loaded {
                    print("Logged in to portal " + self.testData.portalURL)
//                    let fullName = self.testData.portal.user?.fullName
                    self.testData.portal.credential = self.credential
                    //print(self.testData.portal.user?.fullName)
                    self.userIsLoggedIn()
                } else {
                    print("There was an error loading the portal status: \(self.testData.portal.loadStatus)")
                }
            } else {
                print("There was an error loading the portal: " + error.debugDescription)
            }
            self.isLoggingIn = false
        }
    }

    /**
     * Map an AGS authentication challenge type id into a human readable string to show in the UI. We choose
     * to use strings that match the documentation.
     */
    func authenticationTypeFromChallengeType (challengeType:AGSAuthenticationChallengeType) -> String {

        switch challengeType {
        case AGSAuthenticationChallengeType.oAuth:
            return "OAuth"
        case AGSAuthenticationChallengeType.usernamePassword:
            return "ArcGIS Token"
        case AGSAuthenticationChallengeType.untrustedHost:
            return "HTTP"
        case AGSAuthenticationChallengeType.clientCertificate:
            return "PKI"
        default:
            return "unknown"
        }
    }
    
    /**
     * Do things required by our app to maintain the user in a logged in state
     */
    func userIsLoggedIn () {
        self.testData.isUserLoggedIn = true
        //print(self.testData.portal.user?.fullName)
        //self.loginButton.setTitle("Log out", forState: UIControlState.Normal)
    }
    
    /**
     * Do things required by our app to log out the user
     */
    func userIsLoggedOut () {
        self.authenticationManager.credentialCache.removeAllCredentials()
        self.testData.portal = nil
        self.testData.isUserLoggedIn = false
        //self.loginButton.setTitle("Log in", forState: UIControlState.Normal)
        //self.logAppInfo("Logout complete - credentials cleared.")
    }
    
    func continueLoginWithCredentials () {
        
        print("continue login with credential")
        //self.startLoginActivity()
        let credential = AGSCredential(user: "brandontod97", password: "wyrsuz-wyhwo6-Wefmyw")
        if self.activeChallenge != nil {
            print("Trying to login for " + self.authenticationTypeFromChallengeType(challengeType: (self.activeChallenge?.type)!) + " authentication")
            self.activeChallenge!.continue(with: credential)
        } else {
            // Here we should do an unsolicited login
            print("active challenge is nil: sending you to portal")
            self.loginToPortal()
        }
    }
    
}
