//
//  ChatVC.swift
//  MECA
//
//  Created by Macbook  on 12/05/21.
//

import UIKit

class ChatVC: UIViewController {
    @IBOutlet weak var chatheaderView: RCustomView!
    @IBOutlet weak var chattblview:UITableView!
    var keywordtext = ""
    
    var recentvalue =  [Recentchatmodel]()
    var uservalue =  [Chatusers]()
    var adminuservalue =  [Adminchatusers]()
    override func viewDidLoad() {
        super.viewDidLoad()
        chattblview.estimatedRowHeight = 75
        
        self.chattblview.rowHeight = UITableView.automaticDimension
        chattblview?.register(ChatTableCell.nib, forCellReuseIdentifier: ChatTableCell.identifier)
        chattblview?.dataSource = self
        chattblview?.delegate = self
        ChatlistApicall(Keyword: keywordtext)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func ChatlistApicall(Keyword:String)  {
        let param : [String:Any] = [
                                    "keyword" : Keyword]//"keyword" : "test"
        print(param)
        GlobalObj.displayLoader(true, show: true)
        APIClient.webServicesToChatlist(params: param) { (response) in
            print("login response\(String(describing: response.resp_code))")
            if let respCode = response.resp_code{
             
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)
                    if let arrDate = response.data{
                    
                    if self.recentvalue.count>0{
                        self.recentvalue.removeAll()
                    }else{
                        if let arrRecent = arrDate.recentchats {
                            for obj in arrRecent {
                                self.recentvalue.append(obj)
                            }
                        }
                        print("uservalue\(self.recentvalue.count)")
                    }
                        
                       //For users
                        if self.uservalue.count>0{
                            self.uservalue.removeAll()
                        }else{
                            if let arrUsers = arrDate.users {
                                for obj in arrUsers {
                                    self.uservalue.append(obj)
                                }
                            }
                            print("uservalue\(self.uservalue.count)")
                        }
                        //For AdminUsers
                         if self.adminuservalue.count>0{
                             self.adminuservalue.removeAll()
                         }else{
                             if let arrUsers = arrDate.adminusers {
                                 for obj in arrUsers {
                                     self.adminuservalue.append(obj)
                                 }
                             }
                            print("adminuservalue\(self.adminuservalue.count)")
                         }
                    
                        
                    }
                    
                    self.chattblview.reloadData()
                }else{
                    GlobalObj.displayLoader(true, show: false)

                }
            }
            GlobalObj.displayLoader(true, show: false)

        }
        
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
//Mark: - Tableview Datasource Methods
extension ChatVC: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            print("recentvalue\(self.recentvalue.count)")
            return self.recentvalue.count
        }
        else if section == 1 {
            print("adminuservalue\(self.adminuservalue.count)")
            return self.adminuservalue.count
        }
        else {
            print("uservalue\(self.uservalue.count)")
            return self.uservalue.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableCell.identifier, for: indexPath) as! ChatTableCell
            let objFeed = recentvalue[indexPath.row]
            cell.setCellChatuser(feed: objFeed)
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableCell.identifier, for: indexPath) as! ChatTableCell
            let adobjFeed  =  adminuservalue[indexPath.row]
            cell.setCelladminChatuser(feed:adobjFeed)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableCell.identifier, for: indexPath) as! ChatTableCell
            let aduserobjFeed  =  uservalue[indexPath.row]
            cell.setCelluser(feed:aduserobjFeed)
            return cell
        }
//        let objFeed = recentvalue[indexPath.row]
//        let adobjFeed  =  adminuservalue[indexPath.row]
//        cell.setCellChatuser(feed: objFeed)
//        if adminuservalue.count != 0 {
//            if indexPath.row == recentvalue.count + 1 {
//
//                cell.setCelladminChatuser(feed:adobjFeed)
//            }
//
//        }
        
    }
}
//MARK: - TableView Delegate Methods
extension ChatVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: SDGSListTableCell.identifier, for: indexPath) as? SDGSListTableCell
//        cell!.backgroundColor = UIColor.white
//
//        let obj = arrList[indexPath.row]
//
//
//        let story = UIStoryboard(name: "Category", bundle:nil)
//      //  let obj = arrList[indexPath.row]
//        let vc = story.instantiateViewController(withIdentifier: "SDGSListVC") as! SDGSListvc
//        vc.idvalue = String(obj.id ?? "0")
//        vc.headerImageValue = String(obj.lable ?? "0")
//
//        self.navigationController?.pushViewController(vc, animated: true)
//        self.SDGSCategoryTableView.reloadData()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
