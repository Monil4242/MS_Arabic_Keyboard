//
//  SettingsViewController.swift
//  Arabic Keyboard Ios
//
//  Created by Viprak-Monil on 26/03/24.
//

import UIKit
import SideMenuSwift
import AudioToolbox
import StoreKit
import RevenueCat
import GoogleMobileAds
import SafariServices

class SettingsViewController: UIViewController, GADBannerViewDelegate {
    
    // MARK: IBOUTLET
    @IBOutlet weak var themeButtonView: UIView!
    @IBOutlet weak var shareButtonView: UIView!
    @IBOutlet weak var rateButtonView: UIView!
    @IBOutlet weak var soundView: UIView!
    @IBOutlet weak var vibrantView: UIView!
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var vibrantSwitch: UISwitch!
    @IBOutlet weak var removeAdsView: UIView!
    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var termsOfUseView: UIView!
    
    // MARK: VARIABLES
    private var numCalls = 0
    let defaults = UserDefaults.standard
    var rewardedAd: GADRewardedAd?
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBannerAD()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        cornerRadius()
        checkSwitchState()
        loadRewardedAd()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        if UserDefaults.standard.bool(forKey: subscription) == true{
        //            removeAdsView.isHidden = true
        //        }
        //        else{
        //            removeAdsView.isHidden = false
        //        }
    }
    // MARK: FUNCTION
    func checkSwitchState(){
        if(defaults.bool(forKey: "ISSOUNDONOROFF"))
        {
            soundSwitch.setOn(true, animated: false)
        }else{
            soundSwitch.setOn(false, animated: false)
        }
        
        if(defaults.bool(forKey: "ISHAPTICONOROFF"))
        {
            vibrantSwitch.setOn(true, animated: false)
        }else{
            vibrantSwitch.setOn(false, animated: false)
        }
        
    }
    func loadBannerAD(){
        bannerView = GADBannerView(adSize:GADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-7873000489717472/5448978938"
        bannerView.rootViewController = self
        bannerView.delegate = self
        bannerView.load(GADRequest())
        
        // Add banner view to the view hierarchy
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        
        // Set constraints
        view.addConstraints([
            NSLayoutConstraint(item: bannerView!,
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: view.safeAreaLayoutGuide,
                               attribute: .bottom,
                               multiplier: 1,
                               constant: 0),
            NSLayoutConstraint(item: bannerView!,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .centerX,
                               multiplier: 1,
                               constant: 0)
        ])
    }
    func loadRewardedAd() {
        let request = GADRequest()
        GADRewardedAd.load(withAdUnitID: "ca-app-pub-7873000489717472/3391028906", request: request) { [weak self] ad, error in
            guard let self = self else { return }
            if let error = error {
                print("Failed to load rewarded ad with error: \(error.localizedDescription)")
                return
            }
            self.rewardedAd = ad
            self.rewardedAd?.fullScreenContentDelegate = self
        }
    }
    func cornerRadius(){
        themeButtonView.layer.borderColor = UIColor(hexFromString: "ABB5BE").cgColor
        themeButtonView.layer.borderWidth = 1
        shareButtonView.layer.borderColor = UIColor(hexFromString: "ABB5BE").cgColor
        shareButtonView.layer.borderWidth = 1
        rateButtonView.layer.borderColor = UIColor(hexFromString: "ABB5BE").cgColor
        rateButtonView.layer.borderWidth = 1
        soundView.layer.borderColor = UIColor(hexFromString: "ABB5BE").cgColor
        soundView.layer.borderWidth = 1
        vibrantView.layer.borderColor = UIColor(hexFromString: "ABB5BE").cgColor
        vibrantView.layer.borderWidth = 1
        removeAdsView.layer.borderColor = UIColor(hexFromString: "ABB5BE").cgColor
        removeAdsView.layer.borderWidth = 1
        privacyPolicyView.layer.borderColor = UIColor(hexFromString: "ABB5BE").cgColor
        privacyPolicyView.layer.borderWidth = 1
        termsOfUseView.layer.borderColor = UIColor(hexFromString: "ABB5BE").cgColor
        termsOfUseView.layer.borderWidth = 1
        themeButtonView.layer.cornerRadius = 8
        themeButtonView.layer.masksToBounds = true
        shareButtonView.layer.cornerRadius = 8
        shareButtonView.layer.masksToBounds = true
        rateButtonView.layer.cornerRadius = 8
        rateButtonView.layer.masksToBounds = true
        soundView.layer.cornerRadius = 8
        soundView.layer.masksToBounds = true
        vibrantView.layer.cornerRadius = 8
        vibrantView.layer.masksToBounds = true
        removeAdsView.layer.cornerRadius = 8
        removeAdsView.layer.masksToBounds = true
        privacyPolicyView.layer.cornerRadius = 8
        privacyPolicyView.layer.masksToBounds = true
        termsOfUseView.layer.cornerRadius = 8
        termsOfUseView.layer.masksToBounds = true
    }
    func shareApp(){
        if let urlStr = NSURL(string: "https://apps.apple.com/us/app/id6569253409?ls=1&mt=8") {
            let objectsToShare = [urlStr]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                if let popup = activityVC.popoverPresentationController {
                    popup.sourceView = self.view
                    popup.sourceRect = CGRect(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 4, width: 0, height: 0)
                }
            }
            
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    // MARK: ACTION
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func themeButtonTapped(_ sender: Any) {
        
        //        if UserDefaults.standard.bool(forKey: subscription) == true{
        //            print("subscription active")
        //            let navigate = storyboard?.instantiateViewController(withIdentifier: "ThemeViewController") as! ThemeViewController
        //            navigationController?.pushViewController(navigate, animated: true)
        //        }
        //        else{
        numCalls += 1
        if numCalls % 2 == 0 {
            loadRewardedAd()
            if let rewardedAd = rewardedAd {
                rewardedAd.present(fromRootViewController: self) {
                    // You can provide rewards to the user here, if applicable.
                }
            } else {
                print("Ad wasn't ready")
                // You may want to handle this scenario by reloading the ad or showing an alternative action.
            }
            
        }
        let navigate = storyboard?.instantiateViewController(withIdentifier: "ThemeViewController") as! ThemeViewController
        navigationController?.pushViewController(navigate, animated: true)
        //        }
        
    }
    
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        shareApp()
    }
    
    @IBAction func rateButtonTapped(_ sender: Any) {
        SKStoreReviewController.requestReview()
    }
    
    
    @IBAction func soundSwitchTapped(_ sender: Any) {
        //        if UserDefaults.standard.bool(forKey: subscription) == true{
        //            print(subscription)
        if (soundSwitch.isOn){
            loadRewardedAd()
            if let rewardedAd = rewardedAd {
                rewardedAd.present(fromRootViewController: self) {
                    // You can provide rewards to the user here, if applicable.
                }
            } else {
                print("Ad wasn't ready")
                // You may want to handle this scenario by reloading the ad or showing an alternative action.
            }
            defaults.set(true,forKey: "ISSOUNDONOROFF")
        }
        else{
            defaults.set(nil,forKey: "ISSOUNDONOROFF")
        }
        // }
        //        else{
        //            if (soundSwitch.isOn){
        //                loadRewardedAd()
        //                if let rewardedAd = rewardedAd {
        //                    rewardedAd.present(fromRootViewController: self) {
        //                        // You can provide rewards to the user here, if applicable.
        //                    }
        //                } else {
        //                    print("Ad wasn't ready")
        //                    // You may want to handle this scenario by reloading the ad or showing an alternative action.
        //                }
        //                defaults.set(true,forKey: "ISSOUNDONOROFF")
        //            }
        //            else{
        //                defaults.set(nil,forKey: "ISSOUNDONOROFF")
        //            }
        //        }
        
    }
    
    @IBAction func vibrantSwitchTapped(_ sender: Any) {
        //        if UserDefaults.standard.bool(forKey: subscription) == true{
        //            print("subscription active")
        if (vibrantSwitch.isOn){
            loadRewardedAd()
            if let rewardedAd = rewardedAd {
                rewardedAd.present(fromRootViewController: self) {
                    // You can provide rewards to the user here, if applicable.
                }
            } else {
                print("Ad wasn't ready")
                // You may want to handle this scenario by reloading the ad or showing an alternative action.
            }
            defaults.set(true,forKey: "ISHAPTICONOROFF")
            
        }
        else{
            defaults.set(nil,forKey: "ISHAPTICONOROFF")
        }
        // }
        //        else{
        //            if (vibrantSwitch.isOn){
        //                loadRewardedAd()
        //                if let rewardedAd = rewardedAd {
        //                    rewardedAd.present(fromRootViewController: self) {
        //                        // You can provide rewards to the user here, if applicable.
        //                    }
        //                } else {
        //                    print("Ad wasn't ready")
        //                    // You may want to handle this scenario by reloading the ad or showing an alternative action.
        //                }
        //                defaults.set(true,forKey: "ISHAPTICONOROFF")
        //
        //            }
        //            else{
        //                defaults.set(nil,forKey: "ISHAPTICONOROFF")
        //            }
        //        }
        
    }
    
    @IBAction func rate(_ sender: Any) {
        let navigate = storyboard?.instantiateViewController(withIdentifier: "SubscriptionController") as! SubscriptionController
        navigate.modalPresentationStyle = .fullScreen
        navigationController?.present(navigate, animated: false)
    }
    
    
    @IBAction func privacyPolicyBTN(_ sender: Any) {
        let privacyPolicyUrl = URL(string:"https://www.termsfeed.com/live/287d6832-11a6-4eaa-9d4f-4b71434f07c1")!
        let safariVC = SFSafariViewController(url: privacyPolicyUrl)
        self.present(safariVC, animated: true, completion: nil)
    }
    
    @IBAction func termsOfUseBTN(_ sender: Any) {
        let privacyPolicyUrl = URL(string:"https://www.termsfeed.com/live/5f6e33b8-74ca-4b8f-bd11-dfc211b091de")!
        let safariVC = SFSafariViewController(url: privacyPolicyUrl)
        self.present(safariVC, animated: true, completion: nil)
    }
    
}

extension SettingsViewController: GADFullScreenContentDelegate {
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        // Reload the ad after it's dismissed.
        loadRewardedAd()
    }
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("Banner ad received.")
    }
    
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("Failed to receive ad: \(error.localizedDescription)")
    }
}
