//
//  LikeOrCommentVC.swift
//  MECA
//
//  Created by Apoorva Gangrade on 12/05/21.
//

import UIKit

class LikeOrCommentVC: UIViewController {
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var viewSendComment: UIView!
    @IBOutlet weak var txtViewSendComment: UITextView!
   
    @IBOutlet weak var btnOutletSendComment: UIButton!
    
    @IBOutlet weak var viewSendCommentHeightConstraint: NSLayoutConstraint!
   
   
    @IBOutlet weak var lblHeader: UILabel!
    
    var viewModel : LikeOrCommentVM!
    var isFromLike = ""
    var imgDoc = NSData()
    var module = 0
    var item = 0
    var detailVC = NewDetailVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LikeOrCommentVM.init(controller: self)

        if isFromLike == "Like"{
            viewSendCommentHeightConstraint.constant = 0
            tblList.register(LikeDetailTVCell.nib(), forCellReuseIdentifier: "LikeDetailTVCell")
            lblHeader.text = "Like"
            viewModel.callWebserviceForLikeList(module: String(module), item: String(item))
            
        }else{
            lblHeader.text = "Comments"
            tblList.register(CommentDetailTVCell.nib(), forCellReuseIdentifier: "CommentDetailTVCell")
            viewSendCommentHeightConstraint.constant = 80
            txtViewSendComment.layer.cornerRadius = 20
            txtViewSendComment.layer.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
            txtViewSendComment.layer.masksToBounds = true
            viewModel.callWebserviceForCommentList(module: String(module), item: String(item))
        }
     
        if GlobalValue.tabCategory == "GR" {
            btnOutletSendComment.setImage(#imageLiteral(resourceName: "RED_comment"), for: .normal)
        }else if  GlobalValue.tabCategory == "Maas" || GlobalValue.tabCategory == "Hydrogen" || GlobalValue.tabCategory == "SDGS"{
            btnOutletSendComment.setImage(#imageLiteral(resourceName: "Blue_comment"), for: .normal)
        }else{
            btnOutletSendComment.setImage(#imageLiteral(resourceName: "orange_comment"), for: .normal)
        }
    }
    @IBAction func btnCrossAction(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.detailVC.viewDidLoad()
        }
    }
    @IBAction func btnSendCommentAction(_ sender: UIButton) {
        if txtViewSendComment.text == ""{
            self.showToast(message: "Please Enter Your Comment")
        }else{
            viewModel.callWebserviceForAddComment(module: String(module), item: String(item), parent: "0", isfile: "0", is_reply: "0", comment: txtViewSendComment.text!, imgData: imgDoc)

        }
    }
    @IBAction func btnDocumentAction(_ sender: UIButton) {
        presentPhotoActionSheet()
    }
}

extension LikeOrCommentVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumbersOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.getCellForRowAt(indexPath, tableView: tblList)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.getHeightForRowAt(indexPath, tableView: tblList)
    }
}

extension LikeOrCommentVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
    
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
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func presentCamera1() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
            var selectedImageFromPicker: UIImage?
            if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                selectedImageFromPicker = editedImage
            } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                selectedImageFromPicker = originalImage
            }
            
            if let selectedImage = selectedImageFromPicker {
                imgDoc = selectedImage.jpegData(compressionQuality: 0.5)! as NSData

            }
            
            dismiss(animated: true, completion: nil)
        viewModel.callWebserviceForAddComment(module: String(module), item: String(item), parent: "0", isfile: "1", is_reply: "0", comment: txtViewSendComment.text!, imgData: imgDoc)

    }
    
}
