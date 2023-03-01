//
//  WebpageView.swift
//  Saifur_30016_Mid1
//
//  Created by BJIT on 13/1/23.
//

import UIKit
import WebKit

class WebpageView: UIViewController {
    
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var showPage = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        
         let webView = WKWebView(frame: view.bounds)
                 view.addSubview(webView)
                 
        guard let url = URL(string: showPage ) else { return }
                 webView.load(URLRequest(url: url))
         
         
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
