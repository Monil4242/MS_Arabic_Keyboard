//
//  SideMenuViewController.swift
//  Arabic Keyboard Ios
//
//  Created by Viprak-Monil on 26/03/24.
//

import UIKit
import SideMenuSwift
import StoreKit
import GoogleMobileAds

class SideMenuViewController: UIViewController {
    
    // MARK: VARIBLES
    let arrMenunames = ["Home", "Themes","Settings", "Share app", "Rate app"/*,"Pro access"*/]
    let arrSelectedImageNames = ["home", "art", "setting selected", "share", "star"/*,"subscription"*/]
    let arrUnselectedImageNames = ["home unselected", "art unselected", "setting unselected", "share unselected", "star unselected"/*,"subscription unselected"*/]
    var selectedCell = 0
    var rewardedAd: GADRewardedAd?
    private var numCalls = 0
    
    // MARK: IBOUTLET
    @IBOutlet weak var sideMenuTB: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRewardedAd()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.view.layer.cornerRadius = 40.0
        self.view.layer.masksToBounds = true
        
    }
    // MARK: FUCTION
    
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
    
    func sideMenuNavigation(){
        // let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        // if UserDefaults.standard.bool(forKey: subscription) == true{
        //print("subscription active")
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
    func sideMenuHomeNavigation(){
        // let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        //        let navigate = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        //        navigationController?.pushViewController(navigate, animated: true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")
        let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
        let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SideMenuViewController")
        let sideMenuController = SideMenuController(contentViewController: contentViewController, menuViewController: menuViewController)
        SideMenuController.preferences.basic.menuWidth = 300
        self.navigationController?.pushViewController(sideMenuController, animated: true)
    }
    func paywallNavigation(){
        let navigate = storyboard?.instantiateViewController(withIdentifier: "SubscriptionController") as! SubscriptionController
        navigate.modalPresentationStyle = .fullScreen
        navigationController?.present(navigate, animated: true)
    }
    func sideMenuSettingNavigation(){
        // let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        //        if UserDefaults.standard.bool(forKey: subscription) == true{
        //            print("subscription active")
        let navigate = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        navigationController?.pushViewController(navigate, animated: false)
        //        }
        //        else{
        //            numCalls += 1
        //            if numCalls % 2 == 0 {
        //                loadRewardedAd()
        //                if let rewardedAd = rewardedAd {
        //                  rewardedAd.present(fromRootViewController: self) {
        //                               // You can provide rewards to the user here, if applicable.
        //                }
        //                } else {
        //                  print("Ad wasn't ready")
        //                           // You may want to handle this scenario by reloading the ad or showing an alternative action.
        //                }
        //
        //            }
        //            let navigate = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        //            navigationController?.pushViewController(navigate, animated: true)
        //        }
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
    
    
}

// MARK: TABLEVIEW EXTENSION

extension SideMenuViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenunames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sideMenuTB.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SideMenuTableViewCell
        if selectedCell == indexPath.row {
            cell.sideMenuImageView.image = UIImage(named: arrSelectedImageNames[indexPath.row])
            cell.sideMenuLBL.textColor = .black
            cell.menuBgView.backgroundColor = .white
        } else {
            cell.sideMenuImageView.image = UIImage(named: arrUnselectedImageNames[indexPath.row])
            cell.sideMenuLBL.textColor = .white
            cell.menuBgView.backgroundColor = .clear
        }
        
        cell.sideMenuLBL.text = arrMenunames[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = indexPath.row
        switch indexPath.row{
        case 0:
            sideMenuHomeNavigation()
        case 1:
            sideMenuNavigation()
        case 2:
            sideMenuSettingNavigation()
        case 3:
            shareApp()
        case 4:
            SKStoreReviewController.requestReview()
            view.endEditing(true)
//        case 5:
//            paywallNavigation()
        default:
            break;
        }
        sideMenuTB.reloadData()
    }
    
    
}

extension SideMenuViewController: GADFullScreenContentDelegate {
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        // Reload the ad after it's dismissed.
        loadRewardedAd()
    }
}
