//
//  TrainingVC.swift
//  MECA
//
//  Created by Macbook  on 28/05/21.
//

import UIKit

class TrainingVC: UIViewController {
    //collectionviewcategory
    var arrList = [Training_module]()
    var updatedText = ""
    var param : [String:Any] = [:]
    var currentPage : Int = 1
    var checkPagination = ""
    var trainingAllData =  [Trainingdatalist]()
    var isFromCat = false
    var sortKey = ""
    var sortOrder = ""
    private var pullControl = UIRefreshControl()
    var sortingArr = [Sorting_options]()
    @IBOutlet weak var trainingtblview:UITableView!
    @IBOutlet weak var trainingCategoryCollectionView: UICollectionView!
    
    @IBOutlet weak var txttrainigsearchbar : UITextField!
    var index = 0
    var catID = ""
    var isFromPDCA = false
    var isFromWALL = false
    var wallarrAllData =  [walloffame_datas]()
    var PdcaarrAllData =  [PDCAindexlist]()
    var walldetailvalue:walloffame_detailModel?
     
    @IBOutlet weak var tableviewbackimage: UIImageView!
    var pdcaArray = ["All","DMDP","Mentor" ,"Crash","PDCA","Wall of Fame"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        trainingCategoryCollectionView.register(MEBITCollectionViewCell.nib(), forCellWithReuseIdentifier: "MEBITCollectionViewCell")
        trainingCategoryCollectionView.delegate = self
        trainingCategoryCollectionView.dataSource = self
        self.trainingtblview.estimatedRowHeight = 70
        self.trainingtblview.rowHeight = UITableView.automaticDimension
        trainingtblview?.register(TrainingTableCell.nib, forCellReuseIdentifier: TrainingTableCell.identifier)
        trainingtblview.register(WalltitleTableCell.nib, forCellReuseIdentifier: WalltitleTableCell.identifier)
        trainingtblview.register(wallofframeindexCell.nib, forCellReuseIdentifier: wallofframeindexCell.identifier)
        trainingtblview?.dataSource = self
        trainingtblview?.delegate = self
        tableviewbackimage.isHidden = true
        trainingtblview?.backgroundColor=UIColor.clear
         callWebservicetrainingCategory()
         setupUI()
        self.checkPagination = "get"
        currentPage = 1
        webserviceForTrainingLIst(strType: "", sortkey: sortKey, sortorder: sortOrder)
        pullControl.tintColor = UIColor.gray
        pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            trainingtblview.refreshControl = pullControl
        } else {
            trainingtblview.addSubview(pullControl)
        }

        // Do any additional setup after loading the view.
    }
    @objc private func refreshListData(_ sender: Any) {
        self.pullControl.endRefreshing()
        currentPage = 1
        self.checkPagination = "get"
        webserviceForTrainingLIst(strType: "", sortkey: sortKey, sortorder: sortOrder)
    }
    func setupUI()  {
         let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 90, height: 35)
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = 0
        trainingCategoryCollectionView!.collectionViewLayout = layout
        trainingCategoryCollectionView!.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
   layout.scrollDirection = .horizontal
    }
    
    
    //hydrogen event call api
    func callWebservicetrainingCategory() {
        APIClient.webserviceForCategoryList { (result) in
            
            if let respCode = result.resp_code{
             
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)
                    print("\(String(describing: result.data))")
                    if let arrDate = result.data{
                        if self.arrList.count>0{
                            self.arrList.removeAll()
                        }
                    
                        if arrDate.hydrogen!.count>0{
                            print("\(String(describing: arrDate.tbp))")
                            self.arrList = arrDate.tbp!
                        }
                        
                        if self.sortingArr.count>0{
                            self.sortingArr.removeAll()
                        }
                        if arrDate.sorting_options!.count>0{
                            self.sortingArr = arrDate.sorting_options!
                        }
                    }
                    self.trainingCategoryCollectionView.reloadData()
                }else{
                    GlobalObj.displayLoader(true, show: false)

                }
            }
            
            GlobalObj.displayLoader(true, show: false)

        }
  
    }
    
    //trianing api call
    func webserviceForTrainingLIst(strType: String,sortkey: String, sortorder: String) {

        param = [ "type" : catID,
                 // "keyword" : updatedText,
                 // "sortkey" : sortkey,
                  //"sortorder" : sortorder
        ]
        print("param\(param)")
        //param["keyword": "", "type": "", "sortorder": "", "sortkey": ""]

        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForTrainingLIst(limit:"10", page: String(currentPage), params: param) { (result) in
            
            if let respCode = result.resp_code{
             
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)
                    if self.checkPagination == "get"{
                        self.trainingAllData.removeAll()
                        
                        if let arrDate = result.data{
                            if self.isFromCat == false{
                            }else{
                                self.isFromCat = false
                            }
                            for obj in arrDate {
                                print("\(obj)")
                                self.trainingAllData.append(obj)
                                
                            }
                            
                            if self.trainingAllData.count>0{
                                self.trainingtblview.isHidden = false
                                self.trainingtblview.reloadData()

                            }else{
                                self.trainingtblview.isHidden = true
                            }
                        }
                    }else{
                        
                        if let arrDate = result.data{
                            if self.isFromCat == false{
                            }else{
                                self.isFromCat = false
                            }
                            for obj in arrDate {
                                self.trainingAllData.append(obj)
                            }
                            
                            if arrDate.count>0{
                                self.trainingtblview.isHidden = false
                                self.trainingtblview.reloadData()

                            }else{
                            }
                        }
                    }
                    
                }else{
                    GlobalObj.displayLoader(true, show: false)
                }
            }
            
            GlobalObj.displayLoader(true, show: false)

        }
        
    }
    @IBAction func onClickDismiss(_ sender: UIButton) {
        let mainVC = FlowController().instantiateViewController(identifier: "NavCategory", storyBoard: "Category")
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.window?.rootViewController = mainVC
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.3

        UIView.transition(with: appDel.window!, duration: duration, options: options, animations: {}, completion:
        { completed in
            // maybe do something on completion here
        })
        appDel.window?.makeKeyAndVisible()
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension TrainingVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if isFromPDCA {
            return 1
        }else if isFromWALL {
            return 2
        }else{
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if isFromPDCA {
           return PdcaarrAllData.count
        }else if isFromWALL {
            if section == 0 {
               return 1
            }else if section == 1{
                return wallarrAllData.count
            }
            
            
        }else{
            return trainingAllData.count
        }
      return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
//        cell?.delegate = self
        //cell!.nameLbl.text = "TEst"
        
        
        if isFromPDCA {
          //  let objfeed = trainingAllData[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: TrainingTableCell.identifier, for: indexPath) as? TrainingTableCell
            tableviewbackimage.isHidden = true
            let pdcaobj = PdcaarrAllData[indexPath.row]
           cell?.setCelltrianingpdcalist(feed: pdcaobj)
            return cell!
        }
        else if isFromWALL {
            
            tableviewbackimage.isHidden = false
            if (indexPath.section == 0) {
            let cellwall = tableView.dequeueReusableCell(withIdentifier: WalltitleTableCell.identifier) as? WalltitleTableCell
                
                cellwall!.contentView.backgroundColor = UIColor.clear
                
               
                 return cellwall!
            }else{
                let cellwallindex = tableView.dequeueReusableCell(withIdentifier: wallofframeindexCell.identifier) as? wallofframeindexCell
                let objfeed = wallarrAllData[indexPath.row]
                cellwallindex!.contentView.backgroundColor = UIColor.clear
                cellwallindex?.setCellwallfamedetails(feed: objfeed)
                return cellwallindex!
            }
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TrainingTableCell.identifier, for: indexPath) as? TrainingTableCell
            tableviewbackimage.isHidden = true
            let objfeed = trainingAllData[indexPath.row]
            cell?.setCelltrianinglist(feed: objfeed)
            return cell!
        }
        
        
     
       
    }
}



//MARK: - TableView Delegate Methods
extension TrainingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if isFromPDCA{
            let story = UIStoryboard(name: "Category", bundle:nil)
    //      //  let obj = arrList[indexPath.row]
            let vc = story.instantiateViewController(withIdentifier: "Trainingdetailvc") as! TrainingdetailVC
            let obj = PdcaarrAllData [indexPath.row]
            print("jdhsfjdsh ... \(obj)")
            
            vc.headername = String(obj.title ?? "")
            vc.eventID = String(obj.id ?? 0)
            vc.isFromPDCA = true
    //
            self.navigationController?.pushViewController(vc, animated: true)
        }else if isFromWALL {
                        let story = UIStoryboard(name: "Training", bundle:nil)
                  let obj = wallarrAllData [indexPath.row]
                        let vc = story.instantiateViewController(withIdentifier: "Wallofframedetailvc") as! WallofframedetailVC
            vc.frame   = obj.frame
            vc.companyName = obj.companyName
            vc.courseDate = obj.courseDate
            vc.avatar = obj.avatar
            vc.country = obj.country
            vc.courseStatus = obj.courseStatus
            vc.displayName = obj.displayName
            vc.finalReportStatus = obj.finalReportStatus
            vc.finalReportDate = obj.finalReportDate
            vc.gradeAndYear = obj.gradeAndYear
            vc.mentorExperience = obj.mentorExperience
            vc.mentorPassedStatus = obj.mentorPassedStatus
            vc.mentorPassedDate = obj.mentorPassedDate
            vc.profession = obj.profession
            vc.step1Date = obj.step1Date
            vc.step1Status = obj.step1Status
            vc.step13_Status = obj.step13_Status
            vc.step13_Date = obj.step13_Date
            vc.step15_Status = obj.step15_Status
            vc.step15_Date = obj.step15_Date
//            vc.headername = "PDCA for TSP Leaders & MASS Champion B2 <Arabic>"
//            vc.eventID = "4"
            //vc.isFromPDCA = true
                        self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: TrainingTableCell.identifier, for: indexPath) as? TrainingTableCell
            cell!.backgroundColor = UIColor.white

            let obj = trainingAllData[indexPath.row]
            
            
            let story = UIStoryboard(name: "Category", bundle:nil)
    //      //  let obj = arrList[indexPath.row]
            let vc = story.instantiateViewController(withIdentifier: "Trainingdetailvc") as! TrainingdetailVC
    //        vc.idvalue = String(obj.id ?? "0")
            print("\(obj)")
            vc.headername = String(obj.title ?? "")
            vc.eventID = String(obj.id ?? 0)
    vc.isFromPDCA = false
            self.navigationController?.pushViewController(vc, animated: true)
            //self.trainingtblview.reloadData()
        }
        
        
    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
//            if indexPath == lastVisibleIndexPath {
//                if indexPath.row == trainingAllData.count-1{
//                    self.checkPagination = "pagination"
//                    currentPage += 1
//                    GlobalObj.run(after: 2) {
//                        GlobalObj.displayLoader(true, show: true)
//                        self.webserviceForTrainingLIst(strType: "", sortkey: self.sortKey, sortorder: self.sortOrder)                   }
//                }
//            }
//        }
//    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
//MARK:- UICollectionview Delegate Datasource
extension TrainingVC :  UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(".... \(arrList.count + 3)")
        return pdcaArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = trainingCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "MEBITCollectionViewCell", for: indexPath) as! MEBITCollectionViewCell
        cell.baseView.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
        //static code
        cell.titleLabel.text! = pdcaArray[indexPath.row]
        cell.titleLabel.sizeToFit()
        
        //server response code
//        if indexPath.row == 0{
//            cell.titleLabel.text = "All"
//        }else if indexPath.row  < arrList.count {
//            print("a count \(arrList.count)")
//            print("chaeck ...\(indexPath.row < arrList.count)")
//            cell.titleLabel.text = arrList[indexPath.row - 1].lable
//        }
        if indexPath.row == 0 {
            
            cell.titleLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
       else if indexPath.row == 1 {
           
            cell.titleLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
       else if indexPath.row == 2 {
           
            cell.titleLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
       else if indexPath.row == 3 {
           
            cell.titleLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        
        
      else  if indexPath.row == 4 {
            cell.titleLabel.text = "PDCA"
            cell.titleLabel.textColor = #colorLiteral(red: 0.9411764706, green: 0.3529411765, blue: 0.1568627451, alpha: 1)
        }
        
        else if indexPath.row == 5 {
            cell.titleLabel.text = "Wall Of fame"
            cell.titleLabel.textColor = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
        }
        if indexPath.row == index {
            cell.bottomlabel.isHidden = false
            cell.titleLabel.font = UIFont.init(name: "SF Pro Text, Bold", size: 14)

        }else{
            cell.titleLabel.font = UIFont.init(name: "SF Pro Text, Regular", size: 14)
            cell.bottomlabel.isHidden = true

        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        trainingCategoryCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        index = indexPath.row
//        if indexPath.row == 0{
//            catID = ""
//            isFromWALL = false
//            isFromPDCA = false
//            webserviceForTrainingLIst(strType: catID, sortkey: sortKey, sortorder: sortOrder)
//        }else if indexPath.row ==  1 {
////            print("chaeck ...\(indexPath.row < arrList.count)")
////            catID = arrList[indexPath.row].id!
//            catID = "1"
//            isFromWALL = false
//            isFromPDCA = false
//            webserviceForTrainingLIst(strType: catID, sortkey: sortKey, sortorder: sortOrder)
//        }else if indexPath.row == 2{
//            catID = "2"
//            webserviceForTrainingLIst(strType: catID, sortkey: sortKey, sortorder: sortOrder)
//        }else if indexPath.row == 3{
//            catID = "3"
//            webserviceForTrainingLIst(strType: catID, sortkey: sortKey, sortorder: sortOrder)
//        }
//
//
//
//        else if indexPath.row == 4 {
//
//            isFromPDCA = true
//           // trainingtblview.reloadData()
//
//        }else if indexPath.row == 5{
//            isFromWALL = true
//          //  trainingtblview.reloadData()
//          //  Wallofframedetailvc
////            let story = UIStoryboard(name: "Training", bundle:nil)
////    //      //  let obj = arrList[indexPath.row]
////            let vc = story.instantiateViewController(withIdentifier: "Wallofframedetailvc") as! WallofframedetailVC
////            self.navigationController?.pushViewController(vc, animated: true)
//        }
//        self.isFromCat = true
//        currentPage = 1
        
        
        //call server response code
//        if indexPath.row == 0 {
//            isFromWALL = false
//            isFromPDCA = false
//            webserviceForTrainingLIst(strType: "", sortkey: sortKey, sortorder: sortOrder)
//        }else if indexPath.row  < arrList.count {
//            webserviceForTrainingLIst(strType: catID, sortkey: sortKey, sortorder: sortOrder)
//            isFromWALL = false
//            isFromPDCA = false
//        }
        
        if indexPath.row == 0 {
            isFromWALL = false
            isFromPDCA = false
            catID = ""
            webserviceForTrainingLIst(strType: catID, sortkey: sortKey, sortorder: sortOrder)
        }
        else if indexPath.row == 1{
            isFromWALL = false
            isFromPDCA = false
            catID = "1"
            webserviceForTrainingLIst(strType: catID, sortkey: sortKey, sortorder: sortOrder)
        }
        else if indexPath.row == 2{
            isFromWALL = false
            isFromPDCA = false
            catID = "2"
            webserviceForTrainingLIst(strType: catID, sortkey: sortKey, sortorder: sortOrder)
        }else if indexPath.row == 3{
            isFromWALL = false
            isFromPDCA = false
            catID = "3"
            webserviceForTrainingLIst(strType: catID, sortkey: sortKey, sortorder: sortOrder)
        }
        else if indexPath.row == 4 {
            
            isFromPDCA = true
            isFromWALL = false
            //trainingtblview.reloadData()
            CallWebservicetrainingpdcameList(sortkey: sortKey, sortorder: sortOrder)
        }else if indexPath.row == 5{
            isFromWALL = true
            isFromPDCA = false
            PdcaarrAllData.removeAll()
             CallWebservicetrainingwalloffameList(sortkey: sortKey, sortorder: sortOrder)
           // trainingtblview.reloadData()
            
        }
//        
        trainingCategoryCollectionView.reloadData()

        print("isFromPDCA ddid \(isFromPDCA)")
    }
    
    
    func CallWebservicetrainingwalloffameList(sortkey: String, sortorder: String) {
       

        print(param)
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForWalloffamelist(limit: "40", page: String(currentPage), params: param) { (result) in
            
            if let respCode = result.resp_code{
             
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)
                    if self.checkPagination == "get"{
                        self.wallarrAllData.removeAll()
                        
                        if let arrDate = result.data{
                           
                            for obj in arrDate {
                                
                                self.wallarrAllData.append(obj)
                            }
                            if self.isFromCat{
                                self.isFromCat = false
                            }else{
//                                if arrDate.count == 0 {
//                                    GlobalObj.displayLoader(true, show: false)
//                                    return
//                                }
                            }
                            if self.wallarrAllData.count == 0{
                                self.trainingtblview.isHidden = true
                            }else{
                                self.trainingtblview.isHidden = false
                                self.trainingtblview.reloadData()

                            }
                        }
                    }else{
                        
                        if let arrDate = result.data{
                           
                            for obj in arrDate {
                                self.wallarrAllData.append(obj)
                            }
                            if self.isFromCat{
                                self.isFromCat = false
                            }else{
                                if arrDate.count == 0 {
                                //    GlobalObj.displayLoader(true, show: false)
                                //    return
                                }
                            }
                            if arrDate.count == 0{
                                
                                print("level")
                            }else{
                                self.trainingtblview.isHidden = false
                                self.trainingtblview.reloadData()

                            }
                        }
                    }
                  
                }else{
                    GlobalObj.displayLoader(true, show: false)
                }
            }
            GlobalObj.displayLoader(true, show: false)
        }
        
        
    }
    
    
    func CallWebservicetrainingpdcameList(sortkey: String, sortorder: String) {
       

        print(param)
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForPDCAlist(limit: "10", page: String(currentPage), params: param) { (result) in
            
            if let respCode = result.resp_code{
             
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)
                    if self.checkPagination == "get"{
                        self.PdcaarrAllData.removeAll()
                        
                        if let arrDate = result.data{
                           
                            for obj in arrDate {
                                
                                self.PdcaarrAllData.append(obj)
                            }
                            if self.isFromCat{
                                self.isFromCat = false
                            }else{
//                                if arrDate.count == 0 {
//                                    GlobalObj.displayLoader(true, show: false)
//                                    return
//                                }
                            }
                           
                            if self.PdcaarrAllData.count == 0{
                                self.trainingtblview.isHidden = true
                            }else{
                                self.trainingtblview.isHidden = false
                                self.trainingtblview.reloadData()

                            }
                        }
                    }else{
                        
                        if let arrDate = result.data{
                           
                            for obj in arrDate {
                                self.PdcaarrAllData.append(obj)
                            }
                            if self.isFromCat{
                                self.isFromCat = false
                            }else{
                                if arrDate.count == 0 {
                                //    GlobalObj.displayLoader(true, show: false)
                                //    return
                                }
                            }
                            if arrDate.count == 0{
                            }else{
                                self.trainingtblview.isHidden = false
                                self.trainingtblview.reloadData()

                            }
                        }
                    }
                  
                }else{
                    GlobalObj.displayLoader(true, show: false)
                }
            }
            GlobalObj.displayLoader(true, show: false)
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0{
            return CGSize(width: 60, height: 35)
        }else if indexPath.row == 1{
            return CGSize(width: 100, height: 35)
        }else if indexPath.row == 2{
            return CGSize(width: 100, height: 35)
        }else if indexPath.row == 3{
            return CGSize(width: 100, height: 35)
        }else if indexPath.row == 4{
            return CGSize(width: 100, height: 35)
        }else{
            return CGSize(width: 135, height: 35)
        }
            
        }
    
    
}
//MARK:- Textfeild delegate
extension TrainingVC : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
                   let textRange = Range(range, in: text) {
            updatedText = text.replacingCharacters(in: textRange,with: string)
            currentPage = 1
            self.checkPagination = "get"
            webserviceForTrainingLIst(strType: catID, sortkey: sortKey, sortorder: sortOrder)
        }
        return true
    }
}
