//
//  SideMenuTableViewCell.swift
//  Arabic Keyboard Ios
//
//  Created by Viprak-Monil on 26/03/24.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var sideMenuImageView: UIImageView!
    
    @IBOutlet weak var sideMenuLBL: UILabel!
    
    @IBOutlet weak var menuBgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
