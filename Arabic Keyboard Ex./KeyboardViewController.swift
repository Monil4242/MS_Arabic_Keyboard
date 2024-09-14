//
//  KeyboardViewController.swift
//  Arabic Keyboard Ex.
//
//  Created by Viprak-Monil on 19/03/24.

import UIKit
import AVFAudio

class KeyboardViewController: UIInputViewController,UITextFieldDelegate {
    
    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet weak var numberCapsView: UIView!
    @IBOutlet weak var numberViews: UIView!
    @IBOutlet weak var abcdViews: UIView!
    @IBOutlet weak var themeBGIMG: UIImageView!
    
    @IBOutlet  var keyot: [UIButton]!
    @IBOutlet weak var spaceOt: UIButton!
    @IBOutlet  var buttonOt: [UIButton]!
    @IBOutlet weak var numberKeyOt: UIButton!
    @IBOutlet weak var bottomButtonView: UIView!
    @IBOutlet var viewBackgroundView: UIView!
    
    //  var customKeyboardView : CustomKeyboardFile?
    var capsLockOn = true
    var isViewVisible = false
    private var player: AVAudioPlayer?
    let appGroupID = "group.arabic.custom.keyboard"
    // var keyboardView: CustomKeyboardFile?
    
    lazy var swiftEmojiKeyboard: SwiftEmojiKeyboard = {
        let swiftEmojiKeyboard = SwiftEmojiKeyboard(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300))
        swiftEmojiKeyboard.delegate = self
        return swiftEmojiKeyboard
    }()
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
    }
    
    override func viewDidLoad(){
        let nib = UINib(nibName: "CustomKeyboardViews", bundle: nil)
        let objects = nib.instantiate(withOwner: self, options: nil)
        view = (objects[0] as! UIView)
        //        apply()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apply()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        //
        //        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
    
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
    
    func apply() {
        let appGroupID = "group.Arabic.Keyboard"
        if let userDefaults = UserDefaults(suiteName: appGroupID) {
            let selectedTheme = userDefaults.integer(forKey: "SelectedTheme")
            print("Selected Theme Number \(selectedTheme)")
            switch selectedTheme {
            case 0:
                viewBackgroundView.backgroundColor =  UIColorFromHex(hex: "CED2D9")
                for i in 0..<keyot.count{
                    keyot[i].backgroundColor = UIColorFromHex(hex: "FFFFFF")
                    keyot[i].setTitleColor(.black, for: .normal)
                    keyot[i].layer.cornerRadius = 5
                    keyot[i].layer.masksToBounds = true
                    spaceOt.backgroundColor = UIColorFromHex(hex: "FFFFFF")
                    spaceOt.tintColor = UIColor.black
                    spaceOt.layer.cornerRadius = 5
                    spaceOt.layer.masksToBounds = true
                    
                }
                for i in 0..<buttonOt.count{
                    buttonOt[i].backgroundColor = UIColorFromHex(hex: "AEB3BE")
                    buttonOt[i].tintColor = UIColor.black
                    buttonOt[i].layer.cornerRadius = 5
                    buttonOt[i].layer.masksToBounds = true
                }
                numberKeyOt.backgroundColor =  UIColorFromHex(hex: "AEB3BE")
                numberKeyOt.setTitleColor(.black, for: .normal)
                numberKeyOt.layer.cornerRadius = 5
                numberKeyOt.layer.masksToBounds = true
                
            case 1:
                viewBackgroundView.backgroundColor = UIColorFromHex(hex: "492921")
                for i in 0..<keyot.count{
                    keyot[i].backgroundColor = UIColorFromHex(hex: "853121")
                    keyot[i].setTitleColor(.white, for: .normal)
                    keyot[i].layer.cornerRadius = 5
                    keyot[i].layer.masksToBounds = true
                    spaceOt.backgroundColor = UIColorFromHex(hex: "853121")
                    spaceOt.tintColor = UIColor.white
                    spaceOt.layer.cornerRadius = 5
                    spaceOt.layer.masksToBounds = true
                    
                }
                for i in 0..<buttonOt.count{
                    buttonOt[i].backgroundColor = UIColorFromHex(hex: "AB5433")
                    buttonOt[i].tintColor = UIColor.white
                    buttonOt[i].layer.cornerRadius = 5
                    buttonOt[i].layer.masksToBounds = true
                }
                numberKeyOt.backgroundColor =  UIColorFromHex(hex: "AB5433")
                numberKeyOt.setTitleColor(.white, for: .normal)
                numberKeyOt.layer.cornerRadius = 5
                numberKeyOt.layer.masksToBounds = true
            case 2:
                viewBackgroundView.backgroundColor = UIColorFromHex(hex: "B4D3FF")
                for i in 0..<keyot.count{
                    keyot[i].backgroundColor = UIColorFromHex(hex: "87B9FE")
                    keyot[i].setTitleColor(.black, for: .normal)
                    keyot[i].layer.cornerRadius = 5
                    keyot[i].layer.masksToBounds = true
                    spaceOt.backgroundColor = UIColorFromHex(hex: "87B9FE")
                    spaceOt.tintColor = UIColor.black
                    spaceOt.layer.cornerRadius = 5
                    spaceOt.layer.masksToBounds = true
                    
                }
                for i in 0..<buttonOt.count{
                    buttonOt[i].backgroundColor = UIColorFromHex(hex: "5199FF")
                    buttonOt[i].tintColor = UIColor.black
                    buttonOt[i].layer.cornerRadius = 5
                    buttonOt[i].layer.masksToBounds = true
                }
                numberKeyOt.backgroundColor =  UIColorFromHex(hex: "5199FF")
                numberKeyOt.setTitleColor(.black, for: .normal)
                numberKeyOt.layer.cornerRadius = 5
                numberKeyOt.layer.masksToBounds = true
            case 3:
                viewBackgroundView.backgroundColor = UIColorFromHex(hex: "CCEAE2")
                for i in 0..<keyot.count{
                    keyot[i].backgroundColor = UIColorFromHex(hex: "FFFFFF")
                    keyot[i].setTitleColor(.black, for: .normal)
                    keyot[i].layer.cornerRadius = 5
                    keyot[i].layer.masksToBounds = true
                    spaceOt.backgroundColor = UIColorFromHex(hex: "FFFFFF")
                    spaceOt.tintColor = UIColor.black
                    spaceOt.layer.cornerRadius = 5
                    spaceOt.layer.masksToBounds = true
                }
                for i in 0..<buttonOt.count{
                    buttonOt[i].backgroundColor = UIColorFromHex(hex: "87C3BC")
                    buttonOt[i].tintColor = UIColor.black
                    buttonOt[i].layer.cornerRadius = 5
                    buttonOt[i].layer.masksToBounds = true
                }
                numberKeyOt.backgroundColor =  UIColorFromHex(hex: "87C3BC")
                numberKeyOt.setTitleColor(.black, for: .normal)
                numberKeyOt.layer.cornerRadius = 5
                numberKeyOt.layer.masksToBounds = true
            case 4:
                viewBackgroundView.backgroundColor = UIColorFromHex(hex: "38373D")
                for i in 0..<keyot.count{
                    keyot[i].backgroundColor = UIColorFromHex(hex: "676975")
                    keyot[i].setTitleColor(.white, for: .normal)
                    keyot[i].layer.cornerRadius = 5
                    keyot[i].layer.masksToBounds = true
                    spaceOt.backgroundColor = UIColorFromHex(hex: "676975")
                    spaceOt.tintColor = UIColor.white
                    spaceOt.layer.cornerRadius = 5
                    spaceOt.layer.masksToBounds = true
                }
                for i in 0..<buttonOt.count{
                    buttonOt[i].backgroundColor = UIColorFromHex(hex: "FFFFFF")
                    buttonOt[i].tintColor = UIColor.black
                    buttonOt[i].layer.cornerRadius = 5
                    buttonOt[i].layer.masksToBounds = true
                }
                numberKeyOt.backgroundColor =  UIColorFromHex(hex: "FFFFFF")
                numberKeyOt.setTitleColor(.black, for: .normal)
                numberKeyOt.layer.cornerRadius = 5
                numberKeyOt.layer.masksToBounds = true
            case 5:
                viewBackgroundView.backgroundColor = UIColorFromHex(hex: "FFFFFF")
                for i in 0..<keyot.count{
                    keyot[i].backgroundColor = UIColorFromHex(hex: "F2CD98")
                    keyot[i].setTitleColor(.black, for: .normal)
                    keyot[i].layer.cornerRadius = 5
                    keyot[i].layer.masksToBounds = true
                    spaceOt.backgroundColor = UIColorFromHex(hex: "F2CD98")
                    spaceOt.tintColor = UIColor.black
                    spaceOt.layer.cornerRadius = 5
                    spaceOt.layer.masksToBounds = true
                }
                for i in 0..<buttonOt.count{
                    buttonOt[i].backgroundColor = UIColorFromHex(hex: "E96D48")
                    buttonOt[i].tintColor = UIColor.black
                    buttonOt[i].layer.cornerRadius = 5
                    buttonOt[i].layer.masksToBounds = true
                }
                numberKeyOt.backgroundColor =  UIColorFromHex(hex: "E96D48")
                numberKeyOt.setTitleColor(.black, for: .normal)
                numberKeyOt.layer.cornerRadius = 5
                numberKeyOt.layer.masksToBounds = true
            case 6:
                viewBackgroundView.backgroundColor = UIColorFromHex(hex: "292D30")
                for i in 0..<keyot.count{
                    keyot[i].backgroundColor = UIColorFromHex(hex: "4F5459")
                    keyot[i].setTitleColor(.cyan, for: .normal)
                    keyot[i].layer.cornerRadius = 5
                    keyot[i].layer.masksToBounds = true
                    spaceOt.backgroundColor = UIColorFromHex(hex: "4F5459")
                    spaceOt.tintColor = UIColor.cyan
                    spaceOt.layer.cornerRadius = 5
                    spaceOt.layer.masksToBounds = true
                }
                for i in 0..<buttonOt.count{
                    buttonOt[i].backgroundColor = UIColorFromHex(hex: "4F5459")
                    buttonOt[i].tintColor = UIColor.cyan
                    buttonOt[i].layer.cornerRadius = 5
                    buttonOt[i].layer.masksToBounds = true
                }
                numberKeyOt.backgroundColor =  UIColorFromHex(hex: "4F5459")
                numberKeyOt.setTitleColor(.cyan, for: .normal)
                numberKeyOt.layer.cornerRadius = 5
                numberKeyOt.layer.masksToBounds = true
            case 7:
                viewBackgroundView.backgroundColor = UIColorFromHex(hex: "5C5C5C")
                for i in 0..<keyot.count{
                    keyot[i].backgroundColor = UIColorFromHex(hex: "000000")
                    keyot[i].setTitleColor(.white, for: .normal)
                    keyot[i].layer.borderColor = UIColor.white.cgColor
                    keyot[i].layer.borderWidth = 0.6
                    keyot[i].layer.cornerRadius = 5
                    keyot[i].layer.masksToBounds = true
                    spaceOt.backgroundColor = UIColorFromHex(hex: "000000")
                    spaceOt.tintColor = UIColor.white
                    spaceOt.layer.borderColor = UIColor.white.cgColor
                    spaceOt.layer.borderWidth = 0.6
                    spaceOt.layer.cornerRadius = 5
                    spaceOt.layer.masksToBounds = true
                }
                for i in 0..<buttonOt.count{
                    buttonOt[i].backgroundColor = UIColorFromHex(hex: "000000")
                    buttonOt[i].tintColor = UIColor.white
                    buttonOt[i].layer.borderColor = UIColor.white.cgColor
                    buttonOt[i].layer.borderWidth = 0.6
                    buttonOt[i].layer.cornerRadius = 5
                    buttonOt[i].layer.masksToBounds = true
                }
                numberKeyOt.backgroundColor =  UIColorFromHex(hex: "000000")
                numberKeyOt.setTitleColor(.white, for: .normal)
                numberKeyOt.layer.borderColor = UIColor.white.cgColor
                numberKeyOt.layer.borderWidth = 0.6
                numberKeyOt.layer.cornerRadius = 5
                numberKeyOt.layer.masksToBounds = true
                //
            case 8:
                viewBackgroundView.backgroundColor = UIColorFromHex(hex: "241E1E")
                for i in 0..<keyot.count{
                    keyot[i].backgroundColor = UIColorFromHex(hex: "FFB200")
                    keyot[i].setTitleColor(.black, for: .normal)
                    keyot[i].layer.cornerRadius = 5
                    keyot[i].layer.masksToBounds = true
                    spaceOt.backgroundColor = UIColorFromHex(hex: "FFB200")
                    spaceOt.tintColor = UIColor.black
                    spaceOt.layer.cornerRadius = 5
                    spaceOt.layer.masksToBounds = true
                }
                for i in 0..<buttonOt.count{
                    buttonOt[i].backgroundColor = UIColorFromHex(hex: "F73434")
                    buttonOt[i].tintColor = UIColor.white
                    buttonOt[i].layer.cornerRadius = 5
                    buttonOt[i].layer.masksToBounds = true
                }
                numberKeyOt.backgroundColor =  UIColorFromHex(hex: "F73434")
                numberKeyOt.setTitleColor(.white, for: .normal)
                numberKeyOt.layer.cornerRadius = 5
                numberKeyOt.layer.masksToBounds = true
                //            //                viewBackgroundView.backgroundColor = .clear
                //            //                abcdView.backgroundColor = .clear
                //            keyboardImageView.image = UIImage(named: "b8")
                //            numberView.isHidden = true
                //            numberCapsLockView.isHidden = true
                //            for i in 0..<keyot.count{
                //                keyot[i].backgroundColor = UIColor.black.withAlphaComponent(0.30)
                //                keyot[i].setTitleColor(.white, for: .normal)
                //                keyot[i].layer.cornerRadius = 5
                //                keyot[i].layer.masksToBounds = true
                //                spaceOt.backgroundColor = UIColorFromHex(hex: "000000").withAlphaComponent(0.30)
                //                spaceOt.tintColor = UIColor.white
                //                spaceOt.layer.cornerRadius = 5
                //                spaceOt.layer.masksToBounds = true
                //            }
                //            for i in 0..<buttonOt.count{
                //                buttonOt[i].backgroundColor = UIColorFromHex(hex: "000000").withAlphaComponent(0.30)
                //                buttonOt[i].tintColor = UIColor.white
                //                buttonOt[i].layer.cornerRadius = 5
                //                buttonOt[i].layer.masksToBounds = true
                //            }
                //            numberKeyOt.backgroundColor =  UIColorFromHex(hex: "000000").withAlphaComponent(0.30)
                //            numberKeyOt.setTitleColor(.white, for: .normal)
                //            numberKeyOt.layer.cornerRadius = 5
                //            numberKeyOt.layer.masksToBounds = true
                //            // viewBackgroundView.backgroundColor = UIColorFromHex(hex: "FFFFFF")
            case 9:
                viewBackgroundView.backgroundColor = UIColorFromHex(hex: "121933")
                numberViews.isHidden = true
                numberCapsView.isHidden = true
                for i in 0..<keyot.count{
                    keyot[i].backgroundColor = .clear
                    keyot[i].setTitleColor(.white, for: .normal)
                    keyot[i].layer.borderColor = UIColorFromHex(hex: "94FDF9").cgColor
                    keyot[i].layer.borderWidth = 0.6
                    keyot[i].layer.cornerRadius = 5
                    keyot[i].layer.masksToBounds = true
                    spaceOt.backgroundColor = .clear
                    spaceOt.tintColor = UIColor.white
                    spaceOt.layer.borderColor = UIColorFromHex(hex: "94FDF9").cgColor
                    spaceOt.layer.borderWidth = 0.6
                    spaceOt.layer.cornerRadius = 5
                    spaceOt.layer.masksToBounds = true
                }
                for i in 0..<buttonOt.count{
                    buttonOt[i].backgroundColor = .clear
                    buttonOt[i].tintColor = UIColor.white
                    buttonOt[i].layer.borderColor = UIColorFromHex(hex: "94FDF9").cgColor
                    buttonOt[i].layer.borderWidth = 0.6
                    buttonOt[i].layer.cornerRadius = 5
                    buttonOt[i].layer.masksToBounds = true
                }
                numberKeyOt.backgroundColor = .clear
                numberKeyOt.setTitleColor(.white, for: .normal)
                numberKeyOt.layer.borderColor = UIColorFromHex(hex: "94FDF9").cgColor
                numberKeyOt.layer.borderWidth = 0.6
                numberKeyOt.layer.cornerRadius = 5
                numberKeyOt.layer.masksToBounds = true
                
                //            keyboardImageView.image = UIImage(named: "b9")
                //            numberView.isHidden = true
                //            numberCapsLockView.isHidden = true
                //            for i in 0..<keyot.count{
                //                keyot[i].backgroundColor = UIColor.white.withAlphaComponent(0.30)
                //                keyot[i].setTitleColor(.white, for: .normal)
                //                keyot[i].layer.cornerRadius = 5
                //                keyot[i].layer.masksToBounds = true
                //                spaceOt.backgroundColor = UIColorFromHex(hex: "FFFFFF").withAlphaComponent(0.30)
                //                spaceOt.tintColor = UIColor.white
                //                spaceOt.layer.cornerRadius = 5
                //                spaceOt.layer.masksToBounds = true
                //            }
                //            for i in 0..<buttonOt.count{
                //                buttonOt[i].backgroundColor = UIColorFromHex(hex: "FFFFFF").withAlphaComponent(0.30)
                //                buttonOt[i].tintColor = UIColor.white
                //                buttonOt[i].layer.cornerRadius = 5
                //                buttonOt[i].layer.masksToBounds = true
                //            }
                //            numberKeyOt.backgroundColor =  UIColorFromHex(hex: "FFFFFF").withAlphaComponent(0.30)
                //            numberKeyOt.setTitleColor(.white, for: .normal)
                //            numberKeyOt.layer.cornerRadius = 5
                //            numberKeyOt.layer.masksToBounds = true
                //            //viewBackgroundView.backgroundColor = UIColorFromHex(hex: "33386D")
            case 10:
                //                viewBackgroundView.backgroundColor = .clear
                //                abcdView.backgroundColor = .clear
                themeBGIMG.image = UIImage(named: "b10")
                numberViews.isHidden = true
                numberCapsView.isHidden = true
                for i in 0..<keyot.count{
                    keyot[i].backgroundColor = UIColor.black.withAlphaComponent(0.30)
                    keyot[i].setTitleColor(.white, for: .normal)
                    keyot[i].layer.cornerRadius = 5
                    keyot[i].layer.masksToBounds = true
                    spaceOt.backgroundColor = UIColorFromHex(hex: "000000").withAlphaComponent(0.30)
                    spaceOt.tintColor = UIColor.white
                    spaceOt.layer.cornerRadius = 5
                    spaceOt.layer.masksToBounds = true
                }
                for i in 0..<buttonOt.count{
                    buttonOt[i].backgroundColor = UIColorFromHex(hex: "000000").withAlphaComponent(0.30)
                    buttonOt[i].tintColor = UIColor.white
                    buttonOt[i].layer.cornerRadius = 5
                    buttonOt[i].layer.masksToBounds = true
                }
                numberKeyOt.backgroundColor =  UIColorFromHex(hex: "000000").withAlphaComponent(0.30)
                numberKeyOt.setTitleColor(.white, for: .normal)
                numberKeyOt.layer.cornerRadius = 5
                numberKeyOt.layer.masksToBounds = true
                //viewBackgroundView.backgroundColor = UIColorFromHex(hex: "B4D3FF")
            case 11:
                numberViews.isHidden = true
                numberCapsView.isHidden = true
    //                            viewBackgroundView.backgroundColor = .clear
    //                            abcdView.backgroundColor = .clear
                themeBGIMG.image = UIImage(named: "b11")
                
                for i in 0..<keyot.count{
                    keyot[i].backgroundColor = UIColor.black.withAlphaComponent(0.30)
                    keyot[i].setTitleColor(.white, for: .normal)
                    keyot[i].layer.cornerRadius = 5
                    keyot[i].layer.masksToBounds = true
                    spaceOt.backgroundColor = UIColorFromHex(hex: "000000").withAlphaComponent(0.30)
                    spaceOt.tintColor = UIColor.white
                    spaceOt.layer.cornerRadius = 5
                    spaceOt.layer.masksToBounds = true
                }
                for i in 0..<buttonOt.count{
                    buttonOt[i].backgroundColor = UIColorFromHex(hex: "000000").withAlphaComponent(0.30)
                    buttonOt[i].tintColor = UIColor.white
                    buttonOt[i].layer.cornerRadius = 5
                    buttonOt[i].layer.masksToBounds = true
                }
                numberKeyOt.backgroundColor =  UIColorFromHex(hex: "000000").withAlphaComponent(0.30)
                numberKeyOt.setTitleColor(.white, for: .normal)
                numberKeyOt.layer.cornerRadius = 5
                numberKeyOt.layer.masksToBounds = true
                // viewBackgroundView.backgroundColor = UIColorFromHex(hex: "FFFFFF")
            case 12:
                viewBackgroundView.backgroundColor = UIColorFromHex(hex: "FFFFFF")
                
                for i in 0..<3{
                    if i == 0{
                        for j in 0...11{
                            keyot[j].backgroundColor = UIColorFromHex(hex: "C2AAFE")
                            keyot[j].setTitleColor(.black, for: .normal)
                            keyot[j].layer.cornerRadius = 5
                            keyot[j].layer.masksToBounds = true
                        }
                    }
                    else if i == 1{
                        for j in 11...22{
                            keyot[j].backgroundColor = UIColorFromHex(hex: "ABCCFF")
                            keyot[j].setTitleColor(.black, for: .normal)
                            keyot[j].layer.cornerRadius = 5
                            keyot[j].layer.masksToBounds = true
                        }
                    }
                    else{
                        for j in 22...33{
                            keyot[j].backgroundColor = UIColorFromHex(hex: "FFABF6")
                            keyot[j].setTitleColor(.black, for: .normal)
                            keyot[j].layer.cornerRadius = 5
                            keyot[j].layer.masksToBounds = true
                        }
                    }
                }
                spaceOt.backgroundColor = UIColorFromHex(hex: "FFD3A9")
                spaceOt.tintColor = UIColor.black
                spaceOt.layer.cornerRadius = 5
                spaceOt.layer.masksToBounds = true
                //                for i in 0..<keyot.count{
                //                    keyot[i].backgroundColor = UIColorFromHex(hex: "C2AAFE")
                //                    keyot[i].setTitleColor(.black, for: .normal)
                //                    keyot[i].layer.cornerRadius = 5
                //                    keyot[i].layer.masksToBounds = true
                //                    spaceOt.backgroundColor = UIColorFromHex(hex: "C2AAFE")
                //                    spaceOt.tintColor = UIColor.black
                //                    spaceOt.layer.cornerRadius = 5
                //                    spaceOt.layer.masksToBounds = true
                //                }
                for i in 0..<buttonOt.count{
                    buttonOt[i].backgroundColor = UIColorFromHex(hex: "FFABBB")
                    buttonOt[i].tintColor = UIColor.black
                    buttonOt[i].layer.cornerRadius = 5
                    buttonOt[i].layer.masksToBounds = true
                }
                numberKeyOt.backgroundColor =  UIColorFromHex(hex: "FFABBB")
                numberKeyOt.setTitleColor(.black, for: .normal)
                numberKeyOt.layer.cornerRadius = 5
                numberKeyOt.layer.masksToBounds = true
            case 13:
                themeBGIMG.image = UIImage(named: "b12")
                numberViews.isHidden = true
                numberCapsView.isHidden = true
                for i in 0..<keyot.count{
                    keyot[i].backgroundColor = UIColorFromHex(hex: "000000")
                    keyot[i].setTitleColor(.white, for: .normal)
                    keyot[i].layer.cornerRadius = 5
                    keyot[i].layer.masksToBounds = true
                    spaceOt.backgroundColor = UIColorFromHex(hex: "000000")
                    spaceOt.tintColor = UIColor.white
                    spaceOt.layer.cornerRadius = 5
                    spaceOt.layer.masksToBounds = true
                }
                for i in 0..<buttonOt.count{
                    buttonOt[i].backgroundColor = UIColorFromHex(hex: "000000")
                    buttonOt[i].tintColor = UIColor.white
                    buttonOt[i].layer.cornerRadius = 5
                    buttonOt[i].layer.masksToBounds = true
                }
                numberKeyOt.backgroundColor =  UIColorFromHex(hex: "000000")
                numberKeyOt.setTitleColor(.white, for: .normal)
                numberKeyOt.layer.cornerRadius = 5
                numberKeyOt.layer.masksToBounds = true
                //viewBackgroundView.backgroundColor = UIColorFromHex(hex: "B4D3FF")
            case 14:
                themeBGIMG.image = UIImage(named: "b13")
                numberViews.isHidden = true
                numberCapsView.isHidden = true
                for i in 0..<keyot.count{
                    keyot[i].backgroundColor = UIColor.white.withAlphaComponent(0.80)
                    keyot[i].setTitleColor(UIColorFromHex(hex: "22286C"), for: .normal)
                    keyot[i].layer.cornerRadius = 5
                    keyot[i].layer.masksToBounds = true
                    spaceOt.backgroundColor = UIColorFromHex(hex: "FFFFFF").withAlphaComponent(0.80)
                    spaceOt.tintColor = UIColorFromHex(hex: "22286C")
                    spaceOt.layer.cornerRadius = 5
                    spaceOt.layer.masksToBounds = true
                }
                for i in 0..<buttonOt.count{
                    buttonOt[i].backgroundColor = UIColorFromHex(hex: "FFFFFF").withAlphaComponent(0.80)
                    buttonOt[i].tintColor = UIColorFromHex(hex: "22286C")
                    buttonOt[i].layer.cornerRadius = 5
                    buttonOt[i].layer.masksToBounds = true
                }
                numberKeyOt.backgroundColor =  UIColorFromHex(hex: "FFFFFF").withAlphaComponent(0.80)
                numberKeyOt.setTitleColor(UIColorFromHex(hex: "22286C"), for: .normal)
                numberKeyOt.layer.cornerRadius = 5
                numberKeyOt.layer.masksToBounds = true
                //viewBackgroundView.backgroundColor = UIColorFromHex(hex: "B4D3FF")
            default:
                break
            }
        } else {
            print("Unable to create UserDefaults for App Group.")
        }
    }
    
    @IBAction func allKeyPressedBTN(button:UIButton) {
        let string = button.titleLabel!.text
        (self.textDocumentProxy as UIKeyInput).insertText("\(string!)")
        button.transform = CGAffineTransform.identity
        
        let scaleTransform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
        // Animate the button to scale up
        UIView.animate(withDuration: 0.1, animations: {
            button.transform = scaleTransform
        }) { _ in
            // Once the animation completes, update the button's text
            button.setTitle(button.titleLabel?.text, for: .normal)
        }
        
        // After a delay, animate the button back to its original size
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UIView.animate(withDuration: 0.1) {
                button.transform = .identity
            }
        }
        //            let appGroupID = "group.arabic.custom.keyboard"
        //            // Get the shared UserDefaults object
        //            if let userDefaults = UserDefaults(suiteName: appGroupID) {
        //                // Save data to the shared UserDefaults
        //                userDefaults.bool(forKey: "ISSOUNDONOROFF")
        //                self.playKeyboardClickSound()
        //               // UserDefaults.integer(forKey: "SelectedTheme")
        //                //userDefaults.synchronize()
        //
        //                let selectedTheme = userDefaults.bool(forKey: "ISSOUNDONOROFF")
        //            } else {
        //                print("Unable to create UserDefaults for App Group.")
        //            }
        
        if let soundOnOrOff = UserDefaults.standard.value(forKey: "ISSOUNDONOROFF") {
            playKeyboardClickSound()
        }
        if UserDefaults.standard.value(forKey: "ISHAPTICONOROFF") != nil {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
        }
    }
    //    func playKeyboardClickSound() {
    //
    //            if let userDefaults = UserDefaults(suiteName: appGroupID) {
    //                let isSoundOn = userDefaults.bool(forKey: "ISSOUNDONOROFF")
    //                if isSoundOn {
    //                    guard let soundURL = Bundle.main.url(forResource: "Keyboardsound", withExtension: "wav") else { return }
    //                    do {
    //                        player = try AVAudioPlayer(contentsOf: soundURL)
    //                        player?.play()
    //                    } catch {
    //                        print("Error playing keyboard click sound: \(error.localizedDescription)")
    //                    }
    //                }
    //            }
    //        }
    //    func provideHapticFeedback() {
    //            if let userDefaults = UserDefaults(suiteName: appGroupID) {
    //                let isHapticOn = userDefaults.bool(forKey: "ISHAPTICONOROFF")
    //                if isHapticOn {
    //                    let generator = UIImpactFeedbackGenerator(style: .heavy)
    //                    generator.impactOccurred()
    //                }
    //            }
    //        }
    private func playKeyboardClickSound() {
        guard let soundURL = Bundle.main.url(forResource: "Keyboardsound", withExtension: "wav") else { return }
        do {
            // Initialize audio player
            player = try AVAudioPlayer(contentsOf: soundURL)
            player?.play() // Play the sound
        } catch {
            print("Error playing keyboard click sound: \(error.localizedDescription)")
        }
    }
    
    @IBAction func numberButtonTAP(button:UIButton) {
        numberCapsView.isHidden = true
        numberViews.isHidden = true
        if button.titleLabel!.text == "٢٣١" {
            numberCapsView.isHidden = true
            abcdViews.isHidden = true
            numberViews.isHidden = false
            button.setTitle("عربي", for: .normal)
        } else if button.titleLabel!.text == "عربي" {
            numberCapsView.isHidden = true
            abcdViews.isHidden = false
            numberViews.isHidden = true
            button.setTitle("٢٣١", for: .normal)
        }
    }
    
    @IBAction func emojiKeyTapped(_ sender: Any) {
        view.addSubview(swiftEmojiKeyboard)
        //                if isViewVisible{
        //                    numberCapsView.isHidden = true
        //                    abcdViews.isHidden = false
        //                }
        //                else{
        //                    view.addSubview(swiftEmojiKeyboard)
        //        //          lazy var swiftEmojiKeyboard: SwiftEmojiKeyboard = {
        //        //          let swiftEmojiKeyboard = SwiftEmojiKeyboard()
        //        //          print("emoji")
        //        //          swiftEmojiKeyboard.delegate = self
        //        //          return swiftEmojiKeyboard
        //        //          }()
        //                    abcdViews.isHidden = true
        //                    numberViews.isHidden = true
        //                    numberCapsView.isHidden = true
        //                }
        //                isViewVisible = !isViewVisible
    }
    
    @IBAction func backSpaceKeyTapped(_ sender: Any) {
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }
    
    @IBAction func returnKeyTapped(_ sender: Any) {
        (textDocumentProxy as UIKeyInput).insertText("\n")
    }
    
    @IBAction func capsLockKeyTapped(_ sender: Any) {
        if isViewVisible{
            numberCapsView.isHidden = true
            abcdViews.isHidden = false
        }
        else{
            abcdViews.isHidden = true
            numberViews.isHidden = true
            numberCapsView.isHidden = false
            
        }
        isViewVisible = !isViewVisible
    }
    
    @IBAction func dismissKeyTapped(_ sender: Any) {
        dismissKeyboard()
    }
    
    @IBAction func spaceKeyTapped(button:UIButton) {
        (textDocumentProxy as UIKeyInput).insertText(" ")
        let scaleTransform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
        // Animate the button to scale up
        UIView.animate(withDuration: 0.1, animations: {
            button.transform = scaleTransform
        }) { _ in
            // Once the animation completes, update the button's text
            button.setTitle(button.titleLabel?.text, for: .normal)
        }
        
        // After a delay, animate the button back to its original size
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UIView.animate(withDuration: 0.1) {
                button.transform = .identity
            }
        }
    }
}

extension KeyboardViewController: SwiftEmojiKeyboardDelegate {
    
    func swiftEmojiKeyboard(didSelect emoji: String, didSelectItemAt indexPath: IndexPath) {
        (textDocumentProxy as UIKeyInput).insertText(emoji)
    }
    
    
    func swiftEmojiKeyboard(didChangeCategoryAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func swiftEmojiKeyboard(didChangeKeyboard type: KeyboardType) {
        let nib = UINib(nibName: "CustomKeyboardViews", bundle: nil)
        let objects = nib.instantiate(withOwner: self, options: nil)
        view = (objects[0] as! UIView)
        apply()
    }
    
    func swiftEmojiKeyboard(didSelectReturn newLine: Bool) {
        (textDocumentProxy as UIKeyInput).insertText("\n")
    }
    
    func swiftEmojiKeyboard(didSelectDelete delete: Bool) {
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }
    
}
