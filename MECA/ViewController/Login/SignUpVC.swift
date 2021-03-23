//
//  LoginVC.swift
//  MECA
//
//  Created by Apoorva Gangrade on 19/03/21.
//

import UIKit

class SignUpVC: UIViewController {

    var viewModel : SignUpVM!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SignUpVM.init(controller: self)

        // Do any additional setup after loading the view.
    }
    

}
//MARK :- UIButton Action

extension SignUpVC{
    
    @IBAction func btnDivisionAction(_ sender: UIButton) {
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "SignUpListViewVC") as! SignUpListViewVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
  
    @IBAction func btnSelectDistributorAction(_ sender: UIButton) {
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "SignUpListViewVC") as! SignUpListViewVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
   
    @IBAction func btnLoginAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func btnSignUpAction(_ sender: UIButton) {
       
        let mainVC = FlowController().instantiateViewController(identifier: "HomeNav", storyBoard: "Home")
          let appDel = UIApplication.shared.delegate as! AppDelegate
          appDel.window?.rootViewController = mainVC
          appDel.window?.makeKeyAndVisible()
    }
}
