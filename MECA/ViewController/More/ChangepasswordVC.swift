//
//  ChangepasswordVC.swift
//  MECA
//
//  Created by Macbook  on 11/05/21.
//

import UIKit

class ChangepasswordVC: UIViewController {
    
    @IBOutlet weak var currentpwdtxt:UITextField!
    @IBOutlet weak var newpwdtxt:UITextField!
    @IBOutlet weak var reenternewpwdtxt:UITextField!
    @IBOutlet weak var btncurrentpwd:UIButton!
    @IBOutlet weak var btnnewpwd:UIButton!
    @IBOutlet weak var btnreenternewpwd:UIButton!
    var currenticonClick = true
    var newiconClick = true
    var reenternewiconClick = true
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func onClickShowcurrentPassword(_ sender: UIButton) {
        if(currenticonClick == true) {
                   currentpwdtxt.isSecureTextEntry = false
                } else {
                    currentpwdtxt.isSecureTextEntry = true
                }

        currenticonClick = !currenticonClick
    }
    
    
    
    func callchangepasswordWebservice(currentpassword:String,newpassword:String,reenterpassword:String) {
        GlobalObj.displayLoader(true, show: true)
        let param = ["currentpassword":currentpassword,
                     "newpassword":newpassword,"confirmpassword":reenterpassword]
        
        APIClient.webServicesTochangepassword(params: param) { (response) in
            print("login response\( response.resp_code!)")
            if let respCode = response.resp_code{
                
                GlobalObj.displayLoader(true, show: false)
                if respCode == 200{
            print("login response\(String(describing: response.message))")
                    var temp1 : String!
                    temp1 = response.message
            let alertController = UIAlertController(title: "Message", message: temp1, preferredStyle:UIAlertController.Style.alert)

            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
               { action -> Void in
                 // Put your code here
                self.navigationController?.popViewController(animated: true)
               })
            self.present(alertController, animated: true, completion: nil)
                    
                }
            }
           // GlobalObj.showAlertVC(title: "Message", message: , controller: self)

//            }
        }
    }
    @IBAction func onClickShownewPassword(_ sender: UIButton) {
        if(newiconClick == true) {
            newpwdtxt.isSecureTextEntry = false
                } else {
                    newpwdtxt.isSecureTextEntry = true
                }

        newiconClick = !newiconClick
    }
    @IBAction func onClickShowreenternewPassword(_ sender: UIButton) {
        if(reenternewiconClick == true) {
            reenternewpwdtxt.isSecureTextEntry = false
                } else {
                    reenternewpwdtxt.isSecureTextEntry = true
                }

        reenternewiconClick = !reenternewiconClick
    }
    @IBAction func btnBackAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnupdateAction(_ sender: UIButton) {
        if let type = currentpwdtxt.text, let name = newpwdtxt.text, let address = reenternewpwdtxt.text, type.isEmpty || name.isEmpty || address.isEmpty {
                print("Mandatory fields are: ")
            GlobalObj.showAlertVC(title: "Error", message: "Mandatory fields are: current password, New password,Re-enterNew password.", controller: self)
                
                return
        }else{
            callchangepasswordWebservice(currentpassword: currentpwdtxt.text!, newpassword: newpwdtxt.text!, reenterpassword: reenternewpwdtxt.text!)
        }
        
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
