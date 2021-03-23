//
//  LoginVC.swift
//  MECA
//
//  Created by Apoorva Gangrade on 19/03/21.
//

import UIKit

class LoginVC: UIViewController {

    var viewmodel : LoginVM!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewmodel = LoginVM.init(controller: self)
        // Do any additional setup after loading the view.
    }
    

}
//MARK:- UIButton Action

extension LoginVC{
    @IBAction func btnSignUPAction(_ sender: UIButton) {
        let vc = FlowController().instantiateViewController(identifier: "SignUpVC", storyBoard: "Main")

        self.navigationController?.pushViewController(vc, animated: true)

    }
    @IBAction func btnLogin(_ sender: UIButton) {
        let mainVC = FlowController().instantiateViewController(identifier: "HomeNav", storyBoard: "Home")
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.window?.rootViewController = mainVC
        appDel.window?.makeKeyAndVisible()

    }
}
