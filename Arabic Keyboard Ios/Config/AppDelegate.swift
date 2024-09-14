//
//  AppDelegate.swift
//  Arabic Keyboard Ios
//
//  Created by Viprak-Monil on 19/03/24.
//

import UIKit
import SwiftyStoreKit
import RevenueCat
import GoogleMobileAds
import Firebase
import FirebaseCrashlytics

@main
class AppDelegate: UIResponder, UIApplicationDelegate, PurchasesDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        let translateScreen = TranslateScreen()
        translateScreen.preloadTranslatorModels()
        // Override point for customization after application launch.
        GADMobileAds.sharedInstance().start(completionHandler: nil)
       // GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers =
          //  [ "208ecb08b3e0601e41c121828ca3df2b" ]
//        if UserDefaults.standard.bool(forKey: subscription) == true{
//            print("subscription active")
//        }
//        else{
           AppOpenAdManager.shared.loadAd()
//        }
        
        Purchases.configure(
            with: Configuration.Builder(withAPIKey: "appl_dFzfqyjYZQzScNjlzxktnJnNiGc")
                .with(usesStoreKit2IfAvailable: true)
                .build()
        )
        Purchases.shared.delegate = self       
        // getInAppPrice()
        getInPrice()
       
//        fatalError("Crash was triggered")
        return true
    }
    
    // MARK: GET
    
    func getInPrice(){
        Purchases.shared.getOfferings { offering, error in
            guard let offers = offering else { return }
            let planName = ["unlock_Feature_Monthly", "unlock_Feature_Yearly"]
            for i in 0..<(offering?.current?.availablePackages.count ?? 0) {
                UserDefaults.standard.set(offering?.current?.availablePackages[i].localizedPriceString, forKey: planName[i])
                UserDefaults.standard.synchronize()
            }
        }
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            if customerInfo?.activeSubscriptions.isEmpty == true {
                UserDefaults.standard.set(false, forKey: subscription)
                UserDefaults.standard.set("Nothing", forKey: activePlanName)
            } else {
                Purchases.shared.syncPurchases { (customerInfo, error) in
                    if customerInfo?.activeSubscriptions.isEmpty == true {
                        UserDefaults.standard.set(false, forKey: subscription)
                        UserDefaults.standard.set("Nothing", forKey: activePlanName)
                        
                    } else {
                        UserDefaults.standard.set(true, forKey: subscription)
                        UserDefaults.standard.set(customerInfo?.activeSubscriptions.first, forKey:activePlanName)
                    }
                }
            }
        }
        
    }
    
//    func getInAppPrice() {
//        Purchases.shared.getOfferings { offering, error in
//            guard let offers = offering else { return }
////            let planName = ["monthly_pro"]
//            for i in 0..<(offering?.current?.availablePackages.count ?? 0) {
//                UserDefaults.standard.set(offering?.current?.availablePackages[i].localizedPriceString, forKey: offering?.current?.availablePackages[i].storeProduct.productIdentifier ?? "")
//                UserDefaults.standard.synchronize()
//            }
//        }
//        Purchases.shared.getCustomerInfo { (customerInfo, error) in
//            if customerInfo?.activeSubscriptions.isEmpty == true {
//                UserDefaults.standard.set(false, forKey: subscription)
//                UserDefaults.standard.set("Nothing", forKey: activePlanName)
//            } else {
//                Purchases.shared.syncPurchases { (customerInfo, error) in
//                    if customerInfo?.activeSubscriptions.isEmpty == true {
//                        UserDefaults.standard.set(false, forKey: subscription)
//                        UserDefaults.standard.set("Nothing", forKey: activePlanName)
//                    } else {
//                        UserDefaults.standard.set(true, forKey:subscription)
//                        UserDefaults.standard.set(customerInfo?.activeSubscriptions.first, forKey: activePlanName)
//                    }
//                }
//            }
//        }
//    }
    
//    func getInAppPrice() {
//        Purchases.shared.getOfferings { offering, error in
//            guard let offers = offering else { return }
//            for i in 0..<(offering?.current?.availablePackages.count ?? 0) {
//                UserDefaults.standard.set(offering?.current?.availablePackages[i].localizedPriceString, forKey: offering?.current?.availablePackages[i].storeProduct.productIdentifier ?? "")
//                UserDefaults.standard.synchronize()
//            }
//        }
//        Purchases.shared.getCustomerInfo { (customerInfo, error) in
//            if customerInfo?.activeSubscriptions.isEmpty == true {
//                UserDefaults.standard.set(false, forKey: subscription)
//                UserDefaults.standard.set("Nothing", forKey: activePlanName)
//            } else {
//                Purchases.shared.syncPurchases { (customerInfo, error) in
//                    if customerInfo?.activeSubscriptions.isEmpty == true {
//                        UserDefaults.standard.set(false, forKey:subscription)
//                        UserDefaults.standard.set("Nothing", forKey: activePlanName)
//                        
//                    } else {
//                        UserDefaults.standard.set(true, forKey: subscription)
//                        UserDefaults.standard.set(customerInfo?.activeSubscriptions.first, forKey: activePlanName)
//                    }
//                }
//            }
//        }
//    }
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
//        let rootViewController = application.windows.first(
//             where: { $0.isKeyWindow })?.rootViewController
//           if let rootViewController = rootViewController {
//             // Do not show app open ad if the current view controller is SplashViewController.
//             if rootViewController is SplashScreen {
//               return
//             }
//             AppOpenAdManager.shared.showAdIfAvailable(viewController: rootViewController)
//           }
    }


}

