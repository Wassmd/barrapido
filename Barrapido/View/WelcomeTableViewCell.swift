//
//  WelcomeTableViewCell.swift
//  Barrapido
//
//  Created by Mohammed Wasimuddin on 02/12/18.
//  Copyright © 2018 Wasim. All rights reserved.
//

import UIKit

class WelcomeTableViewCell: UITableViewCell {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        welcomeLabel.layer.borderColor = UIColor(red: 71/255, green: 59/255, blue: 141/255, alpha: 1).cgColor
        welcomeLabel.layer.borderWidth = 2.0
        welcomeLabel.layer.cornerRadius = 8
        welcomeLabel.text = NSLocalizedString("To download the menu and to place an order just scan a QR-code provided by the bar, cafe, or restaurant. \n\nTo scan the code click on the \'QR-code\' button in the lower righthand corner which activates the camera on your device for the purpose. \n\nOnce the menu has been loaded you can select items in it, and then review and send the order.\n\nTo dismiss this message as well as others shown in this screen, just swipe it to the right.", comment: "Nothing")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
