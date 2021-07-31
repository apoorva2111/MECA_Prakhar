//
//  MECAPostVM.swift
//  MECA
//
//  Created by Apoorva Gangrade on 19/06/21.
//

import UIKit
import Foundation
import Alamofire
import AVKit
import Photos
import BSImagePicker
import MobileCoreServices
import AVFoundation

class MECAPostVM: BaseCollectionViewVM {
  
    override init(controller: UIViewController?) {
        
        super.init(controller: controller)
      actualController = controller
    }
    override func getItemForRowAt(_ indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "AddImageCollectionViewCell", for: indexPath) as! AddImageCollectionViewCell
        cell.myImage.image =  (actualController as! MECAPostVC).arrFeedImage[indexPath.row]
        cell.myImage.layer.cornerRadius = cell.myImage.frame.height/2
        cell.playBtnRef.isHidden = true
        cell.removeButton.removeTarget(self, action: #selector(self.removeImages), for: .touchUpInside)
        cell.removeButton.addTarget(self, action: #selector(self.removeImages), for: .touchUpInside)

        return cell
        
    }
    func didSelectRowAt(_ indexPath: IndexPath, collectionView: UICollectionView) {
    }
   
    func getSizeForItem(_ collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
  
    @objc func removeImages(sender: UIButton)
    {
        print((actualController as! MECAPostVC).arrFeedImage)
        (actualController as! MECAPostVC).arrFeedImage.remove(at: sender.tag)
        (actualController as! MECAPostVC).arrImgData.remove(at: sender.tag)
        (actualController as! MECAPostVC).SelectedAssests.remove(at: sender.tag)
        (actualController as! MECAPostVC).setupCollectionView1()
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
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append((self.actualController as! MECAPostVC).txtViewContent.text!.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"description")
            
            multipartFormData.append((self.actualController as! MECAPostVC).selecteFeedType.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"type")
            
            multipartFormData.append((self.actualController as! MECAPostVC).txtVideoLink.text!.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"video_link")
            
            
            multipartFormData.append(module.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"module")
            //
            multipartFormData.append((self.actualController as! MECAPostVC).documentdata, withName: "document_link" , fileName: (self.actualController as! MECAPostVC).documentFileName, mimeType: "application/pdf")
            
            
            for i in 0..<(self.actualController as! MECAPostVC).arrImgData.count{
                let name = "feed_images[\(i)]"
                let img = (self.actualController as! MECAPostVC).arrImgData[i]
                multipartFormData.append(img, withName: name , fileName: "file.jpeg", mimeType: "image/jpeg")
                
            }
            
        }, to: url, method: .post,headers:headers).responseJSON(completionHandler: { (response) in
            print(response.value as Any)
            GlobalObj.displayLoader(true, show: false)
            
            if let objData = response.value as? [String:Any]{
                
                let resp_code = objData["resp_code"] as! Int
                if resp_code == 200 {
                    if let msg = objData["message"] as? String{
                        (self.actualController as! MECAPostVC).showToast(message: msg)
                    }
                    (self.actualController as! MECAPostVC).navigationController?.popViewController(animated: true)
                }
            }else{
                print(response.error as Any)
                GlobalObj.displayLoader(true, show: false)
                
                (self.actualController as! MECAPostVC).showToast(message: response.error.debugDescription)
            }
        })
        print("error")
    }
}


extension MECAPostVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPhotoPicker1() {
        
        let imagePicker = ImagePickerController()
        
        presentImagePicker(imagePicker, select: { (asset:PHAsset)  -> Void in
            // User selected an asset. Do something with it. Perhaps begin processing/upload?
            
        }, deselect: { (asset) in
            // User deselected an asset. Cancel whatever you did when asset was selected.
        }, cancel: { (assets) in
            // User canceled selection.
        }, finish: { (assets) in
            self.dismiss(animated: true, completion: nil)
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
            
            if arrFeedImage.count > 0 {
                arrFeedImage.removeAll()
                
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
//                arrImgData.append(data!)
                self.arrImgData.insert(data!, at: i)

                let newImage = UIImage(data: data!)

                
               // self.arrFeedImage.append(newImage! as UIImage)
                self.arrFeedImage.insert(newImage! as UIImage, at: i)
                setupCollectionView1()

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
                    self.collectionImgs.reloadData()
                }

            }
            
        }
        
        collectionImgs.delegate = self
        collectionImgs.dataSource = self
        collectionImgs.reloadData()

        DispatchQueue.main.async {
            self.collectionImgs.reloadData()
        }
        
    }
    
    func setupCollectionView1() {
        
        if arrFeedImage.isEmpty  {
            collectionviewHeightConstraint.constant = 0
            viewAddImgHeightConstraint.constant = 87
            collectionImgs.isHidden = true
            print("No multiple iamges")
            
        }
        else {
            collectionviewHeightConstraint.constant = 70
            viewAddImgHeightConstraint.constant = 157
            collectionImgs.isHidden = false
            print(" having multiple iamges")
        }

        DispatchQueue.main.async {
            self.collectionImgs.reloadData()

        }
        
    }
}
