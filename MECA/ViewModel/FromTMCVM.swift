//
//  FromTMCVM.swift
//  MECA
//
//  Created by Macbook  on 06/07/21.
//

import Foundation
class FromTMCVM: BaseTableViewVM {
    let FromTmcPromotionCell = "FromTmcPromotionCell"
    let FromTMCCell = "FromTMCCell"
    
    
    var arrListTMC : DatafromTMC?
    var promotionvalue : Promotion?
    
    override init(controller: UIViewController?) {
        super.init(controller: controller)

    }
    // your dicti is empty or nil. wait 1 mint
    override func getNumbersOfRows(in section: Int) -> Int {
        
            if section == 0{
                return 1
            }else if section == 1{
                
                    return 1
                
               
            }
         return 0
       
    }
    
   
    
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        
        
        if (indexPath.section == 0) {
        let cell = tableView.dequeueReusableCell(withIdentifier: FromTmcPromotionCell, for: indexPath) as! FromTmcPromotionCell
        print(promotionvalue?.title)
        cell.viewcontrollerTMC = (actualController as! FromTMCVC).self
        if let mypromotion = self.promotionvalue {
            cell.setCellpromotion(objFeed: mypromotion)
            cell.btnSeeMoreOutlet.tag = indexPath.row
            cell.btnSeeMoreOutlet.addTarget(self, action: #selector(self.btnSeeMoreAction), for: .touchUpInside)
        }
        
        return cell
            
        }else if (indexPath.section == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: FromTMCCell, for: indexPath) as! FromTMCCell
            cell.FromTMCVC = (actualController as? FromTMCVC).self
            
            if arrListTMC != nil {
                cell.setTMCData(dataEventfortmc: arrListTMC!)
            }
            
            return cell
        }
            return UITableViewCell()
    }
    
    
    override func getHeightForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        if indexPath.section == 0{
            return UITableView.automaticDimension//440
        }else{
           // print("(arrListTMC?.tmcs!.count) //// \((arrListTMC?.tmcs!.count))")
            return UITableView.automaticDimension
        }
        
    }
    @objc func btnSeeMoreAction(sender: UIButton){
        
        let point = (self.actualController as! FromTMCVC).tblView.convert(sender.center, from: sender.superview!)

        if let wantedIndexPath = (actualController as! FromTMCVC).tblView.indexPathForRow(at: point) {
            let cell = (actualController as! FromTMCVC).tblView.cellForRow(at: wantedIndexPath) as! FromTmcPromotionCell
            if sender.isSelected{
                sender.isSelected = false
                cell.lblpromotion_Description.sizeToFit()
                cell.lblpromotion_Description.numberOfLines = 3
                sender.setTitle("See More", for: .normal)

                
            }else{
                sender.isSelected = true
                cell.lblpromotion_Description.numberOfLines = 0
                sender.setTitle("See less", for: .normal)
            }
            (actualController as! FromTMCVC).tblView.beginUpdates()
            (actualController as! FromTMCVC).tblView.endUpdates()
        }
        
        
    }
    //Api calling the FROM TMC
    func FromtmcsApicall()  {
       
        let param : [String:Any] = [
                                    "type" : 0]//"keyword" : "test"
        print(param)
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForFromTMClistapi(limit: "10",page: "1",params: param) { [self] (result) in
            print("oneandonly api response \(result)")
            if let repo = result.resp_code{
                GlobalObj.displayLoader(true, show: false)
               
                if repo == 200 {
                    
                    if let arrList = result.data{
                        print(arrList.promotion)
                        self.promotionvalue = arrList.promotion!
                        //where tableview?
                       // (self.actualController as! FromTMCVC).tblView.reloadData()
                        print("jkdfkd.,.,., \(promotionvalue) ")
                        
//                        if arrList.tmcs!.count > 0  {
//                            self.arrListTMC.removeAll()
//                        }
                        self.arrListTMC = arrList
//                        if let tmcs = arrList.tmcs {
//                            for obj in tmcs {
//                                self.arrListTMC.append(obj)
//                            }
//                        }
                        print("\(arrList.tmcs?.count)")
                        print("self.arrListTMC,..,.\(self.arrListTMC)")
                        (self.actualController as! FromTMCVC).tblView.reloadData()
//                        for obj in arrList[tmcs]? {
//                            //self.arrList.append(obj)
//                        }
                        
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

