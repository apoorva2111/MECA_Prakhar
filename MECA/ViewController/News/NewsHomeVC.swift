//
//  NewsHomeVC.swift
//  MECA
//
//  Created by Apoorva Gangrade on 28/05/21.
//

import UIKit

class NewsHomeVC: UIViewController {
    
    @IBOutlet weak var txtSearch: RCustomTextField!
    @IBOutlet weak var typeCollection: UICollectionView!
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var subTypeColltection: UICollectionView!
    @IBOutlet weak var viewSubCollection: UIView!
    var viewModel : NewsHomeVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSearch.isHidden = true
        viewSubCollection.isHidden = true
        viewModel = NewsHomeVM.init(controller: self)
        registernib()
        
    }
    func registernib() {
        tblList.delegate = self
        tblList.dataSource = self
        typeCollection.delegate = self
        typeCollection.dataSource = self
        subTypeColltection.delegate = self
        subTypeColltection.dataSource = self
        tblList.register(UINib.init(nibName: "NewsHomePickTVCell", bundle: nil), forCellReuseIdentifier: "NewsHomePickTVCell")
        tblList.register(UINib.init(nibName: "LatestNewsTVCell", bundle: nil), forCellReuseIdentifier: "LatestNewsTVCell")
        typeCollection.register(MEBITCollectionViewCell.nib(), forCellWithReuseIdentifier: "MEBITCollectionViewCell")
       
        subTypeColltection.register(UINib.init(nibName: "SubTypeCVCell", bundle: nil), forCellWithReuseIdentifier: "SubTypeCVCell")

        
    }
    
    @IBAction func btnSearchAction(_ sender: UIButton) {
        if sender.tag == 10 {
            viewSearch.isHidden = true
        }else{
//            if sender.isSelected{
//                sender.isSelected = false
//                viewSearch.isHidden = true
//            }else{
//                sender.isSelected = true
                viewSearch.isHidden = false
//            }
        }
    }
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}


//MARK:- UITableview Delegate
extension NewsHomeVC : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.getNumbersOfSections()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumbersOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.getCellForRowAt(indexPath, tableView: tblList)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.getHeightForRowAt(indexPath, tableView: tblList)
    }
}

//MARK:- CollectionView Delegate
extension NewsHomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == subTypeColltection{
            let cell = subTypeColltection.dequeueReusableCell(withReuseIdentifier: "SubTypeCVCell", for: indexPath) as! SubTypeCVCell
            return cell
        }else{
            let cell = typeCollection.dequeueReusableCell(withReuseIdentifier: "MEBITCollectionViewCell", for: indexPath) as! MEBITCollectionViewCell
            cell.baseView.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
            //        //cell.titleLabel.adjustsFontSizeToFitWidth = true
            //        //cell.titleLabel.minimumScaleFactor = 0.5
            //        if indexPath.row == 0{
            //            cell.titleLabel.text = "All"
            //        }else{
            //            print("\(String(describing: arrList[indexPath.row - 1].lable))")
            //        cell.titleLabel.text = arrList[indexPath.row - 1].label
            //        }
            //        if indexPath.row == index {
            //            cell.bottomlabel.isHidden = false
            //            cell.titleLabel.font = UIFont.init(name: "SF Pro Text, Bold", size: 14)
            //
            //        }else{
            //            cell.titleLabel.font = UIFont.init(name: "SF Pro Text, Regular", size: 14)
            //            cell.bottomlabel.isHidden = true
            //
            //        }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

//        hydrogenCategoryCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
//        index = indexPath.row
//        if indexPath.row == 0{
//            catID = ""
//        }else{
//            catID = arrList[indexPath.row - 1].id ?? ""
//
//            print("catID \(catID)")
//        }
//        self.checkPagination = "get"
//        isFromCat = true
//        if indexPath.row == 0{
//            CallWebserviceHydrogenList(strType: "", sortkey: sortKey, sortorder: sortOrder)
//
//        }else{
//            CallWebserviceHydrogenList(strType: catID, sortkey: sortKey, sortorder: sortOrder)
//
//        }
//        hydrogenCategoryCollectionView.reloadData()

        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let label = UILabel(frame: CGRect.zero)
//        let obj = self.arrFilter[indexPath.row]
//        label.text = obj["name"] as? String
//        label.sizeToFit()
//        let itemWidth = label.frame.width + 40
//        return CGSize(width: itemWidth  , height: 40)
            return CGSize(width: 80, height: 35)
        }
    
    
}
