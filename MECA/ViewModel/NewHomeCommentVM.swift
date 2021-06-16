//
//  NewHomeCommentVM.swift
//  MECA

import UIKit

class NewHomeCommentVM: BaseTableViewVM {
    var arrCommentList = [NewHomeCommentData]()
    
    override init(controller: UIViewController?) {
        super.init(controller: controller)
        callWebserviceForCommentList(feed: String((actualController as! NewHomeCommentVC).feedDetail.id!), limit: "10", page: "1")
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
            
            cell.viewComment.isHidden = true
            cell.viewCommentHeightConstraint.constant = 0
            cell.lblLine.isHidden = true
            cell.setCell(objFeed:(actualController as! NewHomeCommentVC).feedDetail)
                return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewHomeCommentTVCell", for: indexPath) as! NewHomeCommentTVCell
            let objComment = arrCommentList[indexPath.row - 1] 
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
                    if let arrData = result.data{
                        print(arrData)
                        self.arrCommentList = arrData
                        (self.actualController as! NewHomeCommentVC).tbllComment.reloadData()
                    }
                }
            }
        }
    }
}
