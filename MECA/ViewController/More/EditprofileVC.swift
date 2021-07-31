//
//  EditprofileVC.swift
//  MECA
//
//  Created by Macbook  on 11/05/21.
//

import UIKit
import SDWebImage
class EditprofileVC: UIViewController {
    @IBOutlet weak var namelbl:UILabel!
    @IBOutlet weak var emailidlbl:UILabel!
    @IBOutlet weak var phonelbl:UILabel!
    @IBOutlet weak var editimg:UIImageView!
    var logindatas :[LoginUserModel] = []
    var fnameeditvalue = ""
    var lnameeditvalue = ""
    var imageditvalue = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        self.editimg.layer.cornerRadius = 12
        self.editimg.clipsToBounds = true
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated )
        
        DispatchQueue.main.async {
            self.callwedservicegetprofiledata()
        }
    }
    
    
    func callwedservicegetprofiledata()
    {
        GlobalObj.displayLoader(true, show: true)
        
        APIClient.webserviceForgetprofile{ (result) in
            print("result\(result)")
            if let respCode = result.resp_code{
                
                GlobalObj.displayLoader(true, show: false)
                if respCode == 200{
                    if let arrDate = result.data{
                        guard  let fname = arrDate.first_name else {
                                            return
                                        }
                        self.fnameeditvalue = fname
                                        guard  let lname = arrDate.last_name else {
                                            return
                                        }
                        self.lnameeditvalue = lname
                        
                                        print("fname + lname\(fname + lname)")
                                        self.namelbl.text = fname + lname
                        
                                        guard  let phonenumber = arrDate.phone else {
                                            return
                                        }
                                        print("phonenumber\(phonenumber)")
                                        self.phonelbl.text = phonenumber
                                        guard  let email = arrDate.email else {
                                            return
                                        }
                                        print("email\(email)")
                                        self.emailidlbl.text = email
                                        guard  let profileimage = arrDate.avatar else {
                                            return
                                        }
                                        print("profileimage\(profileimage)")
                                        if profileimage == "" {
                        
                                        }else{
                                            let url = BaseURL + profileimage
                                            self.imageditvalue = url
                                            print("//.......\(url)")
                                            self.editimg.sd_imageIndicator = SDWebImageActivityIndicator.gray
                                            self.editimg.sd_setImage(with: URL.init(string: url), completed: nil)
                                        }
                    }
                    
                }
                

                
            }
            
            GlobalObj.displayLoader(true, show: false)

        }
    }
    @IBAction func btnBackAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnEditAction(_ sender: UIButton) {
        let story = UIStoryboard(name: "More", bundle:nil)
      //  let obj = arrList[indexPath.row]
        let vc = story.instantiateViewController(withIdentifier: "Updateprofilevc") as! UpdateprofileVC
        vc.emailvalue = emailidlbl.text!
        vc.phonevalue = phonelbl.text!
        vc.fnamevalue = fnameeditvalue
        vc.lnamevalue = lnameeditvalue
        vc.imagevalue = imageditvalue
      
        self.navigationController?.pushViewController(vc, animated: true)
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
