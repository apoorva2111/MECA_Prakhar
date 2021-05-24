//
//  LikeOrCommentVM.swift
//  MECA
//
//  Created by Apoorva Gangrade on 12/05/21.
//

import UIKit
import Alamofire

class LikeOrCommentVM: BaseTableViewVM {
    
    var arrCommentList = [CommentListData]()
    var arrLinkList = [Like_ListData]()

    override init(controller: UIViewController?) {
        super.init(controller: controller)
        
    }
    override func getNumbersOfRows(in section: Int) -> Int {
        if (actualController as! LikeOrCommentVC).isFromLike == "Like"{
            return arrLinkList.count
        }else{
        return arrCommentList.count
        }
    }
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        if (actualController as! LikeOrCommentVC).isFromLike == "Like"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LikeDetailTVCell", for: indexPath) as! LikeDetailTVCell
            cell.setCell(linkListData: arrLinkList[indexPath.row])

            return cell

        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentDetailTVCell", for: indexPath) as! CommentDetailTVCell
            let objDict = arrCommentList[indexPath.row]
            cell.viewcontroller = (actualController as? LikeOrCommentVC).self
            cell.btnReplyOutlet.addTarget(self, action: #selector(btnReplyViewOpenAtion), for: .touchUpInside)
            cell.btnReplyOutlet.tag = indexPath.row
            cell.setCell(commentData: objDict)
            cell.btnSendCommentOutlet.addTarget(self, action: #selector(btnsendReplyViewOpenAtion), for: .touchUpInside)
            cell.btnSendCommentOutlet.tag = indexPath.row
          
            cell.btnDeleteOutlet.addTarget(self, action: #selector(btnsendDeleteCommentAtion), for: .touchUpInside)
            cell.btnDeleteOutlet.tag = indexPath.row

            
            cell.tblComment = (actualController as! LikeOrCommentVC).tblList
            return cell
        }
    
    }
    override func didSelectRowAt(_ indexPath: IndexPath, tableView: UITableView) {
//            let story = UIStoryboard(name: "Category", bundle:nil)
//            let vc = story.instantiateViewController(withIdentifier: "NewDetailVC") as! NewDetailVC
//            let obj = arrLinkList[indexPath.row]
//            vc.eventID = String(obj.id ?? 0)
//            vc.isFromGR = true
//            (self.actualController as! GRLinksVC).navigationController?.pushViewController(vc, animated: true)
       
    }
    override func getHeightForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        if (actualController as! LikeOrCommentVC).isFromLike == "Like"{
        return 60
        }else{
            return UITableView.automaticDimension
        }
    }
    
    @objc func btnReplyViewOpenAtion(sender : UIButton){
        let buttonPosition = sender.convert(CGPoint.zero, to: (actualController as! LikeOrCommentVC).tblList)
        let indexPath = (actualController as! LikeOrCommentVC).tblList.indexPathForRow(at: buttonPosition)
        let cell = (actualController as! LikeOrCommentVC).tblList.cellForRow(at: indexPath!) as! CommentDetailTVCell
        
        if sender.isSelected {
            sender.isSelected = false
            cell.viewSendCommentBoxHeightConstraint.constant = 0
            sender.setTitle("Reply", for: .normal)
            cell.viewSendComment.isHidden = true

            (actualController as! LikeOrCommentVC).tblList.beginUpdates()
            (actualController as! LikeOrCommentVC).tblList.endUpdates()
        }else{
            sender.isSelected = true
            cell.viewSendCommentBoxHeightConstraint.constant = 40
            cell.viewSendComment.isHidden = false
            sender.setTitle("Cancel", for: .normal)
            (actualController as! LikeOrCommentVC).tblList.beginUpdates()
            (actualController as! LikeOrCommentVC).tblList.endUpdates()
        }
    }
    @objc func btnsendReplyViewOpenAtion(sender : UIButton){
        let buttonPosition = sender.convert(CGPoint.zero, to: (actualController as! LikeOrCommentVC).tblList)
        let indexPath = (actualController as! LikeOrCommentVC).tblList.indexPathForRow(at: buttonPosition)
        let cell = (actualController as! LikeOrCommentVC).tblList.cellForRow(at: indexPath!) as! CommentDetailTVCell
        cell.btnReplyOutlet.setTitle("Reply", for: .normal)
        cell.btnReplyOutlet.isSelected = false
        let obj = arrCommentList[indexPath!.row]
        let comment = cell.txtsendComment.text!
        cell.txtsendComment.text! = ""
        if comment == ""{
            (actualController as! LikeOrCommentVC).showToast(message: "Please Enter Your Comment")
        }else{
            BoolValue.isFromReplyComment = true
            callWebserviceForAddComment(module: String((actualController as! LikeOrCommentVC).module), item: String((actualController as! LikeOrCommentVC).item), parent: String(obj.id!), isfile: "0", is_reply: "1", comment: comment, imgData: (actualController as! LikeOrCommentVC).imgDoc)

        }
    }
    @objc func btnsendDeleteCommentAtion(sender : UIButton){
        let obj = arrCommentList[sender.tag]
        print(obj.id!)
        callWebserviceForDeleteComment(commentId: String(obj.id ?? 0))

    }
    
    
    func callWebserviceForCommentList(module: String, item: String) {
        GlobalObj.displayLoader(true, show: true)
        APIClient.wevserviceForCommentList(module: module, item: item) { (result) in
            if let respCode = result.resp_code{
                GlobalObj.displayLoader(true, show: false)
                if respCode == 200{
                    if let arrData = result.data{
                        print(arrData)
                        if self.arrCommentList.count>0{
                            self.arrCommentList.removeAll()
                        }
                        for objData in arrData {
                            print(objData)
                            self.arrCommentList.append(objData)
                        }
                        if self.arrCommentList.count>0 {
                            (self.actualController as! LikeOrCommentVC).tblList.isHidden = false
                            (self.actualController as! LikeOrCommentVC).tblList.reloadData()
                        }else{
                            (self.actualController as! LikeOrCommentVC).tblList.isHidden = true
                        }
                    }
                }
            }
        }
    }
    
    func callWebserviceForLikeList(module: String, item: String) {
        GlobalObj.displayLoader(true, show: true)
        APIClient.wevserviceForLikeList(module: module, item: item) { (result) in
            if let respCode = result.resp_code{
                GlobalObj.displayLoader(true, show: false)
                if respCode == 200{
                    if let arrData = result.data{
                        print(arrData)
                        if self.arrLinkList.count>0{
                            self.arrLinkList.removeAll()
                        }
                        for objData in arrData {
                            self.arrLinkList.append(objData)
                        }
                        if self.arrLinkList.count>0 {
                            (self.actualController as! LikeOrCommentVC).tblList.isHidden = false
                            (self.actualController as! LikeOrCommentVC).tblList.reloadData()
                        }else{
                            (self.actualController as! LikeOrCommentVC).tblList.isHidden = true
                        }
                    }
                }
            }
        }
    }
    
    func callWebserviceForAddComment(module: String, item: String, parent:String, isfile:String,is_reply:String,comment:String,imgData:NSData)  {
       
            
            if !NetworkReachabilityManager()!.isReachable{
                GlobalObj.displayLoader(true, show: false)

                      GlobalObj.showNetworkAlert()
                      return
            }
            GlobalObj.displayLoader(true, show: true)

            let url = BaseURL + AddComment
        
            var headers = HTTPHeaders()

            let accessToken = userDef.string(forKey: UserDefaultKey.token)

            headers = ["Authorization":"Bearer \(accessToken ?? "")"]

           
           
            AF.upload(multipartFormData: { (multipartFormData) in
               
                                   

             
                multipartFormData.append(module.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"module")
               
                multipartFormData.append(item.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"item")

                multipartFormData.append(parent.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"parent")

                multipartFormData.append(isfile.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"isfile")

                multipartFormData.append(is_reply.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"is_reply")

                multipartFormData.append(comment.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"comment")

                    
                multipartFormData.append(imgData as Data, withName: "commentfile" , fileName: "file.jpeg", mimeType: "image/jpeg")
                                    
            

            }, to: url, method: .post,headers:headers).responseJSON(completionHandler: { (response) in
                print(response.value as Any)
                GlobalObj.displayLoader(true, show: false)

                if let objData = response.value as? [String:Any]{
                    if let resp = objData["resp_code"] as? Int{
                        if resp == 200{
                            if let msg = objData["message"] as? String{
                                print(msg)
                                (self.actualController as! LikeOrCommentVC).txtViewSendComment.text = ""
//                                self.callWebserviceForCommentList(module: module, item: item)
                                
                                if BoolValue.isFromReplyComment{
                                    BoolValue.isFromReplyComment = false
                                    self.callWebserviceForCommentList(module: module, item: item)
                                    
                                }else{
                                    
                                    (self.actualController as! LikeOrCommentVC).dismiss(animated: false) {
                                        (self.actualController as! LikeOrCommentVC).detailVC.viewDidLoad()
                                    }
                                }
                        }
                        
                        }
                    }
                    
                }else{
                print(response.error as Any)
                    GlobalObj.displayLoader(true, show: false)

                    (self.actualController as! LikeOrCommentVC).showToast(message: response.error.debugDescription)
                }
            })
    print("error")
        }
    
    func callWebserviceForDeleteComment(commentId : String)  {
        GlobalObj.displayLoader(true, show: true)
        APIClient.webServiceForDeleteComment(commentId: commentId) { (result) in
            GlobalObj.displayLoader(true, show: false)
            if let objDict = result as? NSDictionary{
                let resp_code = objDict["resp_code"] as! Int
                let message = objDict["message"] as! String
                if resp_code == 200{
                    (self.actualController as! LikeOrCommentVC).showToast(message: message)
                    self.callWebserviceForCommentList(module: String((self.actualController as! LikeOrCommentVC).module), item: String((self.actualController as! LikeOrCommentVC).item))
                }
            }else{
                GlobalObj.displayLoader(true, show: false)

            }
            
        }
    }
}
