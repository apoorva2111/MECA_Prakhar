

import UIKit
import Photos
import BSImagePicker

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
    
  
    var myImageArr = [UIImage]()
    var SelectedAssests = [PHAsset]()
    var ImageArray = [UIImage]()
    var arrSelectedTag = [String]()
    var arrSubCategory = [String]()
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var viewModel : AddNewsVM!
    var index = -1
    var pickerIndex = 0
    var subCatpickerIndex = 0
    let categoryPicker = UIPickerView()
    let subCategoryPicker = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AddNewsVM.init(controller: self)
        self.photoCollectionView.register(UINib(nibName: "AddImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddImageCollectionViewCell")
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        viewModel.callWebserviceNewsCategory()
        setupUI()
        setupCollectionView()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCollectionView()
    }
    
    func setupUI(){
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
        self.presentPhotoPicker()
       
    }
    
    
    @IBAction func onClickAddFile(_ sender: UIButton) {
    }
    
    @IBAction func onClickAddData(_ sender: UIButton) {
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
}
//MARK: UICollectionview Delegate
extension AddNewsViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
            return ImageArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            viewModel.getItemForRowAt(indexPath, collectionView: photoCollectionView)

      
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

    func presentPhotoPicker() {
        
        let imagePicker = ImagePickerController()

        presentImagePicker(imagePicker, select: { (asset:PHAsset)  -> Void in
            // User selected an asset. Do something with it. Perhaps begin processing/upload?
              
        }, deselect: { (asset) in
            // User deselected an asset. Cancel whatever you did when asset was selected.
        }, cancel: { (assets) in
            // User canceled selection.
        }, finish: { (assets) in
            for i in 0..<assets.count
                        {
                            self.SelectedAssests.append(assets[i])
                        
                        }
                        
                        self.convertAssetToImages()
            // User finished selection assets.
        })
    }
    
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
        if pickerView == subCategoryPicker{
            return arrSubCategory.count
        }else{
            return viewModel.arrNewsCat.count
        }
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == subCategoryPicker{
            return arrSubCategory[row]
        }else{
            return viewModel.arrNewsCat[row].category
        }
    }
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
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
   


