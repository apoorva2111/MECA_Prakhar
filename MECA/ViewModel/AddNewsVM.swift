//
//  AddNewsVM.swift
//  MECA
//


import UIKit

class AddNewsVM: BaseCollectionViewVM {
    var arrNewsCat = [News_MEBITCat]()
    var arrNewsTag = [String]()
    
    override init(controller: UIViewController?) {
        
        super.init(controller: controller)
      actualController = controller

    }
    
    override func getItemForRowAt(_ indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "AddImageCollectionViewCell", for: indexPath) as! AddImageCollectionViewCell
        cell.myImage.image = (actualController as! AddNewsViewController).ImageArray[indexPath.row]
        return cell
        
    }
    func didSelectRowAt(_ indexPath: IndexPath, collectionView: UICollectionView) {
        
    }
    
    func getSizeForItem(_ collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, indexPath: IndexPath) -> CGSize {
      
        return CGSize(width: collectionView.frame.size.width / 2, height: 145)
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
}
