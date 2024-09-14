//
//  SceneDelegate.swift
//  Arabic Keyboard Ios
//
//  Created by Viprak-Monil on 19/03/24.
//

import UIKit
import SideMenuSwift
import GoogleMobileAds

class SceneDelegate: UIResponder, UIWindowSceneDelegate, GADFullScreenContentDelegate {

    var window: UIWindow?
    var appOpenAd: GADAppOpenAd?
    var loadTime: Date?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        SideMenuController.preferences.basic.menuWidth = 300
       // navigate()
        guard let _ = (scene as? UIWindowScene) else { return }
        
    }
    
    

//    private func navigate(){
//        let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
//        let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SideMenuViewController")
//        var sideMenuController = SideMenuController(contentViewController: contentViewController, menuViewController: menuViewController)
//        SideMenuController.preferences.basic.menuWidth = 300
//        let navVc = UINavigationController(rootViewController: sideMenuController)
//        navVc.navigationBar.isHidden = true
//        window?.rootViewController = navVc
//    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
       // showAppOpenAdIfAvailable()
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
//        if UserDefaults.standard.bool(forKey: subscription) == true{
//            print("subscription active")
//        }
//        else{
//            loadAppOpenAD()
//        }
//        print("foreground")
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print("background")
       
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
//    func loadAppOpenAD(){
//        let request = GADRequest()
//        GADAppOpenAd.load(withAdUnitID: "/23143498483/APPOpen", request: GADRequest()) { ad, error in
//            if let error = error {
//                self.appOpenAd = nil
//                self.loadTime = nil
//                print("App open ad failed to load with error: \(error.localizedDescription).")
//                return
//            }
//            self.appOpenAd = ad
//            self.appOpenAd?.fullScreenContentDelegate = self
//            self.loadTime = Date()
//            print("App open ad loaded successfully.")
//        }
//    }
//    private func showAppOpenAdIfAvailable() {
//            if let ad = appOpenAd {
//                if let rootViewController = window?.rootViewController {
//                    ad.present(fromRootViewController: rootViewController)
//                } else {
//                    print("Root view controller is not available")
//                }
//            } else {
//                print("Ad wasn't ready")
//            }
//        }
//
//    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
//           print("Ad failed to present full screen content with error: \(error.localizedDescription)")
//           appOpenAd = nil
//           loadAppOpenAD() // Try to load a new ad
//       }
//
//       func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//           print("Ad did dismiss full screen content.")
//           appOpenAd = nil
//           loadAppOpenAD() // Load a new ad when the current one is dismissed
//       }


}

