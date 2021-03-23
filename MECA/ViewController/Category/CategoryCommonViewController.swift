//
//  CategoryCommonViewController.swift
//  MECA
//
//  Created by Mohammed Sulaiman on 20/03/21.
//

import UIKit

class CategoryCommonViewController: UIViewController {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var dismissVCRefBtn: UIButton!
    @IBOutlet weak var dismissVC2RefBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabelRef: UILabel!
    @IBOutlet weak var titleInputTextField: UITextField!
    @IBOutlet weak var startDateRef: UILabel!
    @IBOutlet weak var endDateLabelRef: UILabel!
    @IBOutlet weak var seperatorLabelRef: UILabel!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var typeLabelRef: UILabel!
    @IBOutlet weak var chooseTypeTextField: UITextField!
    @IBOutlet weak var descriptionLabelRef: UILabel!
    @IBOutlet weak var DescriptionView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var coverLabelRef: UILabel!
    @IBOutlet weak var addImageRefBtn: UIButton!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var imagesLabelRef: UILabel!
    @IBOutlet weak var addImagesVideosRefBtn: UIButton!
    @IBOutlet weak var documentsLabelRef: UILabel!
    @IBOutlet weak var addFileRefBtn: UIButton!
    @IBOutlet weak var externalLinkLabelRef: UILabel!
    @IBOutlet weak var externalLinkTextField: UITextField!
    @IBOutlet weak var videoLinkLabelRef: UILabel!
    @IBOutlet weak var VideoLinkTextField: UITextField!
    @IBOutlet weak var addRefBtn: UIButton!
    var myTitle = ""
    var myImageArr = [UIImage]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.photoCollectionView.register(UINib(nibName: "AddImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddImageCollectionViewCell")
        // Do any additional setup after loading the view.
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCollectionView()
    }
    func setupUI(){
        titleInputTextField.layer.borderWidth = 1
        titleInputTextField.layer.borderColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        titleInputTextField.layer.cornerRadius = 8
        startDateTextField.layer.borderWidth = 1
        startDateTextField.layer.borderColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        startDateTextField.layer.cornerRadius = 8
        endDateTextField.layer.borderWidth = 1
        endDateTextField.layer.borderColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        endDateTextField.layer.cornerRadius = 8
        chooseTypeTextField.layer.borderWidth = 1
        chooseTypeTextField.layer.borderColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        chooseTypeTextField.layer.cornerRadius = 8
        externalLinkTextField.layer.borderWidth = 1
        externalLinkTextField.layer.borderColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        externalLinkTextField.layer.cornerRadius = 8
        VideoLinkTextField.layer.borderWidth = 1
        VideoLinkTextField.layer.borderColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        VideoLinkTextField.layer.cornerRadius = 8
        DescriptionView.layer.cornerRadius = 8
        descriptionTextView.layer.cornerRadius = 8
        addImageRefBtn.layer.borderWidth = 1
        addImageRefBtn.layer.cornerRadius = 8
        addImageRefBtn.layer.borderColor  = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
        addImagesVideosRefBtn.layer.borderWidth = 1
        addImagesVideosRefBtn.layer.cornerRadius = 8
        addImagesVideosRefBtn.layer.borderColor  = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
        addFileRefBtn.layer.borderWidth = 1
        addFileRefBtn.layer.cornerRadius = 8
        addFileRefBtn.layer.borderColor  = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
        addRefBtn.layer.borderWidth = 1
        addRefBtn.layer.cornerRadius = 16
        addRefBtn.layer.borderColor  = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
        titleLabel.text = myTitle
    }
    func setupCollectionView() {
        if myImageArr.isEmpty {
            photoCollectionView.isHidden = true
            photoCollectionView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
        else {
            photoCollectionView.isHidden = false
            photoCollectionView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        }
    }
    
    @IBAction func onClickDismissVC(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onClickDismissVC2(_ sender: UIButton) {
        let mainVC = FlowController().instantiateViewController(identifier: "HomeNav", storyBoard: "Home")
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.window?.rootViewController = mainVC
        appDel.window?.makeKeyAndVisible()
    }
    
    @IBAction func onClickAddImage(_ sender: UIButton) {
        self.presentPhotoPicker()
    }
    
    @IBAction func onClickAddImageandVideo(_ sender: UIButton) {
    }
    
    
    
    @IBAction func onClickAddFile(_ sender: UIButton) {
    }
    
    @IBAction func onClickAdddData(_ sender: UIButton) {
    }
    
    
    
}
extension CategoryCommonViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myImageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
        let cell  = photoCollectionView.dequeueReusableCell(withReuseIdentifier: "AddImageCollectionViewCell", for: indexPath) as! AddImageCollectionViewCell
        cell.myImage.layer.masksToBounds = false
        cell.myImage.layer.cornerRadius = cell.myImage.frame.height/2
        cell.myImage.clipsToBounds = true
        cell.myImage.image = myImageArr[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 70, height: 70)
        
    }
    
    
}
extension CategoryCommonViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Add Image",
                                            message: "How would you like to select a picture?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo",
                                            style: .default,
                                            handler: { [weak self] _ in

                                                self?.presentCamera()

        }))
        actionSheet.addAction(UIAlertAction(title: "Choose Photo",
                                            style: .default,
                                            handler: { [weak self] _ in

                                                self?.presentPhotoPicker()

        }))

        present(actionSheet, animated: true)
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
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        myImageArr.append(selectedImage)
        
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}

