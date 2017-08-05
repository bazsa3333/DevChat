//
//  UserCell.swift
//  DevChat
//
//  Created by Bálint Németh on 2017. 08. 04..
//  Copyright © 2017. Németh Bálint. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var firstNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setCheckmark(selected: false)
    }
    
    func updateUI(user: User) {
        
        firstNameLbl.text = user.firstName
    }
    
    func setCheckmark(selected: Bool) {
        
        let imgStr = selected ? "messageindicatorchecked1" : "messageindicator1"
        self.accessoryView = UIImageView(image: UIImage(named: imgStr))
    }

}
