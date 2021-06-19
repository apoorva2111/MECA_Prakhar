//
//  HomeNewsFeedVM.swift
//  MECA


import UIKit

class HomeNewsFeedVM: BaseTableViewVM {
    var arrFeed = [NewHomeData]()
    var documentLink = ""
    var feedId = ""
    var arrLikedArr = [NewHomeData]()
    
    
    override init(controller: UIViewController?) {
        super.init(controller: controller)
        (actualController as! HomeNewsFeedVC).currentPage = 1
        (actualController as! HomeNewsFeedVC).checkPagination = "get"
        callWebserviceForFeed(page: String((actualController as! HomeNewsFeedVC).currentPage))
    }
    
    
    override func getNumbersOfSections()-> Int{
        return 1//self.arrVideoList.count
    }
    
    override func getNumbersOfRows(in section: Int) -> Int {
        return arrFeed.count
        
    }
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        
        if tableView == (actualController as! HomeNewsFeedVC).tblFeed{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeNewsFeedTVCell", for: indexPath) as! HomeNewsFeedTVCell
            cell.viewcontrollerHome = (actualController as! HomeNewsFeedVC).self
            cell.btnMoreOutlet.tag = indexPath.row
            cell.btnMoreOutlet.addTarget(self, action: #selector(self.btnMoreAction), for: .touchUpInside)
           
            cell.btnLikeOutlet.tag = indexPath.row
            cell.btnLikeOutlet.addTarget(self, action: #selector(self.btnlikeCountAction), for: .touchUpInside)
            
            cell.btnLikeUnlikeOutlet.tag = indexPath.row
            cell.btnLikeUnlikeOutlet.addTarget(self, action: #selector(self.btnLikeunlikeAction), for: .touchUpInside)
            cell.btnSeeMoreOutlet.tag = indexPath.row
            cell.btnSeeMoreOutlet.addTarget(self, action: #selector(self.btnSeeMoreAction), for: .touchUpInside)
            cell.buttonPlayOutlet.tag = indexPath.row
            cell.buttonPlayOutlet.addTarget(self, action: #selector(self.btnPlayVideoAction), for: .touchUpInside)
            cell.btnCommentOutllet.tag = indexPath.row
            cell.btnCommentOutllet.addTarget(self, action: #selector(self.btnCommentAction), for: .touchUpInside)
            cell.setCell(objFeed: arrFeed[indexPath.row], arrID: arrLikedArr)
            return cell
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeNewsLikeTVCell", for: indexPath) as! HomeNewsLikeTVCell
            return cell
        }
    }
    
    override func didSelectRowAt(_ indexPath: IndexPath, tableView: UITableView) {
        //        let vc = FlowController().instantiateViewController(identifier: "NewsDetailVC", storyBoard: "NewsRC") as! NewsDetailVC
        //        let obj = arrVideoList[indexPath.section].videos?[indexPath.row]
        //        vc.newsID = String(obj?.id ?? 0)
        //        vc.isFromVideoList = true
        //        (self.actualController as! NewsVideoListVC).navigationController?.pushViewController(vc, animated: true)
        
    }
    override func getHeightForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        if tableView == (actualController as! HomeNewsFeedVC).tblFeed{
            return UITableView.automaticDimension
        }else{
            return 60
        }
    }
    
    //
    
    @objc func btnCommentAction (sender : UIButton){
        let obj = arrFeed[sender.tag]
        let vc = FlowController().instantiateViewController(identifier: "NewHomeCommentVC", storyBoard: "Home") as! NewHomeCommentVC
        vc.feedDetail = obj
        (actualController as! HomeNewsFeedVC).navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func btnMoreAction(sender : UIButton){
        
        let obj = arrFeed[sender.tag]
        feedId = String(obj.id!)
        if obj.isOwner == 0{
            (actualController as! HomeNewsFeedVC).viewDeletePost.isHidden = true
            (actualController as! HomeNewsFeedVC).viewEditPost.isHidden = true
        }else{
            (actualController as! HomeNewsFeedVC).viewDeletePost.isHidden = false
            (actualController as! HomeNewsFeedVC).viewEditPost.isHidden = false
            (actualController as! HomeNewsFeedVC).viewBackground.isHidden = false
            (actualController as! HomeNewsFeedVC).viewLike.isHidden = true
            (actualController as! HomeNewsFeedVC).viewMoreOption.isHidden = false
            
        }
      
        if obj.document_link == "" {
            (actualController as! HomeNewsFeedVC).viewDownload.isHidden = true
        }else{
            (actualController as! HomeNewsFeedVC).viewDownload.isHidden = false
            (actualController as! HomeNewsFeedVC).viewBackground.isHidden = false
            (actualController as! HomeNewsFeedVC).viewLike.isHidden = true
            (actualController as! HomeNewsFeedVC).viewMoreOption.isHidden = false
            documentLink = obj.document_link!
            
        }
    }
    
    @objc func btnlikeCountAction(sender : UIButton){
//        (actualController as! HomeNewsFeedVC).viewBackground.isHidden = false
//        (actualController as! HomeNewsFeedVC).viewLike.isHidden = false
//        (actualController as! HomeNewsFeedVC).viewMoreOption.isHidden = true
    }
   @objc func btnLikeunlikeAction(sender: UIButton) {
    let point = (self.actualController as! HomeNewsFeedVC).tblFeed.convert(sender.center, from: sender.superview!)

    if let wantedIndexPath = (actualController as! HomeNewsFeedVC).tblFeed.indexPathForRow(at: point) {
        let cell = (actualController as! HomeNewsFeedVC).tblFeed.cellForRow(at: wantedIndexPath) as! HomeNewsFeedTVCell
        let obj = arrFeed[sender.tag]
        if arrLikedArr.count>0 {
            for i in 0..<arrLikedArr.count {
                let objDict = arrLikedArr[i]
                if objDict.id == obj.id{
                    if objDict.isLiked == 0{
                        callWebserviceForLikeFeed(item: String(obj.id!), status: "1", like_type: "1"){ (likeCount) in
                            if likeCount.likes! > 1 {
                                cell.lblLikeCount.text = String(likeCount.likes!) + "Likes"
                                
                            }else{
                                if likeCount.likes! >= 0 {
                                cell.lblLikeCount.text = String(likeCount.likes!) + "Like"
                                }
                            }
                            self.arrLikedArr.remove(at: i)

                            self.arrLikedArr.insert(likeCount, at: i)
                            
                            cell.imgLike.image = #imageLiteral(resourceName: "likes_Blue")
                        }
                        //

                    }else{
                        callWebserviceForLikeFeed(item: String(obj.id!), status: "0", like_type: "1"){ (likeCount) in
                            if likeCount.likes! > 1{
                                cell.lblLikeCount.text = String(likeCount.likes!) + "Likes"
                            }else{
                                if likeCount.likes! >= 0 {
                                cell.lblLikeCount.text = String(likeCount.likes!) + "Like"
                                }
                            }
                            self.arrLikedArr.remove(at: i)
                            self.arrLikedArr.insert(likeCount, at: i)
                            cell.imgLike.image = #imageLiteral(resourceName: "Like_BlueBorder")
                        }
                    }
                }else{
                    if objDict.isLiked == 0{
                        callWebserviceForLikeFeed(item: String(obj.id!), status: "1", like_type: "1"){ (likeCount) in
                            if likeCount.likes! > 1{
                                cell.lblLikeCount.text = String(likeCount.likes!) + "Likes"
                                
                            }else{
                                if likeCount.likes! >= 0 {
                                cell.lblLikeCount.text = String(likeCount.likes!) + "Like"
                                }
                            }
                            self.arrLikedArr.append(likeCount)
                            cell.imgLike.image = #imageLiteral(resourceName: "likes_Blue")
                        }
                    }else{
                        callWebserviceForLikeFeed(item: String(obj.id!), status: "0", like_type: "1"){ (likeCount) in
                            if likeCount.likes! > 1{
                                cell.lblLikeCount.text = String(likeCount.likes!) + "Likes"
                            }else{
                                if likeCount.likes! >= 0 {
                                cell.lblLikeCount.text = String(likeCount.likes!) + "Like"
                                }
                            }
                            self.arrLikedArr.append(likeCount)
                            cell.imgLike.image = #imageLiteral(resourceName: "Like_BlueBorder")
                        }
                    }
                }
            }
            
        }else{
            if obj.isLiked == 0{
                callWebserviceForLikeFeed(item: String(obj.id!), status: "1", like_type: "1"){ (likeCount) in
                    if likeCount.likes! > 1{
                        cell.lblLikeCount.text = String(likeCount.likes!) + "Likes"
                        
                    }else{
                        if likeCount.likes! >= 0 {
                        cell.lblLikeCount.text = String(likeCount.likes!) + "Like"
                        }
                    }
                    self.arrLikedArr.append(likeCount)
                    cell.imgLike.image = #imageLiteral(resourceName: "likes_Blue")
                }
            }else{
                callWebserviceForLikeFeed(item: String(obj.id!), status: "0", like_type: "1"){ (likeCount) in
                    if likeCount.likes! > 1{
                        cell.lblLikeCount.text = String(likeCount.likes!) + "Likes"
                    }else{
                        if likeCount.likes! >= 0 {
                        cell.lblLikeCount.text = String(likeCount.likes!) + "Like"
                        }
                    }
                    self.arrLikedArr.append(likeCount)
                    cell.imgLike.image = #imageLiteral(resourceName: "Like_BlueBorder")
                }
            }
        }
    }
    
    
        
   //     if arrLikeId.contains(obj.id!){
//            callWebserviceForLikeFeed(item: String(obj.id!), status: "0", like_type: "1"){ (dict) in
//                if dict.likes == 1{
//                    cell.lblLikeCount.text = String(dict.likes!) + "Like"
//                }else{
//                    cell.lblLikeCount.text = String(dict.likes!) + "Likes"
//                }
//                cell.imgLike.image = #imageLiteral(resourceName: "Like_BlueBorder")
////                if self.arrLikeId.contains(obj.id!){
//                    let animals = self.arrLikeId.filter(){$0 != obj.id!}
//print(animals)
//   //
// //               }
//            }
//        }else{
//            callWebserviceForLikeFeed(item: String(obj.id!), status: "1", like_type: "1"){ (dict) in
//                if dict.likes == 1{
//                    cell.lblLikeCount.text = String(dict.likes!) + "Like"
//
//                }else{
//                    cell.lblLikeCount.text = String(dict.likes) + "Likes"
//                }
//                cell.imgLike.image = #imageLiteral(resourceName: "likes_Blue")
//                self.arrLikeId.append(obj.id!)
//            }
//        }
  //  }
    }
    @objc func btnSeeMoreAction(sender: UIButton){
        
        let point = (self.actualController as! HomeNewsFeedVC).tblFeed.convert(sender.center, from: sender.superview!)

        if let wantedIndexPath = (actualController as! HomeNewsFeedVC).tblFeed.indexPathForRow(at: point) {
            let cell = (actualController as! HomeNewsFeedVC).tblFeed.cellForRow(at: wantedIndexPath) as! HomeNewsFeedTVCell
            if sender.isSelected{
                sender.isSelected = false
                cell.lblDescription.numberOfLines = 2
                sender.setTitle("See More", for: .normal)

                
            }else{
                sender.isSelected = true
                cell.lblDescription.numberOfLines = 0
                sender.setTitle("See less", for: .normal)
            }
            (actualController as! HomeNewsFeedVC).tblFeed.beginUpdates()
            (actualController as! HomeNewsFeedVC).tblFeed.endUpdates()
        }
        
        
    }
    @objc func btnPlayVideoAction(sender:UIButton){
        let objFeed = arrFeed[sender.tag]
        let objLink = (objFeed.video_link)!

        guard let url = URL(string: objLink) else { return }
        UIApplication.shared.open(url)
    }
    
    
    func callWebserviceForFeed(page:String) {
        GlobalObj.displayLoader(true, show: true)
        
        APIClient.webserviceForNewHomeFeed(limit: "10", page: page) { (result) in
            
            if let respCode = result.resp_code{
                GlobalObj.displayLoader(true, show: false)
                if respCode == 200{
                    if let arrDate = result.data{
                        if (self.actualController as! HomeNewsFeedVC).checkPagination == "get" {
                            self.arrFeed.removeAll()
                            for objData in arrDate {
                                self.arrFeed.append(objData)
                            }
                            if self.arrFeed.count>0 {
                                (self.actualController as! HomeNewsFeedVC).tblFeed.reloadData()
                            }
                        }else{
                            
                            for objData in arrDate {
                                self.arrFeed.append(objData)
                            }
                        }
                        if arrDate.count>0 {
                            (self.actualController as! HomeNewsFeedVC).tblFeed.reloadData()
                        }
                    }else{
                        GlobalObj.displayLoader(true, show: false)
                        
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
    func callWebserviceFroDeleteComment(feedId:String) {
        GlobalObj.displayLoader(true, show: true)
        APIClient.wevserviceForNewHomeFeedDelete(feed: feedId) { (result) in
            print(result)
            let rslt = result as! NSDictionary
            if let msg = rslt["message"] as? NSString{
                if msg == "Feed deleted"{
                    (self.actualController as! HomeNewsFeedVC).viewBackground.isHidden = true
                    (self.actualController as! HomeNewsFeedVC).currentPage = 1
                    (self.actualController as! HomeNewsFeedVC).checkPagination = "get"
                    self.callWebserviceForFeed(page: String((self.actualController as! HomeNewsFeedVC).currentPage))
                }
            }
            GlobalObj.displayLoader(true, show: false)
        }
    }
}
