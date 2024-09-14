//
//  TranslateScreen.swift
//  Arabic Keyboard Ios
//
//  Created by Viprak-Monil on 24/06/24.
//

import UIKit
import iOSDropDown
import MLKit
import SVProgressHUD
import GoogleMobileAds

class TranslateScreen: UIInputViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate,KeyboardDelegate{
    
    // MARK: IBOUTLET
    @IBOutlet weak var segmentOT: UISegmentedControl!
    @IBOutlet weak var firstTextView: UITextView!
    @IBOutlet weak var secondTextView: UITextView!
    @IBOutlet weak var languageTextField: DropDown!
    
    // MARK: VARIABLE
    var rewardedAd: GADRewardedAd?
    let picker = UIImagePickerController()
    var selectedOption : String?
    let dropDown = DropDown()
    private var numCalls = 0
    var size : CGFloat = 0.0
    var shareText = String()
    var arrLanguageOptions = ["Afrikaans","Albanian","Amharic","Arabic","Armenian","Assamese","Aymara","Azerbaijani","Bambara","Basque","Belarusian","Bengali","Bhojpuri","Bosnian","Hindi (India)","Hungarian (Hungary)","Icelandic (iceland)","Indonesian (Indonesia)","Italain (Italy)","Japanese (Japan)","Kazakh (Kazakhistan)","Korean (South Korea)","Lithuanian (Lithuania)","Malay (Malaysia)","Norwegian (Norway)","Polish (Poland)","Portuguese (Brazil)","PortuGuese (Portugal)","Romanian (Romania)","Russian (Russia)","Slovenian (Slovenia)","Spanish(Spain)","Spanish(Mexico)","Swahili (Kenya)","Swedish(Sweden)","Turkish (Turkey)","Thai (Thailand)","Vietnamese (Vietname)"]
    var englishGermanTranslator: Translator?
    var arabicTranslator: Translator?
    var englishTranslator: Translator?
    let languageMap: [String: TranslateLanguage] = [
        "Afrikaans": .afrikaans,
        "Albanian": .albanian,
        "Arabic": .arabic,
        "Belarusian": .belarusian,
        "Bulgarian": .bulgarian,
        "Catalan": .catalan,
        "Chinese": .chinese,
        "Croatian": .croatian,
        "Czech": .czech,
        "Danish": .danish,
        "Dutch": .dutch,
        "English": .english,
        "Estonian": .estonian,
        "Finnish": .finnish,
        "French": .french,
        "Galician": .galician,
        "Georgian": .georgian,
        "German": .german,
        "Greek": .greek,
        "Gujarati": .gujarati,
        "Haitian": .haitianCreole,
        "Hebrew": .hebrew,
        "Hindi": .hindi,
        "Hungarian": .hungarian,
        "Icelandic": .icelandic,
        "Indonesian": .indonesian,
        "Irish": .irish,
        "Italian": .italian,
        "Japanese": .japanese,
        "Kannada": .kannada,
        "Korean": .korean,
        "Latvian": .latvian,
        "Lithuanian": .lithuanian,
        "Macedonian": .macedonian,
        "Malay": .malay,
        "Maltese": .maltese,
        "Marathi": .marathi,
        "Norwegian": .norwegian,
        "Persian": .persian,
        "Polish": .polish,
        "Portuguese": .portuguese,
        "Romanian": .romanian,
        "Russian": .russian,
        "Slovak": .slovak,
        "Slovenian": .slovenian,
        "Spanish": .spanish,
        "Swahili": .swahili,
        "Swedish": .swedish,
        "Tagalog": .tagalog,
        "Tamil": .tamil,
        "Telugu": .telugu,
        "Thai": .thai,
        "Turkish": .turkish,
        "Ukrainian": .ukrainian,
        "Urdu": .urdu,
        "Vietnamese": .vietnamese,
        "Welsh": .welsh,
    ]
    
    lazy var swiftEmojiKeyboard: SwiftEmojiKeyboard = {
        let swiftEmojiKeyboard = SwiftEmojiKeyboard(frame: CGRect(x: 0, y: 0, width: 375, height: 300))
        swiftEmojiKeyboard.delegate = self
        // print("Swift Emoji Keyboard size: \(swiftEmojiKeyboard.frame.size)")
        return swiftEmojiKeyboard
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRewardedAd()
        LanguagePickerSetup()
        firstTextView.text = shareText
        firstTextView.delegate = self
        //  check()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        defaults()
    }
    
    // MARK: FUNCTION
    func check(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
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
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            //               let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: size, right: 0)
            print("ks=\(keyboardSize.height)")
            if size == 0.0 {
                size = keyboardSize.height /*+ 250*/
                
            }
            print("k=\(size)")
            // textSizeView.isHidden = true
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            // textViewHeight.constant -= size - 15
            //same size
            // textViewHeight.constant -=  keyboardSize.height
            //               textView.contentInset = contentInsets
            //               textView.scrollIndicatorInsets = contentInsets
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        //  textViewHeight.constant += size
        //           let contentInsets = UIEdgeInsets.zero
        //           textView.contentInset = contentInsets
        //           textView.scrollIndicatorInsets = contentInsets
    }
    override func dismissKeyboard() {
        view.endEditing(true)
    }
    func defaults(){
        firstTextView.layer.cornerRadius = 12
        firstTextView.layer.masksToBounds = true
        firstTextView.layer.borderColor = UIColor(hexFromString: "ABB5BE").cgColor
        firstTextView.layer.borderWidth = 1
        secondTextView.layer.cornerRadius = 12
        secondTextView.layer.masksToBounds = true
        secondTextView.layer.borderColor = UIColor(hexFromString: "ABB5BE").cgColor
        secondTextView.layer.borderWidth = 1
    }
    private func LanguagePickerSetup() {
        picker.delegate = self
        picker.allowsEditing = true
        languageTextField.optionArray = Array(languageMap.keys)
        languageTextField.didSelect{(selectedText , index ,id) in
            self.languageTextField.text = "Selected String: \(selectedText) \n index: \(index)"
        }
    }
    // MARK: KEYBOARD DELEGATE
    func keyWasTapped(text character: String) {
        if String(character) != nil{
            firstTextView.insertText(character)
        }
    }
    func numberButton(button: UIButton) {
        firstTextView.inputView = button
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
        firstTextView.inputView = button
        
    }
    @objc func showEmojiKeyboard() {
        // textViewHeight.constant = 465
        firstTextView.inputView = swiftEmojiKeyboard
        firstTextView.reloadInputViews() // Reload input views to update the keyboard
        firstTextView.becomeFirstResponder() // Show the keyboard
    }
    
    func emoji(button : UIButton) {
        firstTextView.inputView = button
        showEmojiKeyboard()
    }
    func openalert(){
        //        textViewHeight.constant = 465
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure you wish to delete text?", preferredStyle: .alert)
        let no = UIAlertAction(title: "No", style: .cancel)
        alert.addAction(no)
        let Yes = UIAlertAction(title: "Yes", style: .default){ action in
            self.firstTextView.text = ""
        }
        alert.addAction(Yes)
        present(alert, animated: true)
    }
    func textOpenAlert(){
        let alert = UIAlertController(title: "Share text", message: "Select the type of text that you want to share", preferredStyle: .alert)
        let plain = UIAlertAction(title: "Plain Text", style: .default) { action in
            let objectsToShare = [self.secondTextView.text!] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            self.present(activityVC, animated: true, completion: nil)
            // }
        }
        alert.addAction(plain)
        let edit = UIAlertAction(title: "Edited Text", style: .default) { action in
            let objectsToShare = [self.secondTextView.text!] as [Any]
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
    @IBAction func backButtonTappes(_ sender: Any) {
        view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func segmentAction(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            let keyboardView = CustomKeyboardFile(frame: CGRect(x: 0, y: 0, width: 375, height: 300))
            keyboardView.delegate = self
            firstTextView.inputView = keyboardView
            firstTextView.reloadInputViews()
            self.firstTextView.textAlignment = .right
        case 1:
            self.firstTextView.textAlignment = .left
            firstTextView.inputView = nil
            firstTextView.reloadInputViews()
            //textViewHeight.constant = 465
        default:
            break
        }
        
    }
    
    @IBAction func translateBTN(_ sender: Any) {
        // if UserDefaults.standard.bool(forKey: subscription) == true{
        view.endEditing(true)
        
        guard let targetLanguageName = languageTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).capitalized,
              let targetLanguage = languageMap[targetLanguageName] else {
            print("Invalid target language.")
            return
        }
        
        showProgress("")
        setupTranslator(targetLanguage: targetLanguage) { [weak self] error in
            guard let self = self else { return }
            dismissProgress()
            
            guard error == nil else {
                print("Error downloading model: \(String(describing: error))")
                self.secondTextView.text = "Error downloading model."
                return
            }
            
            guard let arabicTranslator = self.arabicTranslator, let englishTranslator = self.englishTranslator else {
                print("Translators are not initialized.")
                self.secondTextView.text = "Translators not initialized."
                return
            }
            
            // Example text to translate
            let textToTranslate = self.firstTextView.text ?? ""
            
            let isArabicText = self.isArabic(text: textToTranslate)
            let translator = isArabicText ? arabicTranslator : englishTranslator
            
            translator.translate(textToTranslate) { translatedText, error in
                guard error == nil, let translatedText = translatedText else {
                    print("Error during translation: \(String(describing: error))")
                    self.secondTextView.text = "Error during translation."
                    return
                }
                
                // Translation succeeded.
                self.secondTextView.text = translatedText
                print("Translated text: \(translatedText)")
            }
        }
        // translateData()
        //        }else{
        self.numCalls += 1
        if self.numCalls % 1 == 0 {
            if let rewardedAd = self.rewardedAd {
                print("Presenting rewarded ad...")
                rewardedAd.present(fromRootViewController: self) { [weak self] in
                    DispatchQueue.main.async {
                        self?.dismiss(animated: true)
                        // view.endEditing(true)
                        
                        guard let targetLanguageName = self?.languageTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).capitalized,
                              let targetLanguage = self?.languageMap[targetLanguageName] else {
                            print("Invalid target language.")
                            return
                        }
                        
                        showProgress("")
                        self?.setupTranslator(targetLanguage: targetLanguage) { [weak self] error in
                            guard let self = self else { return }
                            dismissProgress()
                            
                            guard error == nil else {
                                print("Error downloading model: \(String(describing: error))")
                                self.secondTextView.text = "Error downloading model."
                                return
                            }
                            
                            guard let arabicTranslator = self.arabicTranslator, let englishTranslator = self.englishTranslator else {
                                print("Translators are not initialized.")
                                self.secondTextView.text = "Translators not initialized."
                                return
                            }
                            
                            // Example text to translate
                            let textToTranslate = self.firstTextView.text ?? ""
                            
                            let isArabicText = self.isArabic(text: textToTranslate)
                            let translator = isArabicText ? arabicTranslator : englishTranslator
                            
                            translator.translate(textToTranslate) { translatedText, error in
                                guard error == nil, let translatedText = translatedText else {
                                    print("Error during translation: \(String(describing: error))")
                                    self.secondTextView.text = "Error during translation."
                                    return
                                }
                                
                                // Translation succeeded.
                                self.secondTextView.text = translatedText
                                print("Translated text: \(translatedText)")
                            }
                        }
                        print("Finished ad presentation.")
                    }
                }
            } else {
                print("Ad wasn't ready")
            }
            
        }
        //        }
        
    }
    
    @IBAction func copyBTNTapped(_ sender: Any) {
        view.endEditing(true)
        UIPasteboard.general.string = firstTextView.text ?? ""
        self.view.makeToast("Copied Successfully!")
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
    
    
    @IBAction func deleteBTN(_ sender: Any) {
        if firstTextView.text.isEmpty{
            
        }else{
            view.endEditing(true)
            openalert()
        }
    }
    
    @IBAction func shareBTN(_ sender: Any) {
        view.endEditing(true)
        let objectsToShare = [self.secondTextView.text!] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func copyButtonTapped(_ sender: Any) {
        view.endEditing(true)
        UIPasteboard.general.string = secondTextView.text ?? ""
        self.view.makeToast("Copied Successfully!")
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
}

// MARK: EMOJI EXTENSION
extension TranslateScreen: SwiftEmojiKeyboardDelegate {
    
    func swiftEmojiKeyboard(didSelect emoji: String, didSelectItemAt indexPath: IndexPath) {
        //        guard let text = customTextView.text else {return}
        //        customTextView.text = text + "\(emoji)"
        firstTextView.text += emoji
        //  textViewDidChange(customTextView)
    }
    
    
    func swiftEmojiKeyboard(didChangeCategoryAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func swiftEmojiKeyboard(didChangeKeyboard type: KeyboardType) {
        // swiftEmojiKeyboard.isHidden =  true
        // textViewHeight.constant = 465
        let keyboardView = CustomKeyboardFile(frame: CGRect(x: 0, y: 0, width: 375, height: 300))
        keyboardView.delegate = self
        firstTextView.inputView = keyboardView
        firstTextView.reloadInputViews()
        firstTextView.becomeFirstResponder()
    }
    
    func swiftEmojiKeyboard(didSelectReturn newLine: Bool) {
        (textDocumentProxy as UIKeyInput).insertText("\n")
    }
    
    func swiftEmojiKeyboard(didSelectDelete delete: Bool) {
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }
    
}
// MARK: TEXTVIEW DELEGATE
extension TranslateScreen: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if segmentOT.selectedSegmentIndex == 0 {
            let keyboardView = CustomKeyboardFile(frame: CGRect(x: 0, y: 0, width: 375, height: 300))
            keyboardView.delegate = self
            firstTextView.inputView = keyboardView
            firstTextView.reloadInputViews()
        } else {
            firstTextView.inputView = nil
            firstTextView.reloadInputViews()
            //textViewHeight.constant = 465
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
}
// MARK: TEXT TRANSLATOR EXTENSION

extension TranslateScreen{
    func preloadTranslatorModels() {
        let conditions = ModelDownloadConditions(
            allowsCellularAccess: true,
            allowsBackgroundDownloading: true
        )
        
        let group = DispatchGroup()
        var downloadError: Error?
        
        for (languageName, language) in languageMap {
            let arabicOptions = TranslatorOptions(sourceLanguage: .arabic, targetLanguage: language)
            let englishOptions = TranslatorOptions(sourceLanguage: .english, targetLanguage: language)
            
            let arabicTranslator = Translator.translator(options: arabicOptions)
            let englishTranslator = Translator.translator(options: englishOptions)
            
            group.enter()
            arabicTranslator.downloadModelIfNeeded(with: conditions) { error in
                if let error = error {
                    downloadError = error
                } else {
                    UserDefaults.standard.set(true, forKey: "arabic_\(languageName)_downloaded")
                }
                group.leave()
            }
            
            group.enter()
            englishTranslator.downloadModelIfNeeded(with: conditions) { error in
                if let error = error {
                    downloadError = error
                } else {
                    UserDefaults.standard.set(true, forKey: "english_\(languageName)_downloaded")
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            if let error = downloadError {
                print("Error downloading model: \(String(describing: error))")
            } else {
                print("All models preloaded successfully.")
            }
        }
    }
    
    
    func setupTranslator(targetLanguage: TranslateLanguage, completion: @escaping (Error?) -> Void) {
        let arabicOptions = TranslatorOptions(sourceLanguage: .arabic, targetLanguage: targetLanguage)
        let englishOptions = TranslatorOptions(sourceLanguage: .english, targetLanguage: targetLanguage)
        
        arabicTranslator = Translator.translator(options: arabicOptions)
        englishTranslator = Translator.translator(options: englishOptions)
        
        let conditions = ModelDownloadConditions(
            allowsCellularAccess: true,
            allowsBackgroundDownloading: true
        )
        
        let group = DispatchGroup()
        var downloadError: Error?
        
        let targetLanguageName = languageMap.first { $0.value == targetLanguage }?.key ?? ""
        let arabicKey = "arabic_\(targetLanguageName)_downloaded"
        let englishKey = "english_\(targetLanguageName)_downloaded"
        
        if !UserDefaults.standard.bool(forKey: arabicKey) {
            group.enter()
            arabicTranslator?.downloadModelIfNeeded(with: conditions) { error in
                if let error = error {
                    downloadError = error
                } else {
                    UserDefaults.standard.set(true, forKey: arabicKey)
                }
                group.leave()
            }
        }
        
        if !UserDefaults.standard.bool(forKey: englishKey) {
            group.enter()
            englishTranslator?.downloadModelIfNeeded(with: conditions) { error in
                if let error = error {
                    downloadError = error
                } else {
                    UserDefaults.standard.set(true, forKey: englishKey)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .global(qos: .userInitiated)) {
            DispatchQueue.main.async {
                completion(downloadError)
            }
        }
    }
    
    
    func translateData(){
        guard let targetLanguageName = languageTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).capitalized,
              let targetLanguage = languageMap[targetLanguageName] else {
            print("Invalid target language.")
            return
        }
        
        showProgress("")
        setupTranslator(targetLanguage: targetLanguage) { [weak self] error in
            guard let self = self else { return }
            dismissProgress()
            
            guard error == nil else {
                print("Error downloading model: \(String(describing: error))")
                self.secondTextView.text = "Error downloading model."
                return
            }
            
            guard let arabicTranslator = self.arabicTranslator, let englishTranslator = self.englishTranslator else {
                print("Translators are not initialized.")
                self.secondTextView.text = "Translators not initialized."
                return
            }
            
            // Example text to translate
            let textToTranslate = self.firstTextView.text ?? ""
            
            let isArabicText = self.isArabic(text: textToTranslate)
            let translator = isArabicText ? arabicTranslator : englishTranslator
            
            translator.translate(textToTranslate) { translatedText, error in
                guard error == nil, let translatedText = translatedText else {
                    print("Error during translation: \(String(describing: error))")
                    self.secondTextView.text = "Error during translation."
                    return
                }
                
                // Translation succeeded.
                self.secondTextView.text = translatedText
                print("Translated text: \(translatedText)")
            }
        }
        
    }
    func isArabic(text: String) -> Bool {
        // Simple heuristic to check if text is in Arabic
        for character in text {
            if character.unicodeScalars.first?.value ?? 0 >= 0x0600 && character.unicodeScalars.first?.value ?? 0 <= 0x06FF {
                return true
            }
        }
        return false
    }
    
}

extension TranslateScreen:GADFullScreenContentDelegate{
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        // Reload the ad after it's dismissed.
        loadRewardedAd()
        // translateData()
    }
}
