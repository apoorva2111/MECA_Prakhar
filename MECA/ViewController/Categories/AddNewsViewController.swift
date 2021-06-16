

import UIKit
import Photos
import BSImagePicker
import PDFKit
import MobileCoreServices

class AddNewsViewController: UIViewController {
    
    
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var dismissVCRefBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dismissVC2RefBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabelRef: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryLabelRef: UILabel!
    @IBOutlet weak var categoryInputTextfield: UITextField!
    @IBOutlet weak var newsContentLabelRef: UILabel!
    @IBOutlet weak var newsContentView: UIView!
    @IBOutlet weak var newsContentTextView: UITextView!
    @IBOutlet weak var tagsLabelRef: UILabel!
    @IBOutlet weak var coverImageLabel: UILabel!
    @IBOutlet weak var onClickPhotoRefBtn: UIButton!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var documentsRefLabel: UILabel!
    @IBOutlet weak var addFileBtnRef: UIButton!
    @IBOutlet weak var addRefBtn: UIButton!
   
    @IBOutlet weak var txtSubCategory: UITextField!
    @IBOutlet weak var viewSubCategory: UIView!
    @IBOutlet weak var photCollectionHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var tagviewHeighConstraint: NSLayoutConstraint!
    @IBOutlet weak var tagView: TagListView!
    @IBOutlet weak var txtPostedDate: UITextField!
    @IBOutlet weak var viewDocument: UIView!
    @IBOutlet weak var viewAddLink: UIView!
    @IBOutlet weak var txtVideoLink: UITextField!
    @IBOutlet weak var documentView1: RCustomView!
    @IBOutlet weak var documentview2: RCustomView!
    @IBOutlet weak var lblTitleDoc1: UILabel!
    @IBOutlet weak var lblInfoDoc1: UILabel!
    @IBOutlet weak var imgDoc1: UIImageView!
    @IBOutlet weak var lblTitleDoc2: UILabel!
    @IBOutlet weak var lblInfoDoc2: UILabel!
    @IBOutlet weak var imgDoc2: UIImageView!
    @IBOutlet weak var btnSeeMoreOutlet: UIButton!
   
    @IBOutlet weak var documentViewHeightConstraint1: NSLayoutConstraint!
    
    @IBOutlet weak var documentViewHeightConstraint2: NSLayoutConstraint!
    @IBOutlet weak var viewAddDocInfo: UIView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtInfo: UITextView!
    
    
    
    var myImageArr = [UIImage]()
    var SelectedAssests = [PHAsset]()
    var ImageArray = [UIImage]()
    var arrSelectedTag = [String]()
    var arrSubCategory = [String]()
    var arrCoverimage : [Data] = []
    var documentArray = [UIImage]()
    var arrDocData : [Data] = []
    var documentdata = NSData()
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var viewModel : AddNewsVM!
    var index = -1
    var pickerIndex = 0
    var subCatpickerIndex = 0
    let categoryPicker = UIPickerView()
    let subCategoryPicker = UIPickerView()
    let datePicker = UIDatePicker()
    var module = 0
    var newsHomeCreate = ""
    var arrFileName = [String]()
    var arrDocument = [[String:Any]]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AddNewsVM.init(controller: self)
        viewAddDocInfo.isHidden = true
        documentView1.isHidden = true
        documentview2.isHidden = true
        documentViewHeightConstraint1.constant = 0
        documentViewHeightConstraint2.constant = 0
        btnSeeMoreOutlet.isHidden = true

        self.photoCollectionView.register(UINib(nibName: "AddImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddImageCollectionViewCell")
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
    
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        viewModel.callWebserviceNewsCategory()
        setupUI()
        setupCollectionView()
        if newsHomeCreate == "News"{
            viewAddLink.isHidden = true
            viewDocument.isHidden = false
           // documentCollectionHeightConstraint.constant = 0
        }else if newsHomeCreate == "Video"{
            viewAddLink.isHidden = false
            viewDocument.isHidden = true
        }else{
            viewAddLink.isHidden = true
            viewDocument.isHidden = false
           // documentCollectionHeightConstraint.constant = 0
        }
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCollectionView()
    }
    
    func setupUI(){
        txtPostedDate.setInputViewDatePicker(target: self, selector: #selector(postedDateAction)) //1

        viewSubCategory.isHidden = true
        tagView.delegate = self
        tagView.minWidth = 57
        tagView.alignment = .center
        tagView.cornerRadius = 10
        tagView.backgroundColor = .white
        tagView.textFont = UIFont.init(name: "SFPro-Regular", size: 12)!

        titleTextField.layer.borderWidth = 1
        titleTextField.layer.borderColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        categoryInputTextfield.layer.borderWidth = 1
        categoryInputTextfield.layer.borderColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        txtPostedDate.layer.borderWidth = 1
        txtPostedDate.layer.borderColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        categoryInputTextfield.delegate = self
        txtSubCategory.delegate = self
        txtSubCategory.layer.borderWidth = 1
        txtSubCategory.layer.borderColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        onClickPhotoRefBtn.layer.borderWidth = 1
        onClickPhotoRefBtn.layer.borderColor = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
        addFileBtnRef.layer.borderWidth = 1
        addFileBtnRef.layer.borderColor = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
        addRefBtn.layer.borderWidth = 1
        addRefBtn.layer.borderColor = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
        txtVideoLink.layer.borderWidth = 1
        txtVideoLink.layer.borderColor = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
        txtVideoLink.layer.cornerRadius = 10

        titleTextField.layer.cornerRadius = 8
        categoryInputTextfield.layer.cornerRadius = 8
        txtSubCategory.layer.cornerRadius = 8

        newsContentView.layer.cornerRadius = 8
        newsContentTextView.layer.cornerRadius = 8
        addRefBtn.layer.cornerRadius = 16
        addFileBtnRef.layer.cornerRadius = 8
        onClickPhotoRefBtn.layer.cornerRadius = 8
        photoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
                layout.itemSize = CGSize(width: screenWidth/2, height: 70)
        
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 0
              //   layout.scrollDirection = .horizontal
               photoCollectionView!.collectionViewLayout = layout
        
       
        
    }
    
       @objc func postedDateAction() {
           if let datePicker = self.txtPostedDate.inputView as? UIDatePicker {
            if #available(iOS 13.4, *) {
                      datePicker.preferredDatePickerStyle = .wheels
                  } else {
                      // Fallback on earlier versions
                  }
               let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy-MM-dd"
               self.txtPostedDate.text = dateformatter.string(from: datePicker.date) //2-4
           }
           self.txtPostedDate.resignFirstResponder() // 2-5
       }
    func setupCollectionView() {
        if ImageArray.isEmpty {
         
            photCollectionHeightContraint.constant = 0
            photoCollectionView.reloadData()
            print("No image Data")
        }
        else if !ImageArray.isEmpty {
            
            photCollectionHeightContraint.constant = 70
            photoCollectionView.reloadData()
            print("image Data is there")
        }
    }
}
//MARK:UITextFeildDelegate
extension AddNewsViewController : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == categoryInputTextfield{
            txtSubCategory.text = ""
            arrSubCategory.removeAll()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == categoryInputTextfield{

                self.categoryPicker.selectRow(pickerIndex, inComponent: 0, animated: true)
                self.pickerView(categoryPicker, didSelectRow: pickerIndex, inComponent: 0)
      
          
        }else if textField == txtSubCategory{
            self.subCategoryPicker.selectRow(subCatpickerIndex, inComponent: 0, animated: true)
            self.pickerView(subCategoryPicker, didSelectRow: subCatpickerIndex, inComponent: 0)
        }
    }
}
//MARK:- UITagview Delegate
extension AddNewsViewController:TagListViewDelegate{
    // MARK: TagListViewDelegate
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
        tagView.isSelected = !tagView.isSelected
        if arrSelectedTag.contains(title){
            arrSelectedTag = arrSelectedTag.removing(title)
           
            
        }else{

            arrSelectedTag.append(title)
        }
        
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
           sender.removeTagView(tagView)
    }
}
//MARK: UIButton Action
extension AddNewsViewController{
    func validation() {
        if titleTextField.text == "" && categoryInputTextfield.text == "" && txtPostedDate.text == "" && newsContentTextView.text == ""{
            GlobalObj.showAlertVC(title: "Oops", message: "Please Enter All Feilds", controller: self)
        }else if titleTextField.text == ""{
            GlobalObj.showAlertVC(title: "Oops", message: "Please Enter News Title", controller: self)
        }else if categoryInputTextfield.text == ""{
            GlobalObj.showAlertVC(title: "Oops", message: "Please Select Category", controller: self)
        }else if txtPostedDate.text == ""{
            GlobalObj.showAlertVC(title: "Oops", message: "Please Select Posted Date", controller: self)
        }else if newsContentTextView.text == "" {
            GlobalObj.showAlertVC(title: "Oops", message: "Please Enter Content", controller: self)
        }else{
            if arrSelectedTag.count  == 0 {
                GlobalObj.showAlertVC(title: "Oops", message: "Please Select Tags", controller: self)

            }
            if arrSubCategory.count>0{
                if txtSubCategory.text == ""{
                    GlobalObj.showAlertVC(title: "Oops", message: "Please Select Sub Category", controller: self)

                }else{
                    viewModel.callWebserviceForAddModuleItem(module: String(module))
                }
            }else{
                //Api call
           viewModel.callWebserviceForAddModuleItem(module: String(module))
            }
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
    
    
    @IBAction func onClickAddPhoto(_ sender: UIButton) {
        if ImageArray.count == 0 {
            self.presentPhotoActionSheet()
        }
        else {
            let alert1 = UIAlertController(title: "Can't Add more!", message: "You cannot add more than one Cover Image", preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert1.addAction(dismiss)
            present(alert1, animated: true, completion: nil)
            
        }
       
    }
    
    
    @IBAction func onClickAddFile(_ sender: UIButton) {
        let importMenu = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
            importMenu.delegate = self
            importMenu.modalPresentationStyle = .formSheet
            self.present(importMenu, animated: true, completion: nil)
    }
    
    @IBAction func onClickAddData(_ sender: UIButton) {
        validation()
    }
    @IBAction func btnSeeMoreAction(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
            for i in 0..<viewModel.arrNewsTag.count {
                let obj = viewModel.arrNewsTag[i]
                
                if arrSelectedTag.contains(obj){
                   
                }else{
                    tagView.removeTag(obj)
                }

            }
            for i in 0..<viewModel.arrNewsTag.count {
                let obj = viewModel.arrNewsTag[i]
                
                if i > 10 {
                    return
                }else{

                    if arrSelectedTag.contains(obj){
                        print(obj)

                    }else{

                        tagView.addTag(obj)
                    }

                }
            }
        }else{
            sender.isSelected = true
            if arrSelectedTag.count == 0 {
                tagView.removeAllTags()
            }
            for i in 0..<viewModel.arrNewsTag.count {
                let obj = viewModel.arrNewsTag[i]
                if arrSelectedTag.contains(obj){
                    
                }else{
                   
                    tagView.addTag(obj)
                }
            }
        
        tagView.reloadInputViews()
        }
    }
    @IBAction func btnPopUpSelection(_ sender: UIButton) {
        if sender.tag == 10{
            viewAddDocInfo.isHidden = true
        }else{
          let dict : [String :Any] = ["filetype":"application",
                                      "file":viewModel.docurl,
                                      "info":txtInfo.text!,
                                      "name":txtTitle.text!]
            arrDocument.append(dict)
            
           // documentArray
            for i in 0..<arrDocument.count {
                let objDoc = arrDocument[i]
                let objDocImg  = documentArray[i]
                if i == 0{
                    imgDoc1.image = objDocImg
                    lblInfoDoc1.text = objDoc["info"] as? String
                    lblTitleDoc1.text = objDoc["name"] as? String
                    documentView1.isHidden = false
                    documentViewHeightConstraint1.constant = 100
                }
                if i == 1{
                    imgDoc2.image = objDocImg
                    lblInfoDoc2.text = objDoc["info"] as? String
                    lblTitleDoc2.text = objDoc["name"] as? String
                    documentview2.isHidden = false
                    documentViewHeightConstraint2.constant = 100
                }

            }
            if arrDocument.count > 2 {
                btnSeeMoreOutlet.isHidden = false
            }
            viewAddDocInfo.isHidden = true
        }
    }
    @IBAction func btnSeeMoreDocumentAction(_ sender: UIButton) {
        let VC = FlowController().instantiateViewController(identifier: "VideoLinkVC", storyBoard: "Home") as!  VideoLinkVC
        VC.videoLinkValue = "0"
        VC.docLinkArr1 = arrDocument
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: true, completion: nil)
    }
}
//MARK:- Document picker
extension AddNewsViewController : UIDocumentMenuDelegate,UIDocumentPickerDelegate{
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

                arrFileName.append(filename)
        do {
            let docData = try Data(contentsOf: myURL as URL)
            documentdata = docData as NSData
            arrDocData.append(docData)
            
            
            viewModel.callWebserviceForUploadDocument(module: String(module), documentData: docData as NSData, filename: filename)
        } catch {
            print("Unable to load data: \(error)")
        }
        
        drawPDFfromURL(url: myURL) { (img) in
            if img != nil{
            self.documentArray.append(img!)
            }
            if self.documentArray.count>0{
           //     self.setupDocumentCollectionView()
            }

//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
//                self.documentCollectionview.reloadData()
//            }
        }
    }
          


    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    func drawPDFfromURL(url: URL,completion: @escaping (UIImage?) -> Void) -> UIImage? {
        guard let document = CGPDFDocument(url as CFURL) else { return nil }
        guard let page = document.page(at: 1) else { return nil }
        
        let pageRect = page.getBoxRect(.cropBox)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            UIColor.white.set()
            //ctx.fill(pageRect)
            ctx.fill(CGRect.init(x: 0, y: 0, width: 70, height: 70))
            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
            
            ctx.cgContext.drawPDFPage(page)
            
        }
        completion(img)
        return img
    }
}
//MARK: UICollectionview Delegate
extension AddNewsViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
            return ImageArray.count
      
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

//            viewModel.getItemForRowAt(indexPath, collectionView: photoCollectionView)
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "AddImageCollectionViewCell", for: indexPath) as! AddImageCollectionViewCell
            cell.playBtnRef.isHidden = true
            cell.removeButton.removeTarget(self, action: #selector(self.removeCoverImage), for: .touchUpInside)
            cell.removeButton.addTarget(self, action: #selector(self.removeCoverImage), for: .touchUpInside)
            cell.removeButton.tag = indexPath.row
            cell.myImage.image = ImageArray[indexPath.row]
            return cell
      
           
      
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 70, height: 70)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
      }
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
          return 0
      }
 
    
    @objc func removeCoverImage(sender: UIButton){
        ImageArray.remove(at: sender.tag)
        photoCollectionView.reloadData()
        setupCollectionView()
    }
}
extension AddNewsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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

        self.present(actionSheet, animated: true)
    }

    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }

//    func presentPhotoPicker() {
//        let vc = UIImagePickerController()
//        vc.sourceType = .photoLibrary
//        vc.delegate = self
//        vc.allowsEditing = true
//        present(vc, animated: true)
//    }
    func presentPhotoPicker() {

        let imagePicker = ImagePickerController()

        presentImagePicker(imagePicker, select: { (asset:PHAsset)  -> Void in
            // User selected an asset. Do something with it. Perhaps begin processing/upload?

        }, deselect: { (asset) in
            // User deselected an asset. Cancel whatever you did when asset was selected.
        }, cancel: { (assets) in
            // User canceled selection.
        }, finish: { (assets) in
            if assets.count>1{
                let alert1 = UIAlertController(title: "Can't Add more!", message: "You cannot add more than one Cover Image", preferredStyle: .alert)
                let dismiss = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                alert1.addAction(dismiss)
                self.present(alert1, animated: true, completion: nil)
                
            }else{
                for i in 0..<assets.count
                            {
                                self.SelectedAssests.append(assets[i])

                            }

                            self.convertAssetToImages()
            }
          
            // User finished selection assets.
        })
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//            var selectedImageFromPicker: UIImage?
//            if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
//                selectedImageFromPicker = editedImage
//            } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//                selectedImageFromPicker = originalImage
//            }
//
//            if let selectedImage = selectedImageFromPicker {
//                myImageArr.append(selectedImage)
//                arrCoverimage.append(selectedImage.jpegData(compressionQuality: 0.5)!)
//
//            }
//        photoCollectionView.delegate = self
//        photoCollectionView.dataSource = self
//        setupCollectionView()
//
//       // DispatchQueue.main.async {
//            self.photoCollectionView.reloadData()
//       // }
//
//            dismiss(animated: true, completion: nil)
//        }
        
    
    func convertAssetToImages() -> Void {

        if SelectedAssests.count != 0{

            if ImageArray.count > 0 {
                ImageArray.removeAll()

            }
            for i in 0..<SelectedAssests.count{

                let manager = PHImageManager.default()
                let option = PHImageRequestOptions()
                var thumbnail = UIImage()
                option.isSynchronous = true


                manager.requestImage(for: SelectedAssests[i], targetSize: CGSize(width: screenWidth/2, height: 70), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                    thumbnail = result!

                })

             let data = thumbnail.jpegData(compressionQuality: 0.7)
                let newImage = UIImage(data: data!)
                self.arrCoverimage.append(data!)
                self.ImageArray.append(newImage! as UIImage)
            }

        }

        print("complete photo array \(self.ImageArray)")
        setupCollectionView()
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.reloadData()

    }
}

// MARK: UIPickerView Delegation

extension AddNewsViewController : UIPickerViewDelegate, UIPickerViewDataSource{

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if newsHomeCreate == "Video"{
            return viewModel.arrVideos.count
        }else{
            if pickerView == subCategoryPicker{
                return arrSubCategory.count
            }else{
                return viewModel.arrNewsCat.count
            }
        }
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if newsHomeCreate == "Video"{
            return viewModel.arrVideos[row]
        }else{
            if pickerView == subCategoryPicker{
                return arrSubCategory[row]
            }else{
                return viewModel.arrNewsCat[row].category
            }
        }
    }
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if newsHomeCreate == "Video"{
            pickerIndex = row
            categoryInputTextfield.text = viewModel.arrVideos[row]
        }else{
            if pickerView == subCategoryPicker{
            subCatpickerIndex = row
            txtSubCategory.text = arrSubCategory[row]

        }else{
            pickerIndex = row
            categoryInputTextfield.text = viewModel.arrNewsCat[row].category
            if let subCategory = viewModel.arrNewsCat[row].subcategories{
                if subCategory.count>0{
                    if arrSubCategory.count>0 {
                        arrSubCategory.removeAll()
                    }
                    arrSubCategory = subCategory
                    viewSubCategory.isHidden = false
                    txtSubCategory.inputView = subCategoryPicker
                    subCategoryPicker.delegate = self
                }else{
                    subCatpickerIndex = 0
                    txtSubCategory.text = ""
                    viewSubCategory.isHidden = true
                }
            }
        }
    }
    }
}
   


