//
//  AppDelegate.swift
//  Stock Market App
//
//  Created by Truepicks on 11/21/23.
//

import UIKit
import Firebase
import AudioToolbox
import AVFoundation
import Firebase
import Purchases
import FBSDKCoreKit
import AVKit
import AVFoundation
import FirebaseDatabase
import FirebaseFirestore
import AppTrackingTransparency
import AdSupport
import NVActivityIndicatorView
import Mixpanel
import UXCam
import CioTracking
import CioMessagingPushAPN

var db : Firestore!

var didpurchase = Bool()
var uid = String()

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        uid = UIDevice.current.identifierForVendor!.uuidString
        
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        Mixpanel.initialize(token: "22e79ca1bdc322bc36769b78933e0258", trackAutomaticEvents: true)
         Mixpanel.mainInstance().track(event: "App Open")
        Mixpanel.mainInstance().identify(distinctId: uid);
        
        Settings.setAdvertiserTrackingEnabled(true)
        AppEvents.activateApp()

        // Override point for customization after ap
        Purchases.debugLogsEnabled = true
        Purchases.configure(withAPIKey: "appl_JzxPxCQFDhgpRHGaMPsFTBzViwR", appUserID: uid)
        Purchases.shared.delegate = self
        
        Purchases.shared.purchaserInfo { (purchaserInfo, error) in
            
            if purchaserInfo!.entitlements["Subscriptions"]?.isActive == true {
//               user has access to "your_entitlement_id"
                
                didpurchase = true
                UserDefaults.standard.set(true, forKey: "didPurchase")
                
            } else {

                didpurchase = false
                UserDefaults.standard.set(false, forKey: "didPurchase")


            }
        }
        
        
        FirebaseApp.configure()
        db = Firestore.firestore()
        
        Purchases.shared.purchaserInfo { (purchaserInfo, error) in
            if let purchaserInfo = purchaserInfo{
                
                
                if !purchaserInfo.entitlements.active.isEmpty {
                    
                    if purchaserInfo.entitlements.active.first?.value.periodType == .trial {
                        // here trail implementation
                        
                        
                    }else if purchaserInfo.entitlements.active.first?.value.periodType == .normal {
                        // here normal implementation
                        //here
                        AppEvents.logEvent(.purchased, parameters: ["":""])
                        
                        print("purchased")
                    }else if purchaserInfo.entitlements.active.first?.value.periodType == .intro {
                        // here intro implementation
                        
                    }else if purchaserInfo.entitlements.active.first?.value.periodType == .none {
                        // here none implementation
                        
                    }
                    //user has access to some entitlement
                    didpurchase = true
                    UserDefaults.standard.set(true, forKey: "didPurchase")
                } else {
                    
                    didpurchase = false
                    UserDefaults.standard.set(false, forKey: "didPurchase")


                }
            } else {
                
                didpurchase = false
                UserDefaults.standard.set(false, forKey: "didPurchase")


            }
        }
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")

        
        if launchedBefore  {
            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc : UITabBarController = mainStoryboardIpad.instantiateViewController(withIdentifier: "HomeTab") as! UITabBarController
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        } else {
            
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Onboarding1") as! UIViewController
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            
        }
        
        return true
    }
    // MARK: UISceneSession Lifecycle



}


extension AppDelegate: PurchasesDelegate {
    
    func purchases(_ purchases: Purchases, didReceiveUpdated purchaserInfo: Purchases.PurchaserInfo) {
        let purchaserInfo = purchaserInfo
        if !purchaserInfo.entitlements.active.isEmpty {
//            //user has access to some entitlement
            didpurchase = true
            UserDefaults.standard.set(true, forKey: "didPurchase")
        } else {
            
            didpurchase = false
            UserDefaults.standard.set(false, forKey: "didPurchase")



        }

    }
}
