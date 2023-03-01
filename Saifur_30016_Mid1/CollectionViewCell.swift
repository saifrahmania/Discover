//
//  TestCVC.swift
//  Saifur_30016_Mid1
//
//  Created by BJIT on 12/1/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var underLine: UIView!
    @IBOutlet weak var category: UILabel!
    
    override func prepareForReuse() {
        self.underLine.backgroundColor = .black
    }
}
