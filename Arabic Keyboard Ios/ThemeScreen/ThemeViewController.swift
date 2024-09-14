//
//  ThemeViewController.swift
//  Arabic Keyboard Ios
//
//  Created by Viprak-Monil on 20/03/24.
//

import UIKit
import SideMenuSwift
import GoogleMobileAds
import StoreKit
import RevenueCat

class ThemeViewController: UIViewController {
    
    // MARK: IBOUTLET
    @IBOutlet weak var tb: UITableView!
    @IBOutlet weak var backButtonOT: UIButton!
    // MARK: VARIABLES
    var selecteColor: UIColor?
    var colours : [UIColor] = [.lightGray,.purple,.blue,.black,.white,.orange,.black,.darkGray,.black,.yellow,.red,.orange,.purple,.black,.magenta]
    var image = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"]
    var selectedCell = 0
    var rewardedAd: GADRewardedAd?
    private var numCalls = 0
    let freeSectionsCount = 5
    let adSectionCount = 5
    var selectedTheme: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        loadRewardedAd()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedTheme = UserDefaults.standard.integer(forKey: "SelectedTheme")
        tb.reloadData()
    }
    
    // MARK: FUNCTION
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
    
    func openalert(){
        let alert = UIAlertController(title: "Congratulation!!", message: "Your Arabic keyboard theme is applied successfuly.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel) { action in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")
            let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
            let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SideMenuViewController")
            let sideMenuController = SideMenuController(contentViewController: contentViewController, menuViewController: menuViewController)
            SideMenuController.preferences.basic.menuWidth = 300
            self.navigationController?.pushViewController(sideMenuController, animated: true)
            
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    // MARK: ACTION
    @IBAction func backButtontapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
}

// MARK: TABLE VIEW EXTENSION
extension ThemeViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tb.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ThemeTableViewCell
        // cell.backgroundColor = colours[indexPath.row]
        cell.keyboardImage.image = UIImage(named: image[indexPath.row])
        cell.buttonOt.tag = indexPath.row
        cell.buttonOt.addTarget(self, action: #selector(applyButtonHandler), for: .touchUpInside)
        cell.buttonOt.layer.cornerRadius = 6
        cell.buttonOt.layer.masksToBounds = true
        cell.leftConsttraint.constant = 10
        
        if indexPath.row == selectedTheme {
            cell.applyLB.text = "Applied"
            cell.spaceConstraint.constant = 6
            cell.leftConsttraint.constant = 4
        } else {
            cell.applyLB.text = "Apply"
        }
        
        if indexPath.row == 0{
            cell.buttonOt.backgroundColor = UIColor.white
            cell.buttonOt.layer.borderColor = UIColor.black.cgColor
            cell.buttonOt.layer.borderWidth = 1
            cell.adImage.isHidden = true
            cell.spaceConstraint.constant = 0
            
        }
        else if indexPath.row == 1{
            cell.buttonOt.backgroundColor = UIColor.white
            cell.buttonOt.layer.borderColor = UIColorFromHex(hex: "AB5433").cgColor
            cell.buttonOt.layer.borderWidth = 1
            cell.adImage.isHidden = true
            cell.spaceConstraint.constant = 0
        }
        else if indexPath.row == 2{
            cell.buttonOt.backgroundColor = UIColor.white
            cell.buttonOt.layer.borderColor = UIColorFromHex(hex: "5199FF").cgColor
            cell.buttonOt.layer.borderWidth = 1
            cell.adImage.isHidden = true
            cell.spaceConstraint.constant = 0
        }
        else if indexPath.row == 3{
            cell.buttonOt.backgroundColor = UIColor.white
            cell.buttonOt.layer.borderColor = UIColorFromHex(hex: "87C3BC").cgColor
            cell.buttonOt.layer.borderWidth = 1
            cell.adImage.isHidden = true
            cell.spaceConstraint.constant = 0
        }
        else if indexPath.row == 4{
            cell.buttonOt.backgroundColor = UIColor.white
            cell.buttonOt.layer.borderColor = UIColorFromHex(hex: "000000").cgColor
            cell.buttonOt.layer.borderWidth = 1
            cell.adImage.isHidden = true
            cell.spaceConstraint.constant = 0
        }
        else if indexPath.row == 5{
            //            if UserDefaults.standard.bool(forKey: subscription) == true{
            //                cell.adImage.isHidden = true
            //                cell.spaceConstraint.constant = 0
            //            }else{
            //                cell.adImage.isHidden = false
            //                cell.adImage.image = UIImage(named: "Vector")
            //                cell.spaceConstraint.constant = 10
            //            }
            
            //old code
//            if UserDefaults.standard.bool(forKey: subscription) == true{
//                cell.adImage.isHidden = true
//                cell.spaceConstraint.constant = 0
//            }else{
//                cell.adImage.isHidden = false
//                cell.adImage.image = UIImage(named: "Vector")
//                cell.spaceConstraint.constant = 10
//            }
            
            cell.adImage.isHidden = false
            cell.adImage.image = UIImage(named: "Vector")
            cell.spaceConstraint.constant = 10
            
            cell.buttonOt.backgroundColor = UIColor.white
            cell.buttonOt.layer.borderColor = UIColorFromHex(hex: "E96D48").cgColor
            cell.buttonOt.layer.borderWidth = 1
            
        }
        else if indexPath.row == 6{
            //            if UserDefaults.standard.bool(forKey: subscription) == true{
            //                cell.adImage.isHidden = true
            //                cell.spaceConstraint.constant = 0
            //            }else{
            //                cell.adImage.isHidden = false
            //                cell.adImage.image = UIImage(named: "Vector")
            //                cell.spaceConstraint.constant = 10
            //            }
            
            
//            if UserDefaults.standard.bool(forKey: subscription) == true{
//                cell.adImage.isHidden = true
//                cell.spaceConstraint.constant = 0
//            }else{
//                cell.adImage.isHidden = false
//                cell.adImage.image = UIImage(named: "ic_crown")
//                cell.spaceConstraint.constant = 10
//            }
            cell.adImage.isHidden = false
            cell.adImage.image = UIImage(named: "Vector")
            cell.spaceConstraint.constant = 10
            
            cell.buttonOt.backgroundColor = UIColor.white
            cell.buttonOt.layer.borderColor = UIColorFromHex(hex: "79DAFA").cgColor
            cell.buttonOt.layer.borderWidth = 1
        }
        else if indexPath.row == 7{
            //            if UserDefaults.standard.bool(forKey: subscription) == true{
            //                cell.adImage.isHidden = true
            //                cell.spaceConstraint.constant = 0
            //            }else{
            //                cell.adImage.isHidden = false
            //                cell.adImage.image = UIImage(named: "Vector")
            //                cell.spaceConstraint.constant = 10
            //            }
            
//            if UserDefaults.standard.bool(forKey: subscription) == true{
//                cell.adImage.isHidden = true
//                cell.spaceConstraint.constant = 0
//            }else{
//                cell.adImage.isHidden = false
//                cell.adImage.image = UIImage(named: "ic_crown")
//                cell.spaceConstraint.constant = 10
//            }
            
            cell.adImage.isHidden = false
            cell.adImage.image = UIImage(named: "Vector")
            cell.spaceConstraint.constant = 10
            cell.buttonOt.backgroundColor = UIColor.white
            cell.buttonOt.layer.borderColor = UIColorFromHex(hex: "3C3026").cgColor
            cell.buttonOt.layer.borderWidth = 1
        }
        else if indexPath.row == 8{
            //            if UserDefaults.standard.bool(forKey: subscription) == true{
            //                cell.adImage.isHidden = true
            //                cell.spaceConstraint.constant = 0
            //            }else{
            //                cell.adImage.isHidden = false
            //                cell.adImage.image = UIImage(named: "Vector")
            //                cell.spaceConstraint.constant = 10
            //            }
            
//            if UserDefaults.standard.bool(forKey: subscription) == true{
//                cell.adImage.isHidden = true
//                cell.spaceConstraint.constant = 0
//            }else{
//                cell.adImage.isHidden = false
//                cell.adImage.image = UIImage(named: "ic_crown")
//                cell.spaceConstraint.constant = 10
//            }
            
            cell.adImage.isHidden = false
            cell.adImage.image = UIImage(named: "Vector")
            cell.spaceConstraint.constant = 10
            cell.buttonOt.backgroundColor = UIColor.white
            cell.buttonOt.layer.borderColor = UIColorFromHex(hex: "FFB200").cgColor
            cell.buttonOt.layer.borderWidth = 1
        }
        else if indexPath.row == 9{
            //            if UserDefaults.standard.bool(forKey: subscription) == true{
            //                cell.adImage.isHidden = true
            //                cell.spaceConstraint.constant = 0
            //            }else{
            //                cell.adImage.isHidden = false
            //                cell.adImage.image = UIImage(named: "Vector")
            //                cell.spaceConstraint.constant = 10
            //            }
            
//            if UserDefaults.standard.bool(forKey: subscription) == true{
//                cell.adImage.isHidden = true
//                cell.spaceConstraint.constant = 0
//            }else{
//                cell.adImage.isHidden = false
//                cell.adImage.image = UIImage(named: "ic_crown")
//                cell.spaceConstraint.constant = 10
//            }
            
            cell.adImage.isHidden = false
            cell.adImage.image = UIImage(named: "Vector")
            cell.spaceConstraint.constant = 10
            cell.buttonOt.backgroundColor = UIColor.white
            cell.buttonOt.layer.borderColor = UIColorFromHex(hex: "94FDF9").cgColor
            cell.buttonOt.layer.borderWidth = 1
        }
        else if indexPath.row == 10{
//            if UserDefaults.standard.bool(forKey: subscription) == true{
//                cell.adImage.isHidden = true
//                cell.spaceConstraint.constant = 0
//            }else{
//                cell.adImage.isHidden = false
//                cell.adImage.image = UIImage(named: "ic_crown")
//                cell.spaceConstraint.constant = 10
//            }
            cell.adImage.isHidden = false
            cell.adImage.image = UIImage(named: "Vector")
            cell.spaceConstraint.constant = 10
            cell.buttonOt.backgroundColor = UIColor.white
            cell.buttonOt.layer.borderColor = UIColorFromHex(hex: "F6D716").cgColor
            cell.buttonOt.layer.borderWidth = 1
        }
        else if indexPath.row == 11{
//            if UserDefaults.standard.bool(forKey: subscription) == true{
//                cell.adImage.isHidden = true
//                cell.spaceConstraint.constant = 0
//            }else{
//                cell.adImage.isHidden = false
//                cell.adImage.image = UIImage(named: "ic_crown")
//                cell.spaceConstraint.constant = 10
//            }
            cell.adImage.isHidden = false
            cell.adImage.image = UIImage(named: "Vector")
            cell.spaceConstraint.constant = 10
            cell.buttonOt.backgroundColor = UIColor.white
            cell.buttonOt.layer.borderColor = UIColorFromHex(hex: "F6D716").cgColor
            cell.buttonOt.layer.borderWidth = 1
        }
        else if indexPath.row == 12{
//            if UserDefaults.standard.bool(forKey: subscription) == true{
//                cell.adImage.isHidden = true
//                cell.spaceConstraint.constant = 0
//            }else{
//                cell.adImage.isHidden = false
//                cell.adImage.image = UIImage(named: "ic_crown")
//                cell.spaceConstraint.constant = 10
//            }
            cell.adImage.isHidden = false
            cell.adImage.image = UIImage(named: "Vector")
            cell.spaceConstraint.constant = 10
            cell.buttonOt.backgroundColor = UIColor.white
            cell.buttonOt.layer.borderColor = UIColorFromHex(hex: "F6D716").cgColor
            cell.buttonOt.layer.borderWidth = 1
        }
        else if indexPath.row == 13{
//            if UserDefaults.standard.bool(forKey: subscription) == true{
//                cell.adImage.isHidden = true
//                cell.spaceConstraint.constant = 0
//            }else{
//                cell.adImage.isHidden = false
//                cell.adImage.image = UIImage(named: "ic_crown")
//                cell.spaceConstraint.constant = 10
//            }
            cell.adImage.isHidden = false
            cell.adImage.image = UIImage(named: "Vector")
            cell.spaceConstraint.constant = 10
            cell.buttonOt.backgroundColor = UIColor.white
            cell.buttonOt.layer.borderColor = UIColorFromHex(hex: "F6D716").cgColor
            cell.buttonOt.layer.borderWidth = 1
        }
        else {
//            if UserDefaults.standard.bool(forKey: subscription) == true{
//                cell.adImage.isHidden = true
//                cell.spaceConstraint.constant = 0
//            }else{
//                cell.adImage.isHidden = false
//                cell.adImage.image = UIImage(named: "ic_crown")
//                cell.spaceConstraint.constant = 10
//            }
            cell.adImage.isHidden = false
            cell.adImage.image = UIImage(named: "Vector")
            cell.spaceConstraint.constant = 10
            cell.buttonOt.backgroundColor = UIColor.white
            cell.buttonOt.layer.borderColor = UIColorFromHex(hex: "F6D716").cgColor
            cell.buttonOt.layer.borderWidth = 1
        }
        
        return cell
    }
    @objc func applyButtonHandler(sender:UIButton){
        
        //        openalert()
        //
        //
        //        let appGroupID = "group.arabic.custom.keyboard"
        //        // Get the shared UserDefaults object
        //        if let userDefaults = UserDefaults(suiteName: appGroupID) {
        //            // Save data to the shared UserDefaults
        //            userDefaults.set(sender.tag, forKey: "SelectedTheme")
        //            UserDefaults.standard.set(sender.tag, forKey: "SelectedTheme")
        //            userDefaults.synchronize()
        //            let selectedTheme = userDefaults.integer(forKey: "SelectedTheme")
        //            print("Selected Theme Number \(selectedTheme)")
        //        } else {
        //            print("Unable to create UserDefaults for App Group.")
        //        }
        //       applyTheme(tag: sender.tag)
        
        if sender.tag < freeSectionsCount{
            applyTheme(tag: sender.tag)
            openalert()
        }
        //        else if sender.tag < freeSectionsCount + adSectionCount{
        ////            if UserDefaults.standard.bool(forKey: subscription) == false{
        ////                applyTheme(tag: sender.tag)
        ////                self.numCalls += 1
        ////                if self.numCalls % 1 == 0 {
        ////                    if let rewardedAd = self.rewardedAd {
        ////                        print("Presenting rewarded ad...")
        ////                        rewardedAd.present(fromRootViewController: self) { [weak self] in
        ////                            DispatchQueue.main.async {
        ////                                self?.dismiss(animated: true)
        ////                                self?.openalert()
        ////                                print("Finished ad presentation.")
        ////                            }
        ////                        }
        ////                    } else {
        ////                        print("Ad wasn't ready")
        ////                    }
        ////
        ////                }
        ////            }
        ////            else{
        //                applyTheme(tag: sender.tag)
        //                openalert()
        //           // }
        //        }
        else{
            applyTheme(tag: sender.tag)
            self.numCalls += 1
            if self.numCalls % 1 == 0 {
                if let rewardedAd = self.rewardedAd {
                    print("Presenting rewarded ad...")
                    rewardedAd.present(fromRootViewController: self) { [weak self] in
                        DispatchQueue.main.async {
                            self?.dismiss(animated: true)
                            self?.openalert()
                            print("Finished ad presentation.")
                        }
                    }
                } else {
                    print("Ad wasn't ready")
                }
                
            }
//            if UserDefaults.standard.bool(forKey: subscription) == false{
//                let subscriptionVC = storyboard?.instantiateViewController(withIdentifier: "SubscriptionController") as! SubscriptionController
//                subscriptionVC.modalPresentationStyle = .fullScreen
//                navigationController?.present(subscriptionVC, animated: false)
//            }
//            else{
//                applyTheme(tag: sender.tag)
//                openalert()
//            }
        }
        
    }
    func applyTheme(tag: Int) {
        //        openalert()
        let indexPath = IndexPath(row: tag, section: 0)
        guard let cell = tb.cellForRow(at: indexPath) as? ThemeTableViewCell else {
            return
        }
        
        let appGroupID = "group.Arabic.Keyboard"
        if let userDefaults = UserDefaults(suiteName: appGroupID) {
            userDefaults.set(tag, forKey: "SelectedTheme")
            UserDefaults.standard.set(tag, forKey: "SelectedTheme")
            userDefaults.synchronize()
            //            selectedTheme = tag
            //                        tb.reloadData()
            let selectedTheme = userDefaults.integer(forKey: "SelectedTheme")
            print("Selected Theme Number \(selectedTheme)")
        } else {
            print("Unable to create UserDefaults for App Group.")
        }
        //        self.numCalls += 1
        //        if self.numCalls % 1 == 0 {
        //            self.loadRewardedAd()
        //            if let rewardedAd = self.rewardedAd {
        //                rewardedAd.present(fromRootViewController: self) {
        //                    // You can provide rewards to the user here, if applicable.
        //                }
        //            } else {
        //                print("Ad wasn't ready")
        //                // You may want to handle this scenario by reloading the ad or showing an alternative action.
        //            }
        //
        //        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
}


extension ThemeViewController{
    private func UIColorFromHex(hex: String) -> UIColor {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexString = hexString.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        Scanner(string: hexString).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

extension ThemeViewController: GADFullScreenContentDelegate {
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        // Reload the ad after it's dismissed.
        openalert()
        loadRewardedAd()
    }
    func adWillDismissFullScreenContent(_ ad: any GADFullScreenPresentingAd) {
        print("finish ad")
    }
    
}


