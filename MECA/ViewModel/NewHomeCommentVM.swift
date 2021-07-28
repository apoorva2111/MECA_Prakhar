//
//  NewHomeCommentVM.swift
//  MECA

import UIKit

class NewHomeCommentVM: BaseTableViewVM {
    var arrCommentList = [NewHomeCommentData]()
    
    override init(controller: UIViewController?) {
        super.init(controller: controller)
        (actualController as! NewHomeCommentVC).currentPage = 1
        (actualController as! NewHomeCommentVC).checkPagination = "get"
        callWebserviceForCommentList(feed: String((actualController as! NewHomeCommentVC).feedDetail.id!), limit: "10", page: String((actualController as! NewHomeCommentVC).currentPage))
    }
    
    
    override func getNumbersOfSections()-> Int{
        return 1//self.arrVideoList.count
    }
    
    override func getNumbersOfRows(in section: Int) -> Int {
        return arrCommentList.count + 1
        
    }
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeNewsFeedTVCell", for: indexPath) as! HomeNewsFeedTVCell
            cell.viewLike.isHidden = true
            cell.viewLikeHeightConstraint.constant = 0
            cell.btnSeeMoreOutlet.tag = indexPath.row
            cell.btnSeeMoreOutlet.addTarget(self, action: #selector(self.btnSeeMoreAction), for: .touchUpInside)
            cell.viewComment.isHidden = true
            cell.viewCommentHeightConstraint.constant = 0
            cell.lblLine.isHidden = true
            cell.buttonPlayOutlet.tag = indexPath.row
            cell.buttonPlayOutlet.addTarget(self, action: #selector(self.btnPlayVideoAction), for: .touchUpInside)

            cell.setCell(objFeed:(actualController as! NewHomeCommentVC).feedDetail, arrID: [])
                return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewHomeCommentTVCell", for: indexPath) as! NewHomeCommentTVCell
            let objComment = arrCommentList[indexPath.row - 1]
            cell.tbleComment = (actualController as! NewHomeCommentVC).tbllComment
            cell.btnViewReplyOutlet.tag = indexPath.row
            cell.btnViewReplyOutlet.addTarget(self, action: #selector(self.btnviewReplyAction), for: .touchUpInside)
            cell.btnLikeOutlet.tag = indexPath.row
            cell.btnLikeOutlet.addTarget(self, action: #selector(self.btnLikeCommentAction), for: .touchUpInside)
            cell.btnReplyOutlet.tag = indexPath.row
            cell.btnReplyOutlet.addTarget(self, action: #selector(self.btnReplyAction), for: .touchUpInside)
            cell.btnDeleteOutlet.tag = indexPath.row
            cell.btnDeleteOutlet.addTarget(self, action: #selector(self.btnDelectCommentAction), for: .touchUpInside)
            cell.btnSendReplyOutlet.tag = indexPath.row
            cell.btnSendReplyOutlet.addTarget(self, action: #selector(self.btnSendReplyAction), for: .touchUpInside)

            cell.setCell(comment:objComment)
                return cell
        }
    }
    
    override func didSelectRowAt(_ indexPath: IndexPath, tableView: UITableView) {
   
    }
    override func getHeightForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> CGFloat {
            return UITableView.automaticDimension
    }
    
    func callWebserviceForCommentList(feed:String,limit:String,page:String) {
        GlobalObj.displayLoader(true, show: true)
        
        APIClient.wevserviceForNewHomeFeedComment(feed: feed, limit: limit, page: page) { (result) in
            
            if let respCode = result.resp_code{
                GlobalObj.displayLoader(true, show: false)
        
                if respCode == 200{
                    if (self.actualController as! NewHomeCommentVC).checkPagination == "get"{
                       self.arrCommentList.removeAll()

                        if let arrList = result.data{
                            print(arrList)

                            for obj in arrList {
                                self.arrCommentList.append(obj)
                            }
                            if self.arrCommentList.count>0 {
                               BoolValue.isClickOnCategory = true

                               (self.actualController as! NewHomeCommentVC).tbllComment.reloadData()
                            }else{

                            }
                        }
                    }else{
                        //
                        if let arrList = result.data{
                            print(arrList)
                            
                            for obj in arrList {
                                self.arrCommentList.append(obj)
                            }
                            if arrList.count>0 {
                                (self.actualController as! NewHomeCommentVC).tbllComment.reloadData()
                                (self.actualController as! NewHomeCommentVC).tbllComment.isHidden = false
                            }
                        }
                    }
                }
            }
        }
    }

    func addComment(feedId:String,comment:String,parent:String,is_reply:String,isfile:String) {
        GlobalObj.displayLoader(true, show: true)
        let param: [String : Any] = ["feed":feedId,
                                     "comment":comment,
                                     "parent":parent,
                                     "is_reply":is_reply,
                                     "isfile":isfile]
        
        APIClient.webServicesForAddFeedComment(params: param) { (result) in
            if let respCode = result.resp_code{
                GlobalObj.displayLoader(true, show: false)
                if respCode == 200{
                    if let msg = result.message{
                        (self.actualController as! NewHomeCommentVC).showToast(message: msg)
                        (self.actualController as! NewHomeCommentVC).txtComment.text = ""
                        (self.actualController as! NewHomeCommentVC).currentPage = 1
                        (self.actualController as! NewHomeCommentVC).checkPagination = "get"
                        self.callWebserviceForCommentList(feed: feedId, limit: "10", page: String((self.actualController as! NewHomeCommentVC).currentPage))
                    }
                }
            }
        }
    }
    //completion:@escaping(Int) -> Void
    func callWebserviceForLikeFeed(item:String,status:String,like_type:String,completion:@escaping(NewHomeData) -> Void) {
        GlobalObj.displayLoader(true, show: true)
        let param : [String:Any] = ["item":item,
                                    "status":status,
                                    "like_type":like_type]
            APIClient.webserviceForNewHomeLike(params: param) { (result) in
                if let respCode = result.resp_code{
            GlobalObj.displayLoader(true, show: false)
                    if respCode == 200{
                        if let objDate = result.data{
                            completion(objDate)
                          //  self.callWebserviceForFeed(page: String((self.actualController as! HomeNewsFeedVC).currentPage))
                        }
                    }
                }

                
            }
    }
    
    func callWebserviceFroDeleteComment(commentId:String) {
        GlobalObj.displayLoader(true, show: true)
        APIClient.wevserviceForNewHomeFeedCommentDelete(commentId: commentId) { (result) in
            print(result)
            let rslt = result as! NSDictionary
            if let msg = rslt["message"] as? NSString{
                if msg == "Comment deleted"{
                    (self.actualController as! NewHomeCommentVC).showToast(message: msg as String)
                    
                    (self.actualController as! NewHomeCommentVC).currentPage = 1
                    (self.actualController as! NewHomeCommentVC).checkPagination = "get"
                    self.callWebserviceForCommentList(feed: String((self.actualController as! NewHomeCommentVC).feedDetail.id!), limit: "10", page: String((self.actualController as! NewHomeCommentVC).currentPage))
                }
            }
            GlobalObj.displayLoader(true, show: false)
        }
    }
    
    @objc func btnviewReplyAction(sender : UIButton){
        
        let point = (self.actualController as! NewHomeCommentVC).tbllComment.convert(sender.center, from: sender.superview!)

        if let wantedIndexPath = (actualController as! NewHomeCommentVC).tbllComment.indexPathForRow(at: point) {
            let cell = (actualController as! NewHomeCommentVC).tbllComment.cellForRow(at: wantedIndexPath) as! NewHomeCommentTVCell
        
            cell.btnViewReplyOutlet.isHidden = true
            cell.btnViewReplyHeightConstraint.constant = 0
            cell.tblReply.isHidden = false
            cell.tblReply.delegate = cell.self
            cell.tblReply.dataSource = cell.self
            
            cell.btnReplyOutlet.isSelected = true
            cell.btnReplyOutlet.setTitle("Cancel", for: .normal)
            userDef.setValue("showTable", forKey: UserDefaultKey.replyView)
            userDef.synchronize()
            cell.viewReply.isHidden = false
            (actualController as! NewHomeCommentVC).tbllComment.beginUpdates()
            cell.tblReply.reloadData()
            cell.tblReply.layoutIfNeeded()
            (actualController as! NewHomeCommentVC).tbllComment.endUpdates()
            

        }
    }
    @objc func btnSeeMoreAction(sender: UIButton){
        
        let point = (self.actualController as! NewHomeCommentVC).tbllComment.convert(sender.center, from: sender.superview!)

        if let wantedIndexPath = (actualController as! NewHomeCommentVC).tbllComment.indexPathForRow(at: point) {
            let cell = (actualController as! NewHomeCommentVC).tbllComment.cellForRow(at: wantedIndexPath) as! HomeNewsFeedTVCell
            if sender.isSelected{
                sender.isSelected = false
                cell.lblDescription.numberOfLines = 2
                sender.setTitle("See More", for: .normal)

                
            }else{
                sender.isSelected = true
                cell.lblDescription.numberOfLines = 0
                sender.setTitle("See less", for: .normal)
            }
            (actualController as! NewHomeCommentVC).tbllComment.beginUpdates()
            (actualController as! NewHomeCommentVC).tbllComment.endUpdates()
        }
        
        
    }
    @objc func btnPlayVideoAction(sender:UIButton){
        let objFeed = (actualController as! NewHomeCommentVC).feedDetail
        let objLink = (objFeed?.video_link)!

        guard let url = URL(string: objLink) else { return }
        UIApplication.shared.open(url)
    }
    @objc func btnLikeCommentAction (sender : UIButton){
        let point = (self.actualController as! NewHomeCommentVC).tbllComment.convert(sender.center, from: sender.superview!)
        
        if let wantedIndexPath = (actualController as! NewHomeCommentVC).tbllComment.indexPathForRow(at: point) {
            let cell = (actualController as! NewHomeCommentVC).tbllComment.cellForRow(at: wantedIndexPath) as! NewHomeCommentTVCell
            let obj = arrCommentList[sender.tag - 1]
            if obj.isLiked == 1{
                callWebserviceForLikeFeed(item: String((actualController as! NewHomeCommentVC).feedDetail.id!), status: "0", like_type: "2") { (feedDict) in
                    print(feedDict)
                    cell.btnLikeOutlet.setTitle("Like", for: .normal)
                }
            }else{
                callWebserviceForLikeFeed(item: String((actualController as! NewHomeCommentVC).feedDetail.id!), status: "1", like_type: "2") { (feedDict) in
                    print(feedDict)
                    cell.btnLikeOutlet.setTitle("Unlike", for: .normal)
                }
            }
        }
    }
    @objc func btnDelectCommentAction (sender : UIButton){
        let obj = arrCommentList[sender.tag - 1]

        callWebserviceFroDeleteComment(commentId: String(obj.id!))
    }
    @objc func btnReplyAction (sender : UIButton){
        
        let point = (self.actualController as! NewHomeCommentVC).tbllComment.convert(sender.center, from: sender.superview!)

        if let wantedIndexPath = (actualController as! NewHomeCommentVC).tbllComment.indexPathForRow(at: point) {
            let cell = (actualController as! NewHomeCommentVC).tbllComment.cellForRow(at: wantedIndexPath) as! NewHomeCommentTVCell
        
                if sender.isSelected{
                sender.isSelected = false
//                cell.viewReply.isHidden = true
//                   if cell.arrSubComment.count > 0 {
//                    cell.btnViewReplyOutlet.isHidden = false
//                    cell.btnViewReplyHeightConstraint.constant = 20
//                   }else{
//                    cell.btnViewReplyOutlet.isHidden = true
//                    cell.btnViewReplyHeightConstraint.constant = 0
//                   }
//                (actualController as! NewHomeCommentVC).tbllComment.beginUpdates()
//                    cell.tblReply.reloadData()
//                    cell.tblReply.layoutIfNeeded()
//                (actualController as! NewHomeCommentVC).tbllComment.endUpdates()
//                cell.tblReply.isHidden = true
//                cell.btnReplyOutlet.setTitle("Reply", for: .normal)
//                userDef.setValue("hideTable", forKey: UserDefaultKey.replyView)
//                userDef.synchronize()
                    cell.btnViewReplyOutlet.isHidden = true
                    cell.btnViewReplyHeightConstraint.constant = 0
                    cell.tblReply.isHidden = true
                    cell.tblReply.delegate = cell.self
                    cell.tblReply.dataSource = cell.self
                    cell.btnReplyOutlet.setTitle("Reply", for: .normal)
                    userDef.setValue("hideTable", forKey: UserDefaultKey.replyView)
                    userDef.synchronize()
                    cell.viewReply.isHidden = true
                    if cell.arrSubComment.count > 0 {
                        cell.btnViewReplyOutlet.isHidden = false
                        cell.btnViewReplyHeightConstraint.constant = 20
                    }else{
                        cell.btnViewReplyOutlet.isHidden = true
                        cell.btnViewReplyHeightConstraint.constant = 0
                    }
                    (actualController as! NewHomeCommentVC).tbllComment.beginUpdates()
                    cell.tblReply.reloadData()
                    cell.tblReply.layoutIfNeeded()
                    (actualController as! NewHomeCommentVC).tbllComment.endUpdates()
            }else{
                sender.isSelected = true
               // cell.viewReplyHeightConstraint.constant = 40
//                cell.viewReply.isHidden = false
//                cell.btnViewReplyOutlet.isHidden = true
//                cell.btnViewReplyHeightConstraint.constant = 0
//
//                cell.tblReply.isHidden = false
//                cell.tblReply.delegate = cell.self
//                cell.tblReply.dataSource = cell.self
//                cell.btnReplyOutlet.isSelected = true
//                cell.btnReplyOutlet.setTitle("Cancel", for: .normal)
//                (actualController as! NewHomeCommentVC).tbllComment.beginUpdates()
//                cell.tblReply.reloadData()
//                cell.tblReply.layoutIfNeeded()
//                (actualController as! NewHomeCommentVC).tbllComment.endUpdates()
//
//                userDef.setValue("showTable", forKey: UserDefaultKey.replyView)
//                userDef.synchronize()
                cell.btnViewReplyOutlet.isHidden = true
                cell.btnViewReplyHeightConstraint.constant = 0
                cell.tblReply.isHidden = false
                cell.tblReply.delegate = cell.self
                cell.tblReply.dataSource = cell.self
                
                cell.btnReplyOutlet.isSelected = true
                cell.btnReplyOutlet.setTitle("Cancel", for: .normal)
                userDef.setValue("showTable", forKey: UserDefaultKey.replyView)
                userDef.synchronize()
                cell.viewReply.isHidden = false
                (actualController as! NewHomeCommentVC).tbllComment.beginUpdates()
                cell.tblReply.reloadData()
                cell.tblReply.layoutIfNeeded()
                (actualController as! NewHomeCommentVC).tbllComment.endUpdates()

            }
        }
        
        
    }
    @objc func btnSendReplyAction (sender:UIButton){
        let point = (self.actualController as! NewHomeCommentVC).tbllComment.convert(sender.center, from: sender.superview!)

        if let wantedIndexPath = (actualController as! NewHomeCommentVC).tbllComment.indexPathForRow(at: point) {
            let cell = (actualController as! NewHomeCommentVC).tbllComment.cellForRow(at: wantedIndexPath) as! NewHomeCommentTVCell
            let obj = arrCommentList[sender.tag - 1]
            if cell.txtComment.text != "" {
                cell.btnReplyOutlet.setTitle("Reply", for: .normal)
                addComment(feedId: String((self.actualController as! NewHomeCommentVC).feedDetail.id!), comment: cell.txtComment.text, parent: String(obj.id!), is_reply: "1", isfile: "0")
                print("hudgjfkkd")
                cell.txtComment.text = ""
            }
            
        }
    }
    
    
}
