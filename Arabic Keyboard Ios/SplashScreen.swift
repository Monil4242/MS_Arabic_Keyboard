//
//  SplashScreen.swift
//  Arabic Keyboard Ios
//
//  Created by Viprak-Monil on 05/04/24.
//

import UIKit
import SideMenuSwift

class SplashScreen: UIViewController, AppOpenAdManagerDelegate {

    var secondsRemaining: Int = 5
    var countdownTimer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        AppOpenAdManager.shared.appOpenAdManagerDelegate = self
        startTimer()
    }
    
    @objc func decrementCounter() {
      secondsRemaining -= 1
      if secondsRemaining > 0 {
       // splashScreenLabel.text = "Loading Data: \(secondsRemaining)"
      } else {
       // splashScreenLabel.text = "Done."
        countdownTimer?.invalidate()
        AppOpenAdManager.shared.showAdIfAvailable(viewController: self)
      }
    }

    func startTimer() {
     // splashScreenLabel.text = "App is done loading in: \(secondsRemaining)"
      countdownTimer = Timer.scheduledTimer(
        timeInterval: 1.0,
        target: self,
        selector: #selector(SplashScreen.decrementCounter),
        userInfo: nil,
        repeats: true)
    }

    func startMainScreen() {
//      let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
//      let mainViewController = mainStoryBoard.instantiateViewController(
//        withIdentifier: "MainNavigationController")
//        //navigationController?.pushViewController(mainViewController, animated: true)
//        present(mainViewController, animated: true) {
//        self.dismiss(animated: false) {
//          // Find the keyWindow which is currently being displayed on the device,
//          // and set its rootViewController to mainViewController.
//          let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
//          keyWindow?.rootViewController = mainViewController
//        }
//      }
        let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
        let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SideMenuViewController")
        var sideMenuController = SideMenuController(contentViewController: contentViewController, menuViewController: menuViewController)
        SideMenuController.preferences.basic.menuWidth = 300
        let navVc = UINavigationController(rootViewController: sideMenuController)
        navVc.navigationBar.isHidden = true
        let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        keyWindow?.rootViewController = navVc
    }

    // MARK: AppOpenAdManagerDelegate
    func appOpenAdManagerAdDidComplete(_ appOpenAdManager: AppOpenAdManager) {
      startMainScreen()
    }

   

}
