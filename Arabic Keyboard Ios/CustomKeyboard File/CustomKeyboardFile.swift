//
//  CustomKeyboardFile.swift
//  Arabic Keyboard Ios
//
//  Created by Viprak-Monil on 19/03/24.
//

import UIKit
import AVFoundation

protocol KeyboardDelegate: class {
    func keyWasTapped(text: String)
    func numberButton(button: UIButton)
    func backspaceButton(button:UIButton)
    func returnButton(button:UIButton)
    func dismissButton(button:UIButton)
    func spaceButton(button:UIButton)
    func capsLock(button:UIButton)
    func emoji(button:UIButton)
}

class CustomKeyboardFile: UIView {
    
    @IBOutlet weak var abcdView: UIView!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet var viewBackgroundView: UIView!
    @IBOutlet weak var keyboardImageView: UIImageView!
    @IBOutlet  var keyot: [UIButton]!
    @IBOutlet weak var spaceOt: UIButton!
    @IBOutlet  var buttonOt: [UIButton]!
    @IBOutlet weak var numberKeyOt: UIButton!
    @IBOutlet weak var numberCapsLockView: UIView!
    @IBOutlet weak var bottomButtonView: UIView!
    
    weak var delegate: KeyboardDelegate?
    private var player: AVAudioPlayer?
    let defaults = UserDefaults.standard
    let ON_OFF_KEY = "onOffKey"
    var isViewVisible = false
    let appGroupID = "group.arabic.custom.keyboard"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //commonInin()
        common()
        applyTheme()
        
    }
    
    required init?(coder aDecoder : NSCoder) {
        super.init(coder: aDecoder)
        //commonInin()
        common()
        applyTheme()
        
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
    
    
    private func applyTheme() {
        
        let selectedTheme = UserDefaults.standard.integer(forKey: "SelectedTheme")
        // UserDefaults.standard.bool(forKey: "isSaved")
        // Apply theme based on selectedTheme value
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
            numberView.isHidden = true
            numberCapsLockView.isHidden = true
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
            keyboardImageView.image = UIImage(named: "b10")
            numberView.isHidden = true
            numberCapsLockView.isHidden = true
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
            numberView.isHidden = true
            numberCapsLockView.isHidden = true
//                            viewBackgroundView.backgroundColor = .clear
//                            abcdView.backgroundColor = .clear
            keyboardImageView.image = UIImage(named: "b11")
            
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
            keyboardImageView.image = UIImage(named: "b12")
            numberView.isHidden = true
            numberCapsLockView.isHidden = true
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
            keyboardImageView.image = UIImage(named: "b13")
            numberView.isHidden = true
            numberCapsLockView.isHidden = true
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
    }
    private func common() {
        let xibFileName = "CustomKeyboardView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }
    
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
    
    @IBAction func keyboardKeyTapped(button: UIButton) {
        self.delegate?.keyWasTapped(text: button.titleLabel!.text!)
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
        //        playKeyboardClickSound()
        //        provideHapticFeedback()
        if let soundOnOrOff = UserDefaults.standard.value(forKey: "ISSOUNDONOROFF") {
            playKeyboardClickSound()
        }
        
        if UserDefaults.standard.value(forKey: "ISHAPTICONOROFF") != nil {
            let generator = UIImpactFeedbackGenerator(style:.heavy)
            generator.impactOccurred()
            
        }
        
        
    }
    @IBAction func numberButtonTapped(button: UIButton) {
        self.delegate?.numberButton(button: button)
        numberCapsLockView.isHidden = true
        numberView.isHidden = true
        if button.titleLabel!.text == "٢٣١" {
            numberCapsLockView.isHidden = true
            abcdView.isHidden = true
            numberView.isHidden = false
            button.setTitle("عربي", for: .normal)
        } else if button.titleLabel!.text == "عربي" {
            numberCapsLockView.isHidden = true
            abcdView.isHidden = false
            numberView.isHidden = true
            button.setTitle("٢٣١", for: .normal)
        }
    }
    
    @IBAction func backsapceButtonTapped(button: UIButton) {
        self.delegate?.backspaceButton(button: button)
    }
    
    @IBAction func returnButtonTapped(button: UIButton) {
        self.delegate?.returnButton(button: button)
    }
    
    @IBAction func dismissKeyboardTapped(button: UIButton) {
        self.delegate?.dismissButton(button: button)
    }
    
    @IBAction func spacebuttontapped(button: UIButton) {
        self.delegate?.spaceButton(button: button)
    }
    
    @IBAction func capsLockButtonTapped(button: UIButton) {
        if isViewVisible{
            numberCapsLockView.isHidden = true
            abcdView.isHidden = false
        }
        else{
            self.delegate?.capsLock(button: button)
            abcdView.isHidden = true
            numberView.isHidden = true
            numberCapsLockView.isHidden = false
            
        }
        isViewVisible = !isViewVisible
    }
    
    
    @IBAction func emojiButtonTapped(button:UIButton) {
        if isViewVisible{
            numberCapsLockView.isHidden = true
            abcdView.isHidden = false
        }
        else{
            self.delegate?.emoji(button: button)
            //            lazy var swiftEmojiKeyboard: SwiftEmojiKeyboard = {
            //                let swiftEmojiKeyboard = SwiftEmojiKeyboard(viewController: self)
            //                //swiftEmojiKeyboard.delegate = self
            //                return swiftEmojiKeyboard
            //            }()
            //            lazy var swiftEmojiKeyboard: SwiftEmojiKeyboard = {
            //                let swiftEmojiKeyboard = SwiftEmojiKeyboard(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
            //                //swiftEmojiKeyboard.delegate = self
            //                return swiftEmojiKeyboard
            //            }()
            abcdView.isHidden = true
            numberView.isHidden = true
            numberCapsLockView.isHidden = true
        }
        isViewVisible = !isViewVisible
    }
    
}


extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}


