//
//  BookmarkTableRow.swift
//  Saifur_30016_Mid1
//
//  Created by BJIT on 13/1/23.
//

import UIKit

class BookmarkTableRow: UITableViewCell {

    @IBOutlet weak var bookmarkThumbnail: UIImageView!
    
    @IBOutlet weak var bookmarkTitle: UILabel!
    
    var thumbnailURL = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
