//
//  NotificationVM.swift
//  MECA


import UIKit

class NotificationVM: BaseTableViewVM {
    var arrNoticationList = [NotificationList_Data]()
    var arrModule = [Modules]()
    override init(controller: UIViewController?) {
        super.init(controller: controller)
        actualController = controller
        (self.actualController as! NotificationVC).checkPagination = "get"
        (self.actualController as! NotificationVC).currentPage = 1
        callWebserviceForNotificationList(limit: "10", page: String((self.actualController as! NotificationVC).currentPage))
    }
    override func getNumbersOfSections()-> Int{
        return 1//self.arrVideoList.count
    }
    
    override func getNumbersOfRows(in section: Int) -> Int {
        return arrNoticationList.count
        
    }
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SignUpListTVCell", for: indexPath) as! SignUpListTVCell
        cell.setCell(dict: arrNoticationList[indexPath.row])
        return cell
    }
    
    override func didSelectRowAt(_ indexPath: IndexPath, tableView: UITableView) {
        print(arrNoticationList[indexPath.row].module!)
        callWebserviceForNotificationRead(notificationId: String(arrNoticationList[indexPath.row].id!), module: arrNoticationList[indexPath.row].module!)
    }
    override func getHeightForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> CGFloat {
            return 70
    }
    
    func callWebserviceForNotificationList(limit:String,page:String){
        GlobalObj.displayLoader(true, show: true)
        APIClient.wevserviceForNotificationList(limit: limit, page: page) { (result) in
            print(result)
            
            if let respCode = result.resp_code{
                GlobalObj.displayLoader(true, show: false)
                if respCode == 200{
                    if let arrDate = result.data{
                        if (self.actualController as! NotificationVC).checkPagination == "get" {
                            self.arrNoticationList.removeAll()
                            for objData in arrDate {
                                self.arrNoticationList.append(objData)
                            }
                            if self.arrNoticationList.count>0 {
                                (self.actualController as! NotificationVC).tblNotification.reloadData()
                            }
                        }else{
                            
                            for objData in arrDate {
                                self.arrNoticationList.append(objData)
                            }
                        }
                        if arrDate.count>0 {
                            (self.actualController as! NotificationVC).tblNotification.reloadData()
                        }
                        self.callWebserviceCategory()
                    }else{
                        GlobalObj.displayLoader(true, show: false)
                    }
                }
            }else{
                GlobalObj.displayLoader(true, show: true)
            }
        }
    }
    
    //wevserviceForNotificationRead
    func callWebserviceForNotificationRead(notificationId:String,module:Int){
        GlobalObj.displayLoader(true, show: true)
        APIClient.wevserviceForNotificationRead(notificationId: notificationId) { (result) in
            GlobalObj.displayLoader(true, show: false)
            if let respCode = result.resp_code{
                
                GlobalObj.displayLoader(true, show: false)
                if respCode == 200{
                    print(module)
                    for objModule in self.arrModule {
                        if objModule.id == 2 {
                            let story = UIStoryboard(name: "Category", bundle:nil)
                            let vc = story.instantiateViewController(withIdentifier: "TrainingVC") as! TrainingVC
                            GlobalValue.tabCategory = "MEBIT"
                            (self.actualController as! NotificationVC).navigationController?.pushViewController(vc, animated: true)
                            
                        }else if objModule.id == 3 {
                            let story = UIStoryboard(name: "Category", bundle:nil)
                            let vc = story.instantiateViewController(withIdentifier: "MEBITViewController") as! MEBITViewController
                            vc.headerImageValue  = "1"
                            GlobalValue.tabCategory = "MEBIT"
                            vc.module = objModule.id ?? 0
                            (self.actualController as! NotificationVC).navigationController?.pushViewController(vc, animated: true)
                            
                        }else if objModule.id == 5 {
                            let story = UIStoryboard(name: "Category", bundle:nil)
                            let vc = story.instantiateViewController(withIdentifier: "MaasVC") as! MaasViewController
                            GlobalValue.tabCategory = "Maas"
                            vc.module = objModule.id ?? 0
                            (self.actualController as! NotificationVC).navigationController?.pushViewController(vc, animated: true)
                            
                        }else if objModule.id == 6{
                            let story = UIStoryboard(name: "Category", bundle:nil)
                            let vc = story.instantiateViewController(withIdentifier: "MEBITViewController") as! MEBITViewController
                            vc.headerImageValue  = "6"
                            GlobalValue.tabCategory = "GR"
                            vc.module = objModule.id ?? 0
                            (self.actualController as! NotificationVC).navigationController?.pushViewController(vc, animated: true)
                            
                        }
                    }
                }
            }
        }
    }
        //Module
        func callWebserviceCategory() {
           // GlobalObj.displayLoader(true, show: true)
            APIClient.webserviceForCategoryList { (result) in
                GlobalObj.displayLoader(true, show: false)
                if let respCode = result.resp_code{
                    if respCode == 200{
                        // GlobalObj.displayLoader(true, show: false)
                        if self.arrModule.count>0{
                            self.arrModule.removeAll()
                        }
                        if let arrDate = result.data{
                        
                            if let arr = arrDate.modules{
                                print(arr)
                                self.arrModule = arr
                            }
                        }
                        
                    }else{
                        // GlobalObj.displayLoader(true, show: false)
                        
                    }
                }
                
                GlobalObj.displayLoader(true, show: false)
                
            }
            
        }
}
