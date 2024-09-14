//
//  ViewController.swift
//  Arabic Keyboard Ios
//
//  Created by Viprak-Monil on 19/03/24.
//

import UIKit
import SideMenuSwift
import GoogleMobileAds

class ViewController: UIInputViewController,KeyboardDelegate{
    
    // MARK: IBOUTLET
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textSlider: UISlider!
    @IBOutlet weak var textSizeLabel: UILabel!
    @IBOutlet weak var textSizeView: UIView!
    @IBOutlet weak var buttonView: UIStackView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    @IBOutlet weak var buttonViewconstants: NSLayoutConstraint!
    @IBOutlet weak var underlineButtonOT: UIButton!
    @IBOutlet weak var translateButton: UIButton!
    
    // MARK: VARIABLES
    var size : CGFloat = 0.0
    var customKeyboardView : CustomKeyboardFile?
    var rewardedAd: GADRewardedAd?
    private var numCalls = 0
    var isUnderlined = false
    var sideChange = false
    var hideView = false
    var appOpenAd: GADAppOpenAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        global()
        // check()
        loadRewardedAd()
        textView.delegate = self
        textView.text = "الرجاء كتابة هنا....."
        textView.textColor = UIColor.lightGray
        textView.textAlignment = .right
        //appOpenAD()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        check()
        print(UIDevice.current.modelName)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        if UserDefaults.standard.bool(forKey: subscription) == true{
        //            print("Subscription Active")
        //        }else{
        //            showAppOpenAd()
        //        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    lazy var swiftEmojiKeyboard: SwiftEmojiKeyboard = {
        let swiftEmojiKeyboard = SwiftEmojiKeyboard(frame: CGRect(x: 0, y: 0, width: 375, height: 300))
        swiftEmojiKeyboard.delegate = self
        // print("Swift Emoji Keyboard size: \(swiftEmojiKeyboard.frame.size)")
        return swiftEmojiKeyboard
    }()
    
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
    func appOpenAD(){
        let request = GADRequest()
        GADAppOpenAd.load(withAdUnitID: "/23143498483/APPOpen", request: GADRequest()) { ad, error in
            if let error = error {
                self.appOpenAd = nil
                //                self.loadTime = nil
                print("App open ad failed to load with error: \(error.localizedDescription).")
                return
            }
            self.appOpenAd = ad
            self.appOpenAd?.fullScreenContentDelegate = self
            //            self.loadTime = Date()
            print("App open ad loaded successfully.")
        }
    }
    func showAppOpenAd() {
        if let ad = appOpenAd {
            ad.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
    }
    func global(){
        textSizeView.isHidden = true
        textView.font = UIFont.systemFont(ofSize: 15.0)
        textSizeLabel.text = "\(Int(textSlider.value)) %"
        self.textView.textAlignment = .right
        textView.layer.cornerRadius = 12
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor(hexFromString: "ABB5BE").cgColor
        buttonView.layer.cornerRadius = 33
        buttonView.layer.masksToBounds = true
        buttonView.layer.borderColor = UIColor(hexFromString: "ABB5BE").cgColor
        buttonView.layer.borderWidth = 1
        translateButton.layer.borderColor = UIColor(hexFromString: "ABB5BE").cgColor
        translateButton.layer.borderWidth = 1
        translateButton.layer.cornerRadius = 16
        translateButton.layer.masksToBounds = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    
    // MARK: PROTOCOL FUNCTION
    func keyWasTapped(text character: String) {
        if String(character) != nil{
            textView.insertText(character)
        }
    }
    func numberButton(button: UIButton) {
        textView.inputView = button
    }
    func backspaceButton(button: UIButton) {
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }
    func returnButton(button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText("\n")
    }
    func dismissButton(button: UIButton) {
        dismissKeyboard()
    }
    func spaceButton(button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText(" ")
    }
    func capsLock(button: UIButton) {
        textView.inputView = button
        
    }
    @objc func showEmojiKeyboard() {
        textViewHeight.constant = 465
        textView.inputView = swiftEmojiKeyboard
        textView.reloadInputViews() // Reload input views to update the keyboard
        textView.becomeFirstResponder() // Show the keyboard
    }
    
    func emoji(button : UIButton) {
        textView.inputView = button
        showEmojiKeyboard()
    }
    
    // MARK: KEYBOARD SHOW
    func check(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        //        NotificationCenter.default.addObserver(self, selector: #selector(ipadkeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        //        NotificationCenter.default.addObserver(self, selector: #selector(ipadkeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            textSizeView.isHidden = true
            let deviceModel = UIDevice.current.modelName
            if UIDevice.current.modelName == "iPhone 7 Plus"{
                textViewHeight.constant = 140
            }
            else if UIDevice.current.modelName == "iPhone XS Max" {
                textViewHeight.constant = 250
            }else if UIDevice.current.modelName == "iPhone XR" {
                textViewHeight.constant = 250
            }else if UIDevice.current.modelName == "iPhone 11" {
                textViewHeight.constant = 235
            }else if UIDevice.current.modelName == "iPhone 11 Pro Max" {
                textViewHeight.constant = 245
            }else if UIDevice.current.modelName == "iPhone 12 mini" {
                textViewHeight.constant = 170
            }else if UIDevice.current.modelName == "iPhone 12" {
                textViewHeight.constant = 205
            }else if UIDevice.current.modelName == "iPhone 12 Pro" {
                textViewHeight.constant = 205
            }else if UIDevice.current.modelName == "iPhone 12 Pro Max" {
                textViewHeight.constant = 275
            }else if UIDevice.current.modelName == "iPhone 13" {
                textViewHeight.constant = 205
            }else if UIDevice.current.modelName == "iPhone 13 Pro" {
                textViewHeight.constant = 205
            }else if UIDevice.current.modelName == "iPhone 13 mini" {
                textViewHeight.constant = 180
            }else if UIDevice.current.modelName == "iPhone 13 Pro Max" {
                textViewHeight.constant = 275
            }else if UIDevice.current.modelName == "iPhone 14" {
                textViewHeight.constant = 205
            }else if UIDevice.current.modelName == "iPhone 14 Plus" {
                textViewHeight.constant = 275
            }else if UIDevice.current.modelName == "iPhone 14 Pro" {
                textViewHeight.constant = 205
            }else if UIDevice.current.modelName == "iPhone 14 Pro Max" {
                textViewHeight.constant = 275
            }else if UIDevice.current.modelName == "iPhone 15"{
                textViewHeight.constant = 180
            }else if UIDevice.current.modelName == "iPhone 15 Pro" {
                textViewHeight.constant = 200
            }else if UIDevice.current.modelName == "iPhone 15 Plus" {
                textViewHeight.constant = 275
            }else if UIDevice.current.modelName == "iPhone 15 Pro Max" {
                textViewHeight.constant = 275
            }else{
//                print("ks=\(keyboardSize.height)")
//                if size == 0.0 {
//                    size = keyboardSize.height /*+ 250*/
//                }
//                print("k=\(size)")
//                textSizeView.isHidden = true
//                let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
//                textViewHeight.constant -= size - 15
                textViewHeight.constant = 140
                print("Default size : \(textViewHeight.constant)")
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        textViewHeight.constant = 465
    }
    override func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: ALERT
    func openalert(){
        //        textViewHeight.constant = 465
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure you wish to delete text?", preferredStyle: .alert)
        let no = UIAlertAction(title: "No", style: .cancel)
        alert.addAction(no)
        let Yes = UIAlertAction(title: "Yes", style: .default){ action in
            self.textView.text = ""
        }
        alert.addAction(Yes)
        present(alert, animated: true)
    }
    func showAlert(){
        //        textViewHeight.constant = 465
        let alert = UIAlertController(title: "Validation", message: "Inputbox is empty.please enter at least single word.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    func underlineAllText() {
        guard let attributedText = textView.attributedText.mutableCopy() as? NSMutableAttributedString else {
            return
        }
        
        let range = NSRange(location: 0, length: attributedText.length)
        attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        
        textView.attributedText = attributedText
    }
    
    func removeUnderline() {
        guard let attributedText = textView.attributedText.mutableCopy() as? NSMutableAttributedString else {
            return
        }
        
        let range = NSRange(location: 0, length: attributedText.length)
        attributedText.removeAttribute(.underlineStyle, range: range)
        
        textView.attributedText = attributedText
    }
    
    func textOpenAlert(){
        let alert = UIAlertController(title: "Share text", message: "Select the type of text that you want to share", preferredStyle: .alert)
        let plain = UIAlertAction(title: "Plain Text", style: .default) { action in
            let objectsToShare = [self.textView.text!] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            self.present(activityVC, animated: true, completion: nil)
            // }
        }
        alert.addAction(plain)
        let edit = UIAlertAction(title: "Edited Text", style: .default) { action in
            let objectsToShare = [self.textView.text!] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            self.present(activityVC, animated: true, completion: nil)
            // }
        }
        alert.addAction(edit)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    // MARK: ACTION
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        if textView.text.isEmpty{
            print("please write text")
        }
        else{
            //  buttonViewconstants.constant = 0
            //  textViewHeight.constant = 465
            view.endEditing(true)
            DispatchQueue.main.asyncAfter(deadline: .now()+1){
                self.openalert()
            }
            
        }
        
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        // textViewHeight.constant = 465
        view.endEditing(true)
        DispatchQueue.main.asyncAfter(deadline: .now()+1){
            self.textOpenAlert()
        }
    }
    
    
    @IBAction func colourButtonTapped(_ sender: Any) {
        view.endEditing(true)
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        present(colorPicker, animated: true, completion: nil)
    }
    
    @IBAction func underlineButtonTapped(_ sender: Any) {
        
        isUnderlined.toggle()
        
        // Apply or remove underline based on current state
        if isUnderlined {
            underlineAllText()
        } else {
            removeUnderline()
        }
    }
    
    
    @IBAction func textSliderHandle(_ sender: UISlider) {
        let fontSize = Int(sender.value)
        textView.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        textSizeLabel.text = "\(Int(textSlider.value)) %"
    }
    
    
    @IBAction func textSizeButton(_ sender: Any) {
        hideView.toggle()
        if hideView{
            textSizeView.isHidden = false
            view.endEditing(true)
        }
        else{
            textSizeView.isHidden = true
        }
        
    }
    
    
    @IBAction func sizeTextDoneButton(_ sender: Any) {
        let newSize = CGFloat(textSlider.value)
        textView.font = UIFont.systemFont(ofSize: newSize)
        textSizeView.isHidden = true
    }
    
    
    @IBAction func sideChangeButtonAction(_ sender: Any) {
        sideChange.toggle()
        if sideChange{
            self.textView.textAlignment = .left
        }
        else{
            self.textView.textAlignment = .right
        }
        //set text alignment center and justified
        //        self.textView.makeTextWritingDirectionRightToLeft(true)//if you want set writing direction right to left
        //        self.textView.makeTextWritingDirectionLeftToRight(true)
    }
    
    
    @IBAction func settingButtonTapped(_ sender: Any) {
//        if UserDefaults.standard.bool(forKey: subscription) == true{
//            print("subscription active")
//            view.endEditing(true)
//            let navigate = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
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
//                
//            }
            view.endEditing(true)
            let vc = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func translateButtonTapped(_ sender: Any) {
        if textView.text.isEmpty{
            self.showAlert()
        }else{
            view.endEditing(true)
            let navigate = storyboard?.instantiateViewController(withIdentifier: "TranslateScreen") as! TranslateScreen
            navigate.shareText = textView.text
            navigationController?.pushViewController(navigate, animated: true)
        }
    }
    
    
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        sideMenuController?.revealMenu()
        view.endEditing(true)
    }
    
    @IBAction func segmentController(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            let keyboardView = CustomKeyboardFile(frame: CGRect(x: 0, y: 0, width: 375, height: 300))
            keyboardView.delegate = self
            textView.inputView = keyboardView
            textView.reloadInputViews()
            self.textView.textAlignment = .right
            if textView.text == "Please type here..." {
                textView.text = "الرجاء كتابة هنا....."
                textView.textColor = UIColor.lightGray
            }
            textViewHeight.constant = 465
        case 1:
            self.textView.textAlignment = .left
            if textView.text == "الرجاء كتابة هنا....." {
                textView.text = "Please type here..."
                textView.textColor = UIColor.lightGray
            }
            textView.inputView = nil
            textView.reloadInputViews()
            textViewHeight.constant = 465
        default:
            break
        }
    }
    
}

// MARK: EXTENSION METHOD
extension ViewController: UIColorPickerViewControllerDelegate{
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let selectedColor = viewController.selectedColor
        textView.textColor = selectedColor
    }
}

extension ViewController:UITextViewDelegate{
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if segment.selectedSegmentIndex == 0 {
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.black
            }
            textViewHeight.constant = 465
            let keyboardView = CustomKeyboardFile(frame: CGRect(x: 0, y: 0, width: 375, height: 300))
            keyboardView.delegate = self
            textView.inputView = keyboardView
            textView.reloadInputViews()
        } else {
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.black
            }
            textView.inputView = nil
            textView.reloadInputViews()
            textViewHeight.constant = 465
        }
        
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            if segment.selectedSegmentIndex == 0 {
                textView.text = "الرجاء كتابة هنا....."
            } else {
                textView.text = "Please type here..."
            }
            
            textView.textColor = UIColor.lightGray
        }
    }
}


extension ViewController: GADFullScreenContentDelegate {
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        // Reload the ad after it's dismissed.
        loadRewardedAd()
//        appOpenAD()
    }
}

extension ViewController: SwiftEmojiKeyboardDelegate {
    
    func swiftEmojiKeyboard(didSelect emoji: String, didSelectItemAt indexPath: IndexPath) {
        //        guard let text = customTextView.text else {return}
        //        customTextView.text = text + "\(emoji)"
        textView.text += emoji
        //  textViewDidChange(customTextView)
    }
    
    
    func swiftEmojiKeyboard(didChangeCategoryAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func swiftEmojiKeyboard(didChangeKeyboard type: KeyboardType) {
        // swiftEmojiKeyboard.isHidden =  true
        textViewHeight.constant = 465
        let keyboardView = CustomKeyboardFile(frame: CGRect(x: 0, y: 0, width: 375, height: 300))
        keyboardView.delegate = self
        textView.inputView = keyboardView
        textView.reloadInputViews()
        textView.becomeFirstResponder()
    }
    
    func swiftEmojiKeyboard(didSelectReturn newLine: Bool) {
        (textDocumentProxy as UIKeyInput).insertText("\n")
    }
    
    func swiftEmojiKeyboard(didSelectDelete delete: Bool) {
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }
    
}
