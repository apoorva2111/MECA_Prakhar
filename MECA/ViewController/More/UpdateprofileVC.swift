//
//  UpdateprofileVC.swift
//  MECA
//
//  Created by Macbook  on 11/05/21.
//

import UIKit
import SDWebImage
class UpdateprofileVC: UIViewController {
    @IBOutlet weak var fnametxt:UITextField!
    @IBOutlet weak var lnametxt:UITextField!
    @IBOutlet weak var emailtxt:UITextField!
    @IBOutlet weak var phonetxt:UITextField!
    @IBOutlet weak var editimg:UIImageView!
    
    var fnamevalue = ""
    var lnamevalue = ""
    var emailvalue = ""
    var phonevalue = ""
    var imagevalue = ""
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.editimg.layer.cornerRadius = 12
        self.editimg.clipsToBounds = true
        fnametxt.text! = fnamevalue
        lnametxt.text! = lnamevalue
        emailtxt.text! = emailvalue
        phonetxt.text! = phonevalue
        if imagevalue == "" {

        }else{
            
        self.editimg.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.editimg.sd_setImage(with: URL.init(string: imagevalue), completed: nil)
        }
        // Do any additional setup after loading the view.
    }
    func callchangeprofileeditWebservice(firstname:String,lastname:String,email:String,phone:String,image:UIImage) {
        GlobalObj.displayLoader(true, show: true)
        let param = ["first_name":firstname,
                     "last_name":lastname,"email":email,"phone":phone]
        let accessToken = userDef.string(forKey: UserDefaultKey.token)
        let header :[String: String] = ["Authorization": "Bearer \(accessToken ?? "")",
                                        "Content-Type": "application/json",
                                        "Accept": "application/json"]
        APIClient.webServicesTochangeprofileedit(params: param, header: header, image: self.editimg.image!) { (response) in
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
    @IBAction func btnEditimageAction(_ sender: UIButton) {
        presentPhotoActionSheet()
        
    }
    @IBAction func btnupdateAction(_ sender: UIButton) {
        
        if let type = emailtxt.text, type.isEmpty {
                
            GlobalObj.showAlertVC(title: "Error", message: "Mandatory fields are: Email.", controller: self)
                
                return
        }else{

        
        callchangeprofileeditWebservice(firstname: self.fnametxt.text!, lastname: self.lnametxt.text!, email: self.emailtxt.text!, phone: self.phonetxt.text!, image: self.editimg.image!)
            
        }
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
extension UpdateprofileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
    
    func presentPhotoActionSheet() {
        
        let alert = UIAlertController(title: "Add Cover Image", message: "How would you like to select a picture?", preferredStyle: .actionSheet)
        let cameraAlert = UIAlertAction(title: "Camera",
                                        style: .default,
                                        handler:{ [weak self] _ in
                                            self?.presentCamera()
                                           
                                            
                                            
                                        })
        let galleryAlert = UIAlertAction(title: "Gallery",
                                         style: .default,
                                         handler:{ [weak self] _ in
                                            
                                            self?.presentPhotoPicker()
                                         })
        let dismiss = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(dismiss)
        alert.addAction(cameraAlert)
        alert.addAction(galleryAlert)
        self.present(alert, animated: true)
        alert.view.superview?.isUserInteractionEnabled = true
        alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
        
    }
    @objc func dismissOnTapOutside(){
        self.dismiss(animated: true, completion: nil)
    }
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        editimg.image  = tempImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

