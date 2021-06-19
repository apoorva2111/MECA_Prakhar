//
//  MECAPostVC.swift
//  MECA

import Foundation
import UIKit
import Alamofire
import AVKit
import Photos
import BSImagePicker
import MobileCoreServices
import AVFoundation

class MECAPostVC: UIViewController {
    

    @IBOutlet weak var btnFeedImgOutlet: RCustomButton!
  
    @IBOutlet weak var btnFeedVideoOutlet: RCustomButton!
  
    @IBOutlet weak var txtViewContent: UITextView!
  
    @IBOutlet weak var collectionImgs: UICollectionView!
    
    @IBOutlet weak var txtVideoLink: UITextField!
  
    @IBOutlet weak var btnDocumentOutlet: RCustomButton!
    
    @IBOutlet weak var viewAddImg: UIView!
    @IBOutlet weak var viewVideoLink: UIView!
    @IBOutlet weak var viewUploadDocument: UIView!
    @IBOutlet weak var collectionviewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewAddImgHeightConstraint: NSLayoutConstraint!
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var module = 0
    var viewModel : MECAPostVM!
    var documentdata = Data()
    var SelectedAssests = [PHAsset]()
    var arrFeedImage = [UIImage]()
    var arrImgData = [Data]()
    var selecteFeedType = ""
    var documentFileName = ""
    var feedId = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MECAPostVM.init(controller: self)
        // Do any additional setup after loading the view.
        collectionImgs.register(UINib.init(nibName: "AddImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddImageCollectionViewCell")
        
        collectionImgs.isHidden = true
        collectionviewHeightConstraint.constant = 0
        viewAddImgHeightConstraint.constant = 87
        viewVideoLink.isHidden = true
        txtViewContent.layer.cornerRadius = 8
        txtViewContent.layer.borderWidth = 1
        txtViewContent.layer.borderColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        txtViewContent.layer.masksToBounds = true
        selecteFeedType = "1"
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
       
        if feedId != ""{
        viewModel.callWebserviceForNewHomeFeedInfo()
        }
    }
}

//MARK :- UIButton Action

extension MECAPostVC {
    
    @IBAction func onClickDismiss(_ sender: UIButton) {
        if sender.tag == 10{
       
            self.navigationController?.popViewController(animated: true)
      
        }else{
            let mainVC = FlowController().instantiateViewController(identifier: "HomeNav", storyBoard: "Home")
            let appDel = UIApplication.shared.delegate as! AppDelegate
            appDel.window?.rootViewController = mainVC
            appDel.window?.makeKeyAndVisible()
        }
    }
    
    @IBAction func btnDocumentAction(_ sender: UIButton) {
        let importMenu = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
            importMenu.delegate = self
            importMenu.modalPresentationStyle = .formSheet
            self.present(importMenu, animated: true, completion: nil)
    }
    @IBAction func btnImagesAction(_ sender: UIButton) {
        presentPhotoPicker1()
    }
    @IBAction func btnAddFeedAction(_ sender: UIButton) {
        validation()
    }
    @IBAction func btnFeedImgAction(_ sender: UIButton) {
        viewAddImg.isHidden = false
        selecteFeedType = "1"
        btnFeedImgOutlet.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
        btnFeedImgOutlet.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btnFeedVideoOutlet.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
        btnFeedVideoOutlet.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)

        viewVideoLink.isHidden = true
        if arrFeedImage.count>0{
            collectionviewHeightConstraint.constant = 70
            viewAddImgHeightConstraint.constant = 157
        }else{
            collectionviewHeightConstraint.constant = 0
            viewAddImgHeightConstraint.constant = 87
        }
    }
    @IBAction func btnFeedVideoAction(_ sender: UIButton) {
        selecteFeedType = "2"
        viewAddImg.isHidden = true
        viewVideoLink.isHidden = false
        btnFeedVideoOutlet.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btnFeedImgOutlet.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)

        btnFeedVideoOutlet.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
        btnFeedImgOutlet.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
    }
    func validation() {
        if txtViewContent.text == "" {
            GlobalObj.showAlertVC(title: "Oops", message: "Please Enter Content", controller: self)
        }else{
            if selecteFeedType == "1" {
                if arrFeedImage.count == 0{
                    GlobalObj.showAlertVC(title: "Oops", message: "Please Select Atleast one image", controller: self)
                }else{
                    viewModel.callWebserviceForAddModuleItem(module: String(module))

                }
            }else if selecteFeedType == "2" {
                if txtVideoLink.text == "" {
                    GlobalObj.showAlertVC(title: "Oops", message: "Please Enter Video Link", controller: self)

                }else{
                    viewModel.callWebserviceForAddModuleItem(module: String(module))
                }
            }
        }
       
    }
}

//MARK:- UICollectionview Delegate / Datasource
extension MECAPostVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrFeedImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        viewModel.getItemForRowAt(indexPath, collectionView: collectionImgs)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel.getSizeForItem(collectionImgs, collectionViewLayout: collectionViewLayout, indexPath: indexPath)
    }
}
//MARK:- Document picker
extension MECAPostVC : UIDocumentMenuDelegate,UIDocumentPickerDelegate{
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)

    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
     print("import result : \(myURL)")
        let filename = myURL.lastPathComponent  // pdfURL is your file url

//                arrFileName.append(filename)
        documentFileName = filename
        btnDocumentOutlet.setTitle(filename, for: .normal)
        do {
            let docData = try Data(contentsOf: myURL as URL)
            documentdata = docData
        } catch {
            print("Unable to load data: \(error)")
        }
        
    }
          


    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
}
