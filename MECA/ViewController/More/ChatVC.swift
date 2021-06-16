//
//  ChatVC.swift
//  MECA
//
//  Created by Macbook  on 12/05/21.
//

import UIKit
import Firebase
import FirebaseAuth

class ChatVC: UIViewController {
    @IBOutlet weak var chatheaderView: RCustomView!
    @IBOutlet weak var chattblview:UITableView!
    var keywordtext = ""
    
    var recentvalue = [Recentchatmodel]()
    var uservalue = [Chatusers]()
    var adminuservalue = [Adminchatusers]()
    override func viewDidLoad() {
        super.viewDidLoad()
        chattblview.estimatedRowHeight = 75
        chattblview.rowHeight = UITableView.automaticDimension
        chattblview.register(ChatTableCell.nib, forCellReuseIdentifier: ChatTableCell.identifier)
        chattblview.dataSource = self
        chattblview.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ChatlistApicall(Keyword: keywordtext)
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func ChatlistApicall(Keyword:String) {
        let param : [String:Any] = ["keyword" : Keyword]//"keyword" : "test"
        print(param)
        GlobalObj.displayLoader(true, show: true)
        APIClient.webServicesToChatlist(params: param) { (response) in
            print("login response\(String(describing: response.resp_code))")
            guard let respCode = response.resp_code else { return }
            GlobalObj.displayLoader(true, show: false)
            guard respCode == 200 else { return }
            guard let arrDate = response.data else {
                self.chattblview.reloadData()
                return
            }
            
            self.recentvalue = arrDate.recentchats ?? []
            print("uservalue\(self.recentvalue.count)")
            //For users
            self.uservalue = arrDate.users ?? []
            print("uservalue\(self.uservalue.count)")
            //For AdminUsers
            self.adminuservalue = arrDate.adminusers ?? []
            print("adminuservalue\(self.adminuservalue.count)")
            
            self.chattblview.reloadData()
        }
    }
    
    @objc func alertControllerBackgroundTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

//Mark: - Tableview Datasource Methods
extension ChatVC: UITableViewDataSource {
    
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
            
            cell.on3DotsClick = { btn in
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Clear Chat", style: .default) { _ in})
                alert.addAction(UIAlertAction(title: "Delete Chat", style: .destructive) { _ in})
                self.present(alert, animated: true, completion: {
                    alert.view.superview?.isUserInteractionEnabled = true
                    alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
                    let loc = btn.convert(CGPoint.zero, to: self.view).y + 20
                    alert.view.frame.origin = CGPoint(x: tableView.frame.width - alert.view.frame.size.width - 20, y: loc)
                })
            }
            
            let selfID =  userDef.string(forKey: UserDefaultKey.userId)!
            Database.database().reference().child(objFeed.base ?? "").child(objFeed.chatroom_id?.description ?? "")
                .child("unread").child(selfID).observe(DataEventType.value) { snapshot in
                    cell.setBadge(count: snapshot.value as? Int)
            }
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableCell.identifier, for: indexPath) as! ChatTableCell
            let adobjFeed = adminuservalue[indexPath.row]
            cell.setCelladminChatuser(feed:adobjFeed)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableCell.identifier, for: indexPath) as! ChatTableCell
            let aduserobjFeed = uservalue[indexPath.row]
            cell.setCelluser(feed:aduserobjFeed)
            return cell
        }
//        let objFeed = recentvalue[indexPath.row]
//        let adobjFeed = adminuservalue[indexPath.row]
//        cell.setCellChatuser(feed: objFeed)
//        if adminuservalue.count != 0 {
//            if indexPath.row == recentvalue.count + 1 {
//                cell.setCelladminChatuser(feed:adobjFeed)
//            }
//        }
    }
}

//MARK: - TableView Delegate Methods
extension ChatVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section) == 0 {
            let story = UIStoryboard(name: "Chat", bundle:nil)
            //let obj = arrList[indexPath.row]
            let vc = story.instantiateViewController(withIdentifier: "ChatdetailVC") as! ChatdetailController
            let objFeed = recentvalue[indexPath.row]
            
            vc.chatroom_id = objFeed.chatroom_id!
            vc.basetype = objFeed.base!
            vc.oppImage = objFeed.avatar!
            vc.oppName = objFeed.display_user_name!
            vc.oppId = objFeed.chat_with!
            vc.chat_type = objFeed.chat_type!
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else if (indexPath.section == 1) {
            let objFeed = adminuservalue[indexPath.row]
            callchatcreateWebservice(chatuser: objFeed.id!, isadmin: objFeed.is_admin!)
        } else {
            let objFeeduser = uservalue[indexPath.row]
            callchatcreateWebservice(chatuser: objFeeduser.id!, isadmin: objFeeduser.is_admin!)
        }
//        let cell = tableView.dequeueReusableCell(withIdentifier: SDGSListTableCell.identifier, for: indexPath) as? SDGSListTableCell
//        cell!.backgroundColor = UIColor.white
//
//        let obj = arrList[indexPath.row]
//        let story = UIStoryboard(name: "Category", bundle:nil)
//        let obj = arrList[indexPath.row]
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
    
    func callchatcreateWebservice(chatuser:Int,isadmin:Int) {
        GlobalObj.displayLoader(true, show: true)
        let param = ["chatuser":chatuser,
                     "is_admin":isadmin]
        print("chat param\(param)")
        APIClient.webServicesTochacreateuser(params: param) { (response) in
            print("login response \(response.resp_code ?? 0)")
            print("chatcreate response\( response)")
            GlobalObj.displayLoader(true, show: false)
            if let respCode = response.resp_code, respCode == 200, let arrList = response.data {
                
                let story = UIStoryboard(name: "Chat", bundle:nil)
                //let obj = arrList[indexPath.row]
                let vc = story.instantiateViewController(withIdentifier: "ChatdetailVC") as! ChatdetailController
                
                vc.chatroomid = arrList.chatroom_id!
                vc.basetype = arrList.base!
                vc.oppImage = arrList.avatar!
                vc.oppName = arrList.display_user_name!
                vc.oppId = arrList.user!
                vc.chat_type = arrList.chat_type!
                vc.chatroom_id = arrList.chatroom_id!
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
//            print("login response\(String(describing: response.message))")
//                    var temp1 : String!
//                    temp1 = response.message
//            let alertController = UIAlertController(title: "Message", message: temp1, preferredStyle: .alert)
//
//            alertController.addAction(UIAlertAction(title: "OK", style: .default) { action -> Void in
//                  self.navigationController?.popViewController(animated: true)
//            })
//            self.present(alertController, animated: true, completion: nil)
//            GlobalObj.showAlertVC(title: "Message", message: "", controller: self)
        }
    }
}
