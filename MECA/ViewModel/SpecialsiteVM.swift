//
//  SpecialsiteVM.swift
//  MECA
//
//  Created by Macbook  on 20/07/21.
//

import Foundation
class SpecialsiteVM: BaseTableViewVM {
    var Mecad_informationList = [Mecad_information]()
    var GRSpecial_sites = [Special_sites]()
    var specialsiteData: SpecialsiteData?
    var arrMecad_List : Mecad_information?
    var isFromDistributor = false
    override init(controller: UIViewController?) {
        super.init(controller: controller)
    (self.actualController as! SpecialsitesVC).checkPagination = "get"

        GlobalObj.displayLoader(true, show: true)

        callWebserviceForSpecialsiteVM()
    }
    
    
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SitetableCell", for: indexPath) as! SitetableCell
            cell.FromSpecialsites =  (actualController as? SpecialsitesVC).self
            cell.btnGt.tag = indexPath.row
            cell.btngran.tag = indexPath.row
            cell.btnmena.tag = indexPath.row
            cell.btnGt.addTarget(self, action: #selector(self.btnGtAction), for: .touchUpInside)
            cell.btngran.addTarget(self, action: #selector(self.btngranAction), for: .touchUpInside)
            cell.btnmena.addTarget(self, action: #selector(self.btnmenaAction), for: .touchUpInside)
            if self.specialsiteData != nil{
                cell.setCell(newsObject: self.specialsiteData!)
            }

            return cell
        }else
        if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "GrSiteselectionCell", for: indexPath) as! GrSiteselectionCell
            cell.FromSpecialsitesselect =  (actualController as? SpecialsitesVC).self
            cell.btnmecadinfn.tag = indexPath.row
            cell.btnDistinfn.tag = indexPath.row
            cell.btnmecadinfn.addTarget(self, action: #selector(self.btnmecadAction), for: .touchUpInside)
            cell.btnDistinfn.addTarget(self, action: #selector(self.btnDistAction), for: .touchUpInside)
             return cell
        }else if
            indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialInfnTblCell", for: indexPath) as! SpecialInfnTblCell
            cell.Specialsite =  (actualController as? SpecialsitesVC).self
            cell.isFromDistributor = isFromDistributor
            if self.specialsiteData != nil{
                cell.setsiteData(dataforspecialsite: self.specialsiteData!)
            }
             return cell
        }
        return UITableViewCell()
    }
    override func getNumbersOfRows(in section: Int) -> Int {
        if section == 0{
            return 1
        }
//
        else if section == 1{
            return 1
        }
//////
        else{
             return 1

           // return arrlist.count
        }
         
    }
    override func getHeightForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        if indexPath.row == 0{
            return UITableView.automaticDimension
        }
        else if indexPath.row == 1 {
            return UITableView.automaticDimension
        }
        else{
            return UITableView.automaticDimension
        }
    }
    
    @objc func btnmecadAction(sender: UIButton){
        isFromDistributor = false
        (self.actualController as! SpecialsitesVC).buttonPlus.isHidden = true
        print("btnDistAction \(isFromDistributor)")
        
        let point = (self.actualController as! SpecialsitesVC).tblActivity.convert(sender.center, from: sender.superview!)

        if let wantedIndexPath = (actualController as! SpecialsitesVC).tblActivity.indexPathForRow(at: point) {
            let cell = (actualController as! SpecialsitesVC).tblActivity.cellForRow(at: wantedIndexPath) as! GrSiteselectionCell
            
            cell.btnmecadinfn.setImage(UIImage(named: "selected_bg"), for: UIControl.State.normal)
            cell.btnDistinfn.setImage(UIImage(named: "not_selected_bg"), for: UIControl.State.normal)
            (actualController as! SpecialsitesVC).tblActivity.beginUpdates()
            (actualController as! SpecialsitesVC).tblActivity.endUpdates()
        }
        (actualController as! SpecialsitesVC).tblActivity.reloadData()
        
    }
    @objc func btnDistAction(sender: UIButton){
        isFromDistributor = true
        (self.actualController as! SpecialsitesVC).buttonPlus.isHidden = false
        print("btnDistAction \(isFromDistributor)")
        
        let point = (self.actualController as! SpecialsitesVC).tblActivity.convert(sender.center, from: sender.superview!)

        if let wantedIndexPath = (actualController as! SpecialsitesVC).tblActivity.indexPathForRow(at: point) {
            let cell = (actualController as! SpecialsitesVC).tblActivity.cellForRow(at: wantedIndexPath) as! GrSiteselectionCell
            
            cell.btnDistinfn.setImage(UIImage(named: "selected_bg"), for: UIControl.State.normal)
            cell.btnmecadinfn.setImage(UIImage(named: "not_selected_bg"), for: UIControl.State.normal)
            (actualController as! SpecialsitesVC).tblActivity.beginUpdates()
            (actualController as! SpecialsitesVC).tblActivity.endUpdates()
        }
        (actualController as! SpecialsitesVC).tblActivity.reloadData()
//        (actualController as! SpecialsitesVC).tblActivity.beginUpdates()
//        (actualController as! SpecialsitesVC).tblActivity.endUpdates()
        
    }
    @objc func btnGtAction(sender: UIButton){
        
        print("Special_sites GT\(String(describing: self.GRSpecial_sites[0].link))")
        
        var query = self.GRSpecial_sites[0].link
        query = query!.replacingOccurrences(of: " ", with: "")
        query = query!.replacingOccurrences(of: "=>", with: ":")
        
        print("\(query!)")
        //UIApplication.shared.open(URL(string: url), options: [:], completionHandler: nil)
        if let url = URL(string: query!), UIApplication.shared.canOpenURL(url) {
           if #available(iOS 10.0, *) {
              UIApplication.shared.open(url, options: [:], completionHandler: nil)
           } else {
              UIApplication.shared.openURL(url)
           }
        }

    }
    @objc func btngranAction(sender: UIButton){
        print("Special_sites GT\(String(describing: self.GRSpecial_sites[1].link))")
        
        var query = self.GRSpecial_sites[1].link
        query = query!.replacingOccurrences(of: " ", with: "")
        query = query!.replacingOccurrences(of: "=>", with: ":")
        
        print("\(query!)")
        //UIApplication.shared.open(URL(string: url), options: [:], completionHandler: nil)
        if let url = URL(string: query!), UIApplication.shared.canOpenURL(url) {
           if #available(iOS 10.0, *) {
              UIApplication.shared.open(url, options: [:], completionHandler: nil)
           } else {
              UIApplication.shared.openURL(url)
           }
        }
    }
    
    
    @objc func btnmenaAction (sender:UIButton){
        print("Special_sites GT\(String(describing: self.GRSpecial_sites[2].link))")
        
        var query = self.GRSpecial_sites[2].link
        query = query!.replacingOccurrences(of: " ", with: "")
        query = query!.replacingOccurrences(of: "=>", with: ":")
        
        print("\(query!)")
        //UIApplication.shared.open(URL(string: url), options: [:], completionHandler: nil)
        if let url = URL(string: query!), UIApplication.shared.canOpenURL(url) {
           if #available(iOS 10.0, *) {
              UIApplication.shared.open(url, options: [:], completionHandler: nil)
           } else {
              UIApplication.shared.openURL(url)
           }
        }
    }
    func callWebserviceForSpecialsiteVM(){
        GlobalObj.displayLoader(true, show: true)
        
        APIClient.webserviceForGRSpecialsiteList(limit: "10", page: String((self.actualController as! SpecialsitesVC).currentPage), params: [:]) { (result) in
            
            if let respCode = result.resp_code{
                GlobalObj.displayLoader(true, show: false)
                if respCode == 200{
                    print("special site response ..... \(result)")
                    if let arrDate = result.data{
                        if (self.actualController as! SpecialsitesVC).checkPagination == "get"{
                            
                            //self.specialsiteData.removeAll()
                        }
//                        if arrDate.count == 0 {
//                            GlobalObj.displayLoader(true, show: false)
//                            return
//                        }
//                        for objData in arrDate {
//                            self.arrLinkList.append(objData)
//                        }
                        self.GRSpecial_sites = arrDate.special_sites!
                        self.Mecad_informationList = arrDate.mecad_information!
                        self.specialsiteData = arrDate
                        (self.actualController as! SpecialsitesVC).tblActivity.reloadData()
                    }
//                    (self.actualController as! SpecialsitesVC).tblActivity.reloadData()
                }else{
                    GlobalObj.displayLoader(true, show: false)

                }
            }
            GlobalObj.displayLoader(true, show: false)
            

        }
    }
}
