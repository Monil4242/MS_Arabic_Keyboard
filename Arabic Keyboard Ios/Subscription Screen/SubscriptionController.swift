//
//  SubscriptionController.swift
//  Arabic Keyboard Ios
//
//  Created by Viprak-Monil on 13/06/24.
//

import UIKit
import SafariServices
import SwiftyStoreKit
import RevenueCat

class SubscriptionController: UIViewController {
    
    @IBOutlet weak var subscribeButtonOT: UIButton!
    @IBOutlet weak var monthButtonOT: GradientView!
    @IBOutlet weak var annualButtonOT: GradientView!
    @IBOutlet weak var monthSelectIMg: UIImageView!
    @IBOutlet weak var annualSelectIMG: UIImageView!
    @IBOutlet weak var monthlyLB: UILabel!
    @IBOutlet weak var annualLB: UILabel!
    
    @IBOutlet weak var backgroungImage: UIImageView!
    var selectedProductId = MonthlyProductId
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefault()
        //startAppForReal()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cornerRadius()
//        DispatchQueue.main.async {
//            self.backgroungImage.image = UIImage(named: "background")
//        }
    }
    func cornerRadius(){
        subscribeButtonOT.layer.cornerRadius = 30
        subscribeButtonOT.layer.masksToBounds = true
        monthButtonOT.layer.borderWidth = 1.5
        monthButtonOT.layer.borderColor = UIColor(hexFromString: "367DE5").cgColor
        monthSelectIMg.image = UIImage(systemName: "checkmark.circle.fill")
        monthButtonOT.layer.backgroundColor = UIColor.white.cgColor
        annualButtonOT.layer.borderWidth = 1.5
        annualButtonOT.layer.borderColor = UIColor(hexFromString: "ABB5BE").cgColor
    }
    func setDefault() {
        //        IAPManager.sharedInstance.delegate = self
        
        if let monthly = UserDefaults.standard.value(forKey: MonthlyProductId) as? String {
            self.monthlyLB?.text = "\(monthly)/month"
            
        }
        
        if let yearly = UserDefaults.standard.value(forKey: YearlyProductId) as? String {
            self.annualLB?.text = "\(yearly)/year"
        }
    }
    func startAppForReal() {
        Purchases.shared.getOfferings { (offerings, error) in
            if let error = error {
                self.view.makeToast(error.localizedDescription)
                //                self.catchError(error)
            } else {
                print(offerings)
                Purchases.shared.getCustomerInfo { (info, error) in
                    if let error = error {
                        //                        self.catchError(error)
                    } else {
                        print(info)
                        //                        self.showMainView()
                    }
                }
            }
        }
    }
    
    @IBAction func monthlySubscriptionBTN(_ sender: Any) {
        monthButtonOT.layer.borderWidth = 1.5
        monthButtonOT.layer.borderColor = UIColor(hexFromString: "367DE5").cgColor
        annualButtonOT.layer.borderWidth = 0
        annualSelectIMG.image = UIImage(systemName: "circle")
        monthSelectIMg.image = UIImage(systemName: "checkmark.circle.fill")
        annualButtonOT.layer.backgroundColor = UIColor.white.cgColor
        monthButtonOT.layer.backgroundColor = UIColor.white.cgColor
        annualButtonOT.layer.borderWidth = 1.5
        annualButtonOT.layer.borderColor = UIColor(hexFromString: "ABB5BE").cgColor
        selectedProductId = MonthlyProductId
        
        showProgress("")
        Purchases.shared.getOfferings { (offerings, error) in
            if let error = error {
                self.view.makeToast(error.localizedDescription)
            } else {
                for i in 0..<(offerings?.current?.availablePackages.count)! {
                    if self.selectedProductId == offerings?.current?.availablePackages[i].storeProduct.productIdentifier {
                        if let package = offerings?.current?.availablePackages[i] {
                            Purchases.shared.purchase(package: package) { (transaction, purchaserInfo, error, userCancelled) in
                                if let error = error {
                                    dismissProgress()
                                    self.view.makeToast(error.localizedDescription)
                                }
                                else {
                                    Purchases.shared.getCustomerInfo { (customerInfo, error) in
                                        if customerInfo?.activeSubscriptions.isEmpty == true {
                                            dismissProgress()
                                            UserDefaults.standard.set(false, forKey: subscription)
                                            UserDefaults.standard.set("Nothing", forKey: activePlanName)
                                            self.dismiss(animated: true)
                                        } else {
                                            dismissProgress()
                                            UserDefaults.standard.set(true, forKey: subscription)
                                            UserDefaults.standard.set(customerInfo?.activeSubscriptions.first, forKey: activePlanName)
                                            self.dismiss(animated: true)
                                            //                                            self.gotoTabBarVC()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func annualSubscriptionBTN(_ sender: Any) {
        monthSelectIMg.image = UIImage(systemName: "circle")
        annualSelectIMG.image = UIImage(systemName: "checkmark.circle.fill")
        monthButtonOT.layer.backgroundColor = UIColor.white.cgColor
        annualButtonOT.layer.backgroundColor = UIColor.white.cgColor
        annualButtonOT.layer.borderWidth = 1.5
        annualButtonOT.layer.borderColor = UIColor(hexFromString: "367DE5").cgColor
        monthButtonOT.layer.borderWidth = 0
        monthButtonOT.layer.borderWidth = 1.5
        monthButtonOT.layer.borderColor = UIColor(hexFromString: "ABB5BE").cgColor
        selectedProductId = YearlyProductId
        
        showProgress("")
        Purchases.shared.getOfferings { (offerings, error) in
            if let error = error {
                self.view.makeToast(error.localizedDescription)
            } else {
                for i in 0..<(offerings?.current?.availablePackages.count)! {
                    if self.selectedProductId == offerings?.current?.availablePackages[i].storeProduct.productIdentifier {
                        print("Yearly Package Got")
                        if let package = offerings?.current?.availablePackages[i] {
                            Purchases.shared.purchase(package: package) { (transaction, purchaserInfo, error, userCancelled) in
                                if let error = error {
                                    dismissProgress()
                                    self.view.makeToast(error.localizedDescription)
                                }
                                else {
                                    Purchases.shared.getCustomerInfo { (customerInfo, error) in
                                        if customerInfo?.activeSubscriptions.isEmpty == true {
                                            dismissProgress()
                                            UserDefaults.standard.set(false, forKey: subscription)
                                            UserDefaults.standard.set("Nothing", forKey: activePlanName)
                                            self.dismiss(animated: true)
                                        } else {
                                            dismissProgress()
                                            UserDefaults.standard.set(true, forKey: subscription)
                                            UserDefaults.standard.set(customerInfo?.activeSubscriptions.first, forKey: activePlanName)
                                            self.dismiss(animated: true)
                                            //                                            self.gotoTabBarVC()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func subscribeButtonTapped(_ sender: Any) {
        showProgress("")
        Purchases.shared.getOfferings { (offerings, error) in
            if let error = error {
                self.view.makeToast(error.localizedDescription)
            } else {
                for i in 0..<(offerings?.current?.availablePackages.count)! {
                    if self.selectedProductId == offerings?.current?.availablePackages[i].storeProduct.productIdentifier {
                        print("Yearly Package Got")
                        if let package = offerings?.current?.availablePackages[i] {
                            Purchases.shared.purchase(package: package) { (transaction, purchaserInfo, error, userCancelled) in
                                if let error = error {
                                    dismissProgress()
                                    self.view.makeToast(error.localizedDescription)
                                }
                                else {
                                    Purchases.shared.getCustomerInfo { (customerInfo, error) in
                                        if customerInfo?.activeSubscriptions.isEmpty == true {
                                            dismissProgress()
                                            UserDefaults.standard.set(false, forKey: subscription)
                                            UserDefaults.standard.set("Nothing", forKey: activePlanName)
                                            self.dismiss(animated: true)
                                            //                                            self.gotoTabBarVC()
                                        } else {
                                            dismissProgress()
                                            UserDefaults.standard.set(true, forKey: subscription)
                                            UserDefaults.standard.set(customerInfo?.activeSubscriptions.first, forKey: activePlanName)
                                            self.dismiss(animated: true)
                                            //                                            self.gotoTabBarVC()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    
    @IBAction func privacyPolicyBTN(_ sender: Any) {
        let privacyPolicyUrl = URL(string: "https://www.viprak.com/privacy-policy-2/")!
        let safariVC = SFSafariViewController(url: privacyPolicyUrl)
        self.present(safariVC, animated: true, completion: nil)
    }
    
    @IBAction func termsOfUseBTN(_ sender: Any) {
        let privacyPolicyUrl = URL(string: "https://www.viprak.com/terms/")!
        let safariVC = SFSafariViewController(url: privacyPolicyUrl)
        self.present(safariVC, animated: true, completion: nil)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func restoreBTN(_ sender: Any) {
        showProgress("")
        Purchases.shared.restorePurchases { (purchaserInfo, error) in
            if let error = error {
                dismissProgress()
                self.view.makeToast(error.localizedDescription)
            } else {
                Purchases.shared.getCustomerInfo { (customerInfo, error) in
                    if customerInfo?.activeSubscriptions.isEmpty == true {
                        dismissProgress()
                        self.view.makeToast("You don't have any purchase!")
                        UserDefaults.standard.set(false, forKey: subscription)
                        UserDefaults.standard.set("Nothing", forKey: activePlanName)
                    } else {
                        dismissProgress()
                        self.view.makeToast("Restored Successfully!!!")
                        UserDefaults.standard.set(true, forKey: subscription)
                        UserDefaults.standard.set(customerInfo?.activeSubscriptions.first, forKey: activePlanName)
                        self.dismiss(animated: true)
                        //                        self.gotoTabBarVC()
                    }
                }
            }
        }
    }
    
}


