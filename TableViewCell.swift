//
//  testTVC.swift
//  Saifur_30016_Mid1
//
//  Created by BJIT on 12/1/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var content: UILabel!
    
    @IBOutlet weak var source: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
   

}
