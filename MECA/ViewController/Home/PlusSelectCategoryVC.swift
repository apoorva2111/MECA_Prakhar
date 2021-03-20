//
//  PlusSelectCategoryVC.swift
//  MECA
//
//  Created by Apoorva Gangrade on 19/03/21.
//

import UIKit

class PlusSelectCategoryVC: UIViewController {

    @IBOutlet weak var collectionSelectCategory: UICollectionView!
    var arrCat = ["News","MEBIT","MaaS","Hydrogen","SDGs","GR"]
    var arrcatImg = [UIImage.init(named: "News"),UIImage.init(named: "MEBIT"),UIImage.init(named: "MaaS"),UIImage.init(named: "Hydrogen"),UIImage.init(named: "SDGs"),UIImage.init(named: "GR")]
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionSelectCategory.register(UINib(nibName: "PlusSelectCategoryCVCell", bundle: nil), forCellWithReuseIdentifier: "PlusSelectCategoryCVCell")

    }

}

//MARK:- UIButton Action
extension PlusSelectCategoryVC {
    @IBAction func btnCrossAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
//MARK:- UICollectionView
extension PlusSelectCategoryVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCat.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionSelectCategory.dequeueReusableCell(withReuseIdentifier: "PlusSelectCategoryCVCell", for: indexPath) as! PlusSelectCategoryCVCell
        cell.imgCatIcon.image = arrcatImg[indexPath.row]
        cell.lblCatName.text = arrCat[indexPath.row]
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
      }
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
          return 0
      }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("Width: \(collectionSelectCategory.frame.size.width / 2)")
        return CGSize(width: collectionSelectCategory.frame.size.width / 2, height: 145)

    }
}
