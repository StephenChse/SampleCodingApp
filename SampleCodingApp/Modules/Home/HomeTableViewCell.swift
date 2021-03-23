//
//  HomeTableViewCell.swift
//  SampleCodingApp
//
//  Created by Stephen on 23/03/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var comment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setItemData(item:(name:String, email:String, comment:String)) {
        name.text = item.name
        email.text = item.email
        comment.text = item.comment
    }

}
