//
//  ThemeTableViewCell.swift
//  Arabic Keyboard Ios
//
//  Created by Viprak-Monil on 20/03/24.
//

import UIKit


class ThemeTableViewCell: UITableViewCell {

    @IBOutlet weak var buttonOt: UIButton!
    @IBOutlet weak var keyboardImage: UIImageView!
    @IBOutlet weak var adImage: UIImageView!
    @IBOutlet weak var spaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var applyLB: UILabel!
    @IBOutlet weak var leftConsttraint: NSLayoutConstraint!
    //var object : ((IndexPath) ->())?
    var buttonActionHandler: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonOt.layer.cornerRadius = 10
        buttonOt.layer.masksToBounds = true
        buttonOt.layer.borderWidth = 1
        buttonOt.layer.borderColor = UIColor.white.cgColor
      
//        buttonOt.setTitle("Button", for: .normal)
//        buttonOt.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        // Initialization code
    }
   

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


        

}
