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
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        let url = URL(string: "http://mecacampus.com/API/mobile/user/privacypolicy")
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
