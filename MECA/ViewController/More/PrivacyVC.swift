//
//  PrivacyVC.swift
//  MECA
//
//  Created by Macbook  on 24/05/21.
//

import UIKit
import WebKit
class PrivacyVC: UIViewController,WKUIDelegate {
    @IBOutlet weak var webview2: WKWebView!
        var videoId: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://numerique360.com/privacy-policy/")
        webview2.load(URLRequest(url: url!))
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
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
