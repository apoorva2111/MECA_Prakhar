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
    var index = 0
    var indexSubCat = 0
    var strCategory = ""
    var currentPage : Int = 1
    var checkPagination = ""

    var arrSubCat = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSearch.isHidden = true
        viewSubCollection.isHidden = true
        viewModel = NewsHomeVM.init(controller: self)
        viewModel.callWebserviceNewsCategory()
      

        registernib()
        
    }
    func registernib() {
        
        tblList.register(UINib.init(nibName: "NewsHomePickTVCell", bundle: nil), forCellReuseIdentifier: "NewsHomePickTVCell")
        tblList.register(UINib.init(nibName: "LatestNewsTVCell", bundle: nil), forCellReuseIdentifier: "LatestNewsTVCell")
        typeCollection.register(MEBITCollectionViewCell.nib(), forCellWithReuseIdentifier: "MEBITCollectionViewCell")
       
        subTypeColltection.register(UINib.init(nibName: "SubTypeCVCell", bundle: nil), forCellWithReuseIdentifier: "SubTypeCVCell")
        tblList.delegate = self
        tblList.dataSource = self
        typeCollection.delegate = self
        typeCollection.dataSource = self
        subTypeColltection.delegate = self
        subTypeColltection.dataSource = self
        
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
//            if indexPath == lastVisibleIndexPath {
//                if indexPath.row == arrList.count-1{
//                    self.checkPagination = "pagination"
//                    currentPage += 1
//                    GlobalObj.run(after: 2) {
//                        GlobalObj.displayLoader(true, show: true)
//                        self.callSDGSLISTWebservice(type: Int(self.idvalue)!)
//
//                    }
//                }
//            }
//        }
    }
}

//MARK:- CollectionView Delegate
extension NewsHomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == typeCollection{
            return viewModel.arrNewsCat.count
        }else{
            return arrSubCat.count
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == subTypeColltection{
            let cell = subTypeColltection.dequeueReusableCell(withReuseIdentifier: "SubTypeCVCell", for: indexPath) as! SubTypeCVCell
            cell.lblSubCat.text = arrSubCat[indexPath.row]
            if indexPath.row == indexSubCat{
                cell.lblSubCat.backgroundColor = UIColor.getCustomBlueColor()
            }else{
                cell.lblSubCat.backgroundColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
            }

            return cell
        }else{
            let cell = typeCollection.dequeueReusableCell(withReuseIdentifier: "MEBITCollectionViewCell", for: indexPath) as! MEBITCollectionViewCell
            cell.baseView.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
                    if indexPath.row == 0{
                        cell.titleLabel.text = "Home"
                    }else{
                        print("\(String(describing: viewModel.arrNewsCat[indexPath.row - 1].category))")
                        cell.titleLabel.text = viewModel.arrNewsCat[indexPath.row - 1].category
                    }

                    if indexPath.row == index {
                        cell.bottomlabel.isHidden = false
                        cell.titleLabel.font = UIFont.init(name: "SFPro-Bold", size: 14)
                      //
            
                    }else{
                        cell.titleLabel.font = UIFont.init(name: "SFPro-Regular", size: 14)
                        cell.bottomlabel.isHidden = true
            
                    }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == typeCollection{
            typeCollection.scrollToItem(at: indexPath, at: .left, animated: true)
            index = indexPath.row
            if index == 0 {
                viewSubCollection.isHidden = true
                indexSubCat = 0

            }else{
                let obj = viewModel.arrNewsCat[indexPath.row - 1]
                strCategory = obj.category ?? ""
                indexSubCat = 0
                if let subCat = obj.subcategories{
                    if subCat.count>0{
                        if arrSubCat.count>0{
                            arrSubCat.removeAll()
                        }
                        arrSubCat = subCat
                        viewSubCollection.isHidden = false
                        subTypeColltection.reloadData()
                        currentPage = 1
                        self.checkPagination = "get"
                        viewModel.callWebserviceForNewListWithCat(keyword: txtSearch.text!, category: strCategory, subcategory:obj.subcategories?[0] ?? "", page:String(currentPage))
                    }else{
                        currentPage = 1
                        self.checkPagination = "get"
                        viewSubCollection.isHidden = true
                        viewModel.callWebserviceForNewListWithCat(keyword: txtSearch.text!, category: strCategory, subcategory: "", page:String(currentPage))
                    }
                    
                }
               
                
            }

            typeCollection.reloadData()

        }else{
            subTypeColltection.scrollToItem(at: indexPath, at: .left, animated: true)
            indexSubCat = indexPath.row
            subTypeColltection.reloadData()
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == typeCollection{

        let label = UILabel(frame: CGRect.zero)

        if indexPath.row == 0{
            label.text = "Home"
            label.sizeToFit()
            let itemWidth = label.frame.width + 20
            return CGSize(width: itemWidth  , height: 40)
        }else{
            if viewModel.arrNewsCat.count>0{
                let obj = viewModel.arrNewsCat[indexPath.row - 1 ].category
                label.text = obj
                label.sizeToFit()
                let itemWidth = label.frame.width + 20
                return CGSize(width: itemWidth  , height: 40)
            }
        }
            return CGSize(width: 0  , height: 0)
            
        }else{
            
            let label = UILabel(frame: CGRect.zero)
                if arrSubCat.count>0{
                    let obj = arrSubCat[indexPath.row]
                    label.text = obj
                    label.sizeToFit()
                    let itemWidth = label.frame.width + 20
                    return CGSize(width: itemWidth  , height: 50)
                }
            
                return CGSize(width: 0  , height: 0)
                
            }
    }
}
    

