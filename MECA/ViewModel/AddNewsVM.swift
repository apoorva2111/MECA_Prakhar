//
//  AddNewsVM.swift
//  MECA
//


import UIKit
import Alamofire
class AddNewsVM: BaseCollectionViewVM {
    var arrNewsCat = [News_MEBITCat]()
    var arrNewsTag = [String]()
    var arrVideos = [String]()
    var videoLinkArr = [[String:Any]]()
var docurl = ""
    override init(controller: UIViewController?) {
        
        super.init(controller: controller)
      actualController = controller

    }
    
    override func getItemForRowAt(_ indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "AddImageCollectionViewCell", for: indexPath) as! AddImageCollectionViewCell
        cell.playBtnRef.isHidden = true
        cell.removeButton.removeTarget(self, action: #selector(self.removeCoverImage), for: .touchUpInside)
        cell.removeButton.addTarget(self, action: #selector(self.removeCoverImage), for: .touchUpInside)
        cell.removeButton.tag = indexPath.row
        cell.myImage.image = (actualController as! AddNewsViewController).ImageArray[indexPath.row]
        return cell
        
    }
    func didSelectRowAt(_ indexPath: IndexPath, collectionView: UICollectionView) {
        
    }
    
    func getSizeForItem(_ collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, indexPath: IndexPath) -> CGSize {
      
        return CGSize(width: collectionView.frame.size.width / 2, height: 145)
    }
    
    @objc func removeCoverImage(sender: UIButton){
        (actualController as! AddNewsViewController).ImageArray.remove(at: sender.tag)
        
        (actualController as! AddNewsViewController).photoCollectionView.reloadData()
        (actualController as! AddNewsViewController).setupCollectionView()
    }
    func callWebserviceNewsCategory() {
        GlobalObj.displayLoader(true, show: true)

        APIClient.webserviceForCategoryList { (result) in
            
            if let respCode = result.resp_code{
             
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)

                    if let arrData = result.data{
                        if self.arrNewsCat.count>0{
                            self.arrNewsCat.removeAll()
                        }
                        if arrData.news!.count>0{
                            self.arrNewsCat = arrData.news!
                            if (self.actualController as! AddNewsViewController).newsHomeCreate != "Video"{
                                
                            (self.actualController as! AddNewsViewController).categoryInputTextfield.inputView = (self.actualController as! AddNewsViewController).categoryPicker
                            (self.actualController as! AddNewsViewController).categoryPicker.delegate = (self.actualController as! AddNewsViewController).self
                            }
                        }
                        
                        if self.arrVideos.count>0{
                            self.arrVideos.removeAll()
                        }
                        if arrData.videos!.count>0{
                            
                            self.arrVideos = arrData.videos!
                         
                            (self.actualController as! AddNewsViewController).categoryInputTextfield.inputView = (self.actualController as! AddNewsViewController).categoryPicker
                            (self.actualController as! AddNewsViewController).categoryPicker.delegate = (self.actualController as! AddNewsViewController).self

                        }
                        
                        if self.arrNewsTag.count>0{
                            self.arrNewsTag.removeAll()
                        }
                        if arrData.tags!.count>0{
                            self.arrNewsTag = arrData.tags!
                            for i in 0..<arrData.tags!.count {
                                let obj = arrData.tags![i]
                                if i > 10 {
                                    return
                                }else{
                                    (self.actualController as! AddNewsViewController).tagView.addTag(obj)

                                }
                            }
                        }
                    }
                }else{
                    
                    GlobalObj.displayLoader(true, show: false)

                }
            }else{
               
                GlobalObj.displayLoader(true, show: false)

            }
            

        }
        
    }
    
    
    func callWebserviceForAddModuleItem(module:String){
        
        
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                  GlobalObj.showNetworkAlert()
                  return
        }
        GlobalObj.displayLoader(true, show: true)

        let url = BaseURL + AddModuleItem
       
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)

        headers = ["Authorization":"Bearer \(accessToken ?? "")"    ]

                   

        let parameters: [String: Any] = [
            "tags" : (actualController as! AddNewsViewController).arrSelectedTag,
            "event_documents" : (actualController as!AddNewsViewController).arrDocument
        ]
               AF.upload(multipartFormData: { (multipartFormData) in
        
            for (key, value) in parameters {

                if let jsonData = try? JSONSerialization.data(withJSONObject: value, options:[]) {
                    let data = (String(data: jsonData, encoding: String.Encoding.utf8) ?? "") as String
                  //  let replaceStr = data.replacingOccurrences(of: "\"", with: "")
                    let somedata = data.data(using: String.Encoding.utf8)
                    multipartFormData.append(somedata ?? Data(), withName: key as String)
                }
            }
                           
            multipartFormData.append((self.actualController as! AddNewsViewController).titleTextField.text!.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"title")

            multipartFormData.append((self.actualController as! AddNewsViewController).newsContentTextView.text!.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"description")
         
            multipartFormData.append((self.actualController as! AddNewsViewController).categoryInputTextfield.text!.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"category")
         
            multipartFormData.append((self.actualController as! AddNewsViewController).txtSubCategory.text!.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"subcategory")
            
            multipartFormData.append((self.actualController as! AddNewsViewController).txtPostedDate.text!.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"posted_date")

                multipartFormData.append((self.actualController as! AddNewsViewController).txtVideoLink.text!.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"video_link")

                
            multipartFormData.append(module.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"module")

            for img in (self.actualController as! AddNewsViewController).arrCoverimage{

                multipartFormData.append(img, withName: "newcover" , fileName: "file.jpeg", mimeType: "image/jpeg")

            }

        }, to: url, method: .post,headers:headers).responseJSON(completionHandler: { (response) in
            print(response.value as Any)
            GlobalObj.displayLoader(true, show: false)

            if let objData = response.value as? [String:Any]{
               
                let resp_code = objData["resp_code"] as! Int
                if resp_code == 200 {
                    if let msg = objData["message"] as? String{
                        (self.actualController as! AddNewsViewController).showToast(message: msg)

                    }

                    (self.actualController as! AddNewsViewController).navigationController?.popViewController(animated: true)
                }

            }else{
            print(response.error as Any)
                GlobalObj.displayLoader(true, show: false)

                (self.actualController as! AddNewsViewController).showToast(message: response.error.debugDescription)
            }
        })
print("error")
    }
    
    func callWebserviceForUploadDocument(module:String, documentData:NSData, filename:String){
        
        
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                  GlobalObj.showNetworkAlert()
                  return
        }
        GlobalObj.displayLoader(true, show: true)

        let url = BaseURL + newsDocumentUpload
       
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)

        headers = ["Authorization":"Bearer \(accessToken ?? "")"    ]

               AF.upload(multipartFormData: { (multipartFormData) in
        
                           
            multipartFormData.append(module.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"module")


                multipartFormData.append(documentData as Data, withName: "newdocument" , fileName: filename, mimeType: "application/pdf")

         

        }, to: url, method: .post,headers:headers).responseJSON(completionHandler: { (response) in
            print(response.value as Any)
            GlobalObj.displayLoader(true, show: false)
/*{
            data = "public/upload/newsroom/documents/dummy.pdf";
            "resp_code" = 200;
        }*/
            if let objData = response.value as? [String:Any]{
               
                let resp_code = objData["resp_code"] as! Int
                if resp_code == 200 {
                    if let docUrl = objData["data"] as? String{
                        self.docurl = docUrl
                        (self.actualController as! AddNewsViewController).txtInfo.text = ""
                        (self.actualController as! AddNewsViewController).txtTitle.text = ""
                        (self.actualController as! AddNewsViewController).viewAddDocInfo.isHidden = false
                    }

                }

            }else{
            print(response.error as Any)
                GlobalObj.displayLoader(true, show: false)

                (self.actualController as! AddNewsViewController).showToast(message: response.error.debugDescription)
            }
        })
print("error")
    }
}
