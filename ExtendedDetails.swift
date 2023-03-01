//
//  ExtendedDetails.swift
//  Saifur_30016_Mid1
//
//  Created by BJIT on 13/1/23.
//

import UIKit
import SDWebImage
//JSON
class ExtendedDetails: UIViewController {
    
    @IBOutlet weak var newsCompany: UILabel!
    
    @IBOutlet weak var newsThumbnail: UIImageView!
    
    
    @IBOutlet weak var newsTitle: UILabel!
    
    @IBOutlet weak var newsAuthor: UILabel!
    
    @IBOutlet weak var newsDate: UILabel!
    
    @IBOutlet weak var newsDescription: UILabel!
    
    var storeURL = ""
    var storeImageURL = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(storeURL)
        print(storeImageURL)
        self.newsThumbnail.sd_setImage(with: URL(string: storeImageURL ) )
        
    }
    

  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.webkitSegue{
            if let webkitSegue = segue.destination as? WebpageView{
                webkitSegue.showPage = storeURL
            }
        }
    }
    
    @IBAction func readMore(_ sender: UIButton) {
        performSegue(withIdentifier: Constant.webkitSegue, sender: nil)
    }
    
    
}
