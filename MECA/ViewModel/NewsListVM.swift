//
//  NewsListVM.swift
//  MECA
//
//  Created by Apoorva Gangrade on 29/05/21.
//

import UIKit

class NewsListVM: BaseCollectionViewVM{
    
    override init(controller: UIViewController?) {
        
        super.init(controller: controller)
      actualController = controller
        nibItem = "InstagramImageCVCell"
        identifierItem = "InstagramImageCVCell"
        
    }
    
    override func getItemForRowAt(_ indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "OverPicksCVCell", for: indexPath) as! OverPicksCVCell
    
        return cell
        
    }
    override func getNumbersOfItemsForSection(_ section:Int)->Int{
        return 5
    }
    
    func didSelectRowAt(_ indexPath: IndexPath, collectionView: UICollectionView) {

        
    }
    
    func getSizeForItem(_ collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, indexPath: IndexPath) -> CGSize {
      
        return CGSize(width: collectionView.frame.size.width, height: 180)
    }
    
}
