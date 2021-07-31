//
//  SitetableCell.swift
//  MECA
//
//  Created by Macbook  on 20/07/21.
//

import UIKit

class SitetableCell: UITableViewCell {
    @IBOutlet weak var collectionSites: UICollectionView!
    var arrSites = [Special_sites]()
    var viewController = UIViewController()
    var FromSpecialsites : SpecialsitesVC!
    @IBOutlet weak var btnGt:UIButton!
    @IBOutlet weak var btngran:UIButton!
    @IBOutlet weak var btnmena:UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        collectionSites.delegate = self
//        collectionSites.dataSource = self
//        collectionSites.register(UINib.init(nibName: "SpecialsiteLinkCell", bundle: nil), forCellWithReuseIdentifier: "SpecialsiteLinkCell")
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        _ = UICollectionView(frame: frame, collectionViewLayout: layout)
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCell(newsObject:SpecialsiteData)  {
        if arrSites.count>0 {
            arrSites.removeAll()
        }
        if let picks =  newsObject.special_sites{
            arrSites = picks
        }
        if arrSites.count>0{
           



            FromSpecialsites.tblActivity.beginUpdates()
            FromSpecialsites.tblActivity.endUpdates()
        }
    }
    
}
//MARK:- UICollectionView Delegate Datasource

//extension SitetableCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("soecid?/// ...\(arrSites.count)")
//        return arrSites.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionSites.dequeueReusableCell(withReuseIdentifier: "SpecialsiteLinkCell", for: indexPath) as! SpecialsiteLinkCell
//        cell.setspecialsiteCell(objDict: arrSites[indexPath.row])
//        return cell
//
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        let obj = arrSites[indexPath.row]
////        let vc = FlowController().instantiateViewController(identifier: "NewsDetailVC", storyBoard: "NewsRC") as! NewsDetailVC
////        vc.newsID = String(obj.id ?? 0)
////        viewController.navigationController?.pushViewController(vc, animated: true)
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            return CGSize(width: 110 * 3, height: 160)
//        }
//
//}
