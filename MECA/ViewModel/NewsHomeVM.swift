//
//  NewsHomeVM.swift
//  MECA
//
//  Created by Apoorva Gangrade on 28/05/21.
//

import UIKit

class NewsHomeVM: BaseTableViewVM {
    var newsData: NewsData?
    var arrlist = [NSDictionary]()
    var arrNewsCat = [News_MEBITCat]()
    
    
    override init(controller: UIViewController?) {
        super.init(controller: controller)
    }
    override func getNumbersOfSections()-> Int{
        return 2
    }
 
    override func getNumbersOfRows(in section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return arrlist.count
        }
    }
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsHomePickTVCell", for: indexPath) as! NewsHomePickTVCell
            if self.newsData != nil{
                cell.setCell(newsObject: self.newsData!)
            }
            cell.btnshowAllPick.addTarget(self, action: #selector(didTapShowAllPick), for: .touchUpInside)

            return cell
        }else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "LatestNewsTVCell", for: indexPath) as! LatestNewsTVCell
            if self.newsData != nil{
                cell.setCell(dict: arrlist[indexPath.row])
            }
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
        if indexPath.section == 0 {
            return 300

        }else{
            return 349

        }
    }
    
    @objc func didTapShowAllPick(sender:UIButton) {
        let vc = FlowController().instantiateViewController(identifier: "NewsListVC", storyBoard: "NewsRC")
        (actualController as! NewsHomeVC).navigationController?.pushViewController(vc, animated: true)

    }
    
    
    func callWebserviceForNewsHome() {
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForNewsHome { (result) in
            if let respCode = result.resp_code{
                GlobalObj.displayLoader(true, show: false)
                if respCode == 200{
                    if let arrData = result.data{
                        
                        self.newsData = arrData
                        
                        
                        if let market = arrData.market_latest_news{
                            
                            var items = [String:AnyObject]()
                            var arrTemp = [[String:Any]]()
                            for objMarket in market {
                                var dict = [String: Any]()
                                dict["catTitle"] = "Market Latest News"//"MARKET LATEST NEWS"

                                dict["category"] = objMarket.category!
                                dict["id"] = objMarket.id!
                                dict["title"] = objMarket.title!
                                dict["cover_image"] = objMarket.cover_image!
                                dict["created_at"] = objMarket.created_at!
                                dict["writer_name"] = objMarket.writer_name!
                                dict["plain_description"] = objMarket.plain_description!
                                arrTemp.append(dict)
                                
                            }
                            items["items"] = arrTemp as AnyObject
                        //    print(items)
                          //  self.arrlist.append(items as NSDictionary)
                            self.arrlist.insert(items as NSDictionary, at: 0)

                        }
                        
                        if let toyota = arrData.toyota_latest_news{
                            
                            var items = [String:AnyObject]()
                            var arrTemp = [[String:Any]]()
                            for objToyota in toyota {
                               
                                var dict = [String: Any]()
                                dict["catTitle"] = "Toyota Latest News" //"TOYOTA LATEST NEWS"
                                dict["category"] = objToyota.category!
                                dict["id"] = objToyota.id!
                                dict["title"] = objToyota.title!
                                dict["cover_image"] = objToyota.cover_image!
                                dict["created_at"] = objToyota.created_at!
                                dict["writer_name"] = objToyota.writer_name!
                                dict["plain_description"] = objToyota.plain_description!
                                arrTemp.append(dict)
                                
                            }
                            items["items"] = arrTemp as AnyObject
                          //  self.arrlist.append(items as NSDictionary)
                            self.arrlist.insert(items as NSDictionary, at: 1)

                        }
                        
                        if let video = arrData.videos{
                            
                            var items = [String:AnyObject]()
                            var arrTemp = [[String:Any]]()
                            for objVideo in video {
                               
                                var dict = [String: Any]()
                                dict["catTitle"] = "Videos"
                                dict["category"] = objVideo.category!
                                dict["id"] = objVideo.id!
                                dict["title"] = objVideo.title!
                                dict["cover_image"] = objVideo.cover_image!
                                dict["created_at"] = objVideo.created_at!
                                dict["writer_name"] = objVideo.writer_name!
                                dict["tags"] = objVideo.tags
                                dict["video_link"] = objVideo.video_link
                                dict["plain_description"] = objVideo.plain_description!
                                arrTemp.append(dict)
                               
                            }
                            items["items"] = arrTemp as AnyObject
                                //   self.arrlist.append(items as NSDictionary)
                            self.arrlist.insert(items as NSDictionary, at: 2)
                        }
                    }
                    
                    print(self.arrlist)
                    (self.actualController as! NewsHomeVC).tblList.reloadData()
                }else{
                    GlobalObj.displayLoader(true, show: false)

                }
            }
            
            GlobalObj.displayLoader(true, show: false)

        }
        
    }
    
    //Apicalling
    func callWebserviceNewsCategory() {
        GlobalObj.displayLoader(true, show: true)

        APIClient.webserviceForCategoryList { (result) in
            
            if let respCode = result.resp_code{
             
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)

                    if let arrData = result.data{
                        if self.arrNewsCat.count>0{
                            self.arrNewsCat.removeAll()
                        }
                        if arrData.news!.count>0{
                            self.arrNewsCat = arrData.news!
                        }
                        self.callWebserviceForNewsHome()
                    }
                    (self.actualController as! NewsHomeVC).typeCollection.reloadData()
                }else{
                    self.callWebserviceForNewsHome()
                    GlobalObj.displayLoader(true, show: false)

                }
            }else{
                self.callWebserviceForNewsHome()
                GlobalObj.displayLoader(true, show: false)

            }
            

        }
        
    }
    
    //NewsListWithCat
    func callWebserviceForNewListWithCat(keyword:String,category:String,subcategory:String,page:String)  {
        GlobalObj.displayLoader(true, show: true)
        let param : [String:Any] = ["keyword":keyword,
                                    "category":category,
                                    "subcategory":subcategory,
                                    "tags":[]]
        print(param)
        APIClient.webserviceForNewsListWithCat(limit: "10", page: page, params: param) { (result) in
            print(result.resp_code)
            print(result.data)
            GlobalObj.displayLoader(true, show: false)
            /*if let repo = result.resp_code{
             GlobalObj.displayLoader(true, show: false)
            
             
             if repo == 200 {
                 if self.checkPagination == "get"{
                     self.arrList.removeAll()
                     
                     if let arrList = result.data{
                         print(arrList)
                         
                         for obj in arrList {
                             self.arrList.append(obj)
                         }
                         if self.arrList.count>0 {
                             self.varsdgslistTblView.reloadData()
                             self.varsdgslistTblView.isHidden = false
                         }else{
                             self.varsdgslistTblView.isHidden = true

                         }
                     }
                 }else{
                     
                     if let arrList = result.data{
                         print(arrList)
                         
                         for obj in arrList {
                             self.arrList.append(obj)
                         }
                         if arrList.count>0 {
                             self.varsdgslistTblView.reloadData()
                             self.varsdgslistTblView.isHidden = false
                         }
                     }
                 }
                 
                 
             }else{
                 GlobalObj.displayLoader(true, show: false)
             }
         }else{
             
             self.showToast(message: "Somwthing Went Wrong")
             GlobalObj.displayLoader(true, show: false)
         }*/
        }
    }
}

