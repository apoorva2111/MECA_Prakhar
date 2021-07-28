//
import UIKit

class NewsHomeVM: BaseTableViewVM {
    var newsData: NewsData?
    var arrlist = [NSDictionary]()
    var arrNewsCat = [News_MEBITCat]()
    var arrCatList = [NewsListData]()
    var arrModule = [Modules]()

    var video = 0
    var news = 0
    var crices = 0
    
    
    
    
    override init(controller: UIViewController?) {
        super.init(controller: controller)
    }
    override func getNumbersOfSections()-> Int{
        if BoolValue.isClickOnCategory{
            return 1
        }else{
            return 2
        }
    }
 
    override func getNumbersOfRows(in section: Int) -> Int {
        if BoolValue.isClickOnCategory{
            return arrCatList.count
        }else{
            if section == 0{
                return 1
            }else{
                return arrlist.count
            }
        }
    }
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        if BoolValue.isClickOnCategory{
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCatTVCell", for: indexPath) as! NewsCatTVCell
            let obj = arrCatList[indexPath.row]
            cell.setCell(objList: obj)
            return cell
        }else{
            
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsHomePickTVCell", for: indexPath) as! NewsHomePickTVCell
                cell.viewController = (self.actualController as! NewsHomeVC).self

                if self.newsData != nil{
                    cell.setCell(newsObject: self.newsData!)
                }
                cell.btnCreateNew.addTarget(self, action: #selector(didTapCreateNew), for: .touchUpInside)
                cell.btnshowAllPick.addTarget(self, action: #selector(didTapShowAllPick), for: .touchUpInside)
                cell.btnshowAllPick.tag = indexPath.row
                return cell
            }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LatestNewsTVCell", for: indexPath) as! LatestNewsTVCell
                if self.newsData != nil{
                    cell.viewController = (self.actualController as! NewsHomeVC).self
                    cell.btnLatestNewShowAll.tag = indexPath.row
                    cell.btnLatestNewShowAll.addTarget(self, action: #selector(didTapLatestNewsShowAllPick), for: .touchUpInside)
                    cell.setCell(dict: arrlist[indexPath.row])
                }
                return cell
            }
        }
    }
    override func didSelectRowAt(_ indexPath: IndexPath, tableView: UITableView) {
        if BoolValue.isClickOnCategory{
            let vc = FlowController().instantiateViewController(identifier: "NewsDetailVC", storyBoard: "NewsRC") as! NewsDetailVC
            let obj = arrCatList[indexPath.row]
            vc.newsID = String(obj.id ?? 0)
            vc.isFromVideoList = false
            (self.actualController as! NewsHomeVC).navigationController?.pushViewController(vc, animated: true)
            
        }else{
            
        }
    }
    
    override func getHeightForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        if BoolValue.isClickOnCategory{
            return 300
        }else{
            if indexPath.section == 0 {
                return 300

            }else{
                return 349

            }
        }
    }
    
    @objc func didTapShowAllPick(sender:UIButton) {
        let vc = FlowController().instantiateViewController(identifier: "NewsListVC", storyBoard: "NewsRC")as!NewsListVC
        vc.arrOurPick = self.newsData!.ourpicks!
      //  print(self.newsData!.ourpicks![sender.tag].category ?? "")
        BoolValue.isClickOnCategory = false
        vc.clickOn = "Ourpick"
        vc.category = ""
        (actualController as! NewsHomeVC).navigationController?.pushViewController(vc, animated: true)

    }
    @objc func didTapLatestNewsShowAllPick(sender:UIButton) {
        let objList = arrlist[sender.tag]
        print(objList)
        BoolValue.isClickOnCategory = false
        let arr = objList["items"] as? NSArray
        let obj = arr?[0] as? NSDictionary

        let objVideo = obj?["catTitle"] as! String
        if objVideo   == "Videos"{
            let vc = FlowController().instantiateViewController(identifier: "NewsVideoListVC", storyBoard: "NewsRC")as!NewsVideoListVC
            (actualController as! NewsHomeVC).navigationController?.pushViewController(vc, animated: true)

        }else{
            let vc = FlowController().instantiateViewController(identifier: "NewsListVC", storyBoard: "NewsRC")as!NewsListVC
            
            vc.dictLatestNewslist = arrlist[sender.tag]
            
            vc.clickOn = "LatestNews"
            vc.category = obj?["category"] as! String
            (actualController as! NewsHomeVC).navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func didTapCreateNew(sender:UIButton) {
        // create an actionSheet
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        // create an action
        let newsAction: UIAlertAction = UIAlertAction(title: "News", style: .default) { action -> Void in

            let vc = FlowController().instantiateViewController(identifier: "AddNewsViewController", storyBoard: "Home")as! AddNewsViewController
            print(self.news)
            vc.newsHomeCreate = "News"
            vc.module = self.news
            (self.actualController as! NewsHomeVC).navigationController?.pushViewController(vc, animated: true)
        }

        let videoAction: UIAlertAction = UIAlertAction(title: "Video", style: .default) { action -> Void in

            let vc = FlowController().instantiateViewController(identifier: "AddNewsViewController", storyBoard: "Home")as! AddNewsViewController
            print(self.video)
            vc.newsHomeCreate = "Video"
            vc.module = self.video
            (self.actualController as! NewsHomeVC).navigationController?.pushViewController(vc, animated: true)
        }
       
        let crisisAction: UIAlertAction = UIAlertAction(title: "Crisis", style: .default) { action -> Void in

            let vc = FlowController().instantiateViewController(identifier: "AddNewsViewController", storyBoard: "Home")as! AddNewsViewController
            print(self.crices)
            vc.newsHomeCreate = "Crisis"
            vc.module = self.crices
            (self.actualController as! NewsHomeVC).navigationController?.pushViewController(vc, animated: true)
        }

        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }

        // add actions
        actionSheetController.addAction(newsAction)
        actionSheetController.addAction(videoAction)
        actionSheetController.addAction(crisisAction)
        actionSheetController.addAction(cancelAction)

        (actualController as! NewsHomeVC).present(actionSheetController, animated: true) {
            print("option menu presented")
        }
    }
    
    
    func callWebserviceForNewsHome() {
        GlobalObj.displayLoader(true, show: true)
        let param : [String:Any] = ["keyword":(actualController as! NewsHomeVC).txtSearch.text ?? ""]
        APIClient.webserviceForNewsHome(param: param) { (result) in
            if let respCode = result.resp_code{
                GlobalObj.displayLoader(true, show: false)
                if respCode == 200{
                    if let arrData = result.data{
                        
                        self.newsData = arrData
                        if self.arrlist.count > 0{
                            self.arrlist.removeAll()
                        }
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
                    if self.arrlist.count>0{
                        (self.actualController as! NewsHomeVC).tblList.delegate = (self.actualController as! NewsHomeVC).self
                        (self.actualController as! NewsHomeVC).tblList.dataSource = (self.actualController as! NewsHomeVC).self

                        (self.actualController as! NewsHomeVC).tblList.isHidden = false
                        (self.actualController as! NewsHomeVC).tblList.reloadData()
                    }else{
                          (self.actualController as! NewsHomeVC).tblList.delegate = nil
                        (self.actualController as! NewsHomeVC).tblList.dataSource = nil

                        (self.actualController as! NewsHomeVC).tblList.isHidden = true
                    }
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
                        if arrData.modules!.count > 0{
                            self.arrModule = arrData.modules!
                            for obj in self.arrModule {
                                if obj.module == "News"{
                                    self.news = obj.id!
                                }else if obj.module == "Videos"{
                                    self.video = obj.id!
                                }else if obj.module == "Crisis"{
                                    self.crices = obj.id!
                                }
                            }
                        }
                        self.callWebserviceForNewsHome()

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
    }
    //NewsListWithCat
    func callWebserviceForNewListWithCat(keyword:String,category:String,subcategory:String,page:String)  {
    arrlist.removeAll()
        GlobalObj.displayLoader(true, show: true)
        let param : [String:Any] = ["keyword":keyword,
                                    "category":category,
                                    "subcategory":subcategory]
        print(param)
        APIClient.webserviceForNewsListWithCat(limit: "10", page: page, params: param) { (result) in
            GlobalObj.displayLoader(true, show: false)
            if let repo = result.resp_code{
             GlobalObj.displayLoader(true, show: false)
            
//
             if repo == 200 {
                 if (self.actualController as! NewsHomeVC).checkPagination == "get"{
                    self.arrCatList.removeAll()

                     if let arrList = result.data{
                         print(arrList)

                         for obj in arrList {
                             self.arrCatList.append(obj)
                         }
                         if self.arrCatList.count>0 {
                            BoolValue.isClickOnCategory = true
                            (self.actualController as! NewsHomeVC).tblList.register(UINib.init(nibName: "NewsCatTVCell", bundle: nil), forCellReuseIdentifier: "NewsCatTVCell")
                            (self.actualController as! NewsHomeVC).tblList.delegate = (self.actualController as! NewsHomeVC).self
                            (self.actualController as! NewsHomeVC).tblList.dataSource = (self.actualController as! NewsHomeVC).self

                            (self.actualController as! NewsHomeVC).tblList.reloadData()
                            (self.actualController as! NewsHomeVC).tblList.isHidden = false
                         }else{
                            (self.actualController as! NewsHomeVC).tblList.delegate = nil
                            (self.actualController as! NewsHomeVC).tblList.dataSource = nil
                            (self.actualController as! NewsHomeVC).tblList.isHidden = true

                         }
                     }
                 }else{
//
                     if let arrList = result.data{
                         print(arrList)

                         for obj in arrList {
                             self.arrCatList.append(obj)
                         }
                        if arrList.count>0 {
                            (self.actualController as! NewsHomeVC).tblList.reloadData()
                            (self.actualController as! NewsHomeVC).tblList.isHidden = false
                         }
                     }
                 }
                 
                 
             }else{
                 GlobalObj.displayLoader(true, show: false)
             }
         }else{

            (self.actualController as! NewsHomeVC).showToast(message: "Somwthing Went Wrong")
             GlobalObj.displayLoader(true, show: false)
         }
        }
    }

}
