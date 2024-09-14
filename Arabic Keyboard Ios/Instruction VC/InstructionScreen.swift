//
//  InstructionScreen.swift
//  Arabic Keyboard Ios
//
//  Created by Viprak-Monil on 24/06/24.
//

import UIKit
import SideMenuSwift

class InstructionScreen: UIViewController {
    
    // MARK: VARIABLE
    let images = ["step 1","step 2","step 3","step 4","step 5","step 6","step 7","step 8"]
    var currentIndex = 0
    var size : CGFloat = 0.0
    
    // MARK: IBOUTLET
    @IBOutlet weak var continueOT: UIButton!
    @IBOutlet weak var cw: UICollectionView!
    @IBOutlet weak var pageControlOT: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControlOT.numberOfPages = images.count
        pageControlOT.currentPage = currentIndex
        updateImageView()
        if UserDefaults.standard.bool(forKey: "isOnboardingCompleted") {
            navigateToHomePage()
        } else {
            continueOT.isHidden = true
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        continueOT.layer.cornerRadius = 20
        continueOT.layer.masksToBounds = true
    }
    
    // MARK: FUNCTION
    func updateImageView() {
        pageControlOT.currentPage = currentIndex
    }
    func navigateToHomePage(){
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")
//        let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
//        let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SideMenuViewController")
//        let sideMenuController = SideMenuController(contentViewController: contentViewController, menuViewController: menuViewController)
//        SideMenuController.preferences.basic.menuWidth = 300
//        self.navigationController?.pushViewController(sideMenuController, animated: true)
        let n = storyboard?.instantiateViewController(withIdentifier: "SplashScreen") as! SplashScreen
        navigationController?.pushViewController(n, animated: true)
    }
    
    // MARK: ACTION
    @IBAction func backButtonTapped(_ sender: Any) {
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "isOnboardingCompleted")
        navigateToHomePage()
    }
    
    
}

// MARK: COLLECTION VIEW EXTENSION
extension InstructionScreen : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cw.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InstructionScreenCollectionViewCell
        cell.images.image = UIImage(named: images[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: view.frame.width, height: cw.frame.height)
        return size
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        currentIndex = Int(scrollView.contentOffset.x / pageWidth)
        pageControlOT.currentPage = currentIndex
        // Show the continue button if the user is on the last image
        if currentIndex == images.count - 1 {
            continueOT.isHidden = false
            pageControlOT.isHidden = true
        } else {
            continueOT.isHidden = true
            pageControlOT.isHidden = false
        }
    }
    
    
}
