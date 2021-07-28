

import UIKit
import SDWebImage
class NewsDetailVM: BaseTableViewVM {
    
    var newsData : NewsDetail_Data?
    var videoInfo : VideoInfoData?
    
    
    override init(controller: UIViewController?) {
        super.init(controller: controller)
    }
    override func getNumbersOfSections()-> Int{
        return 1
    }
    
    override func getNumbersOfRows(in section: Int) -> Int {
        return 4
        
    }
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        if (actualController as! NewsDetailVC).isFromVideoList{
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsImageTVCell", for: indexPath) as! NewsImageTVCell
                cell.btnPlayOutlet.isHidden = false
                cell.btnPlayOutlet.addTarget(self, action: #selector(btnPlayVideo), for: .touchUpInside)
                cell.btnPlayOutlet.tag = indexPath.row
                if videoInfo != nil{
                    cell.setNewsVideoData(grData: videoInfo!)
                }
                
                return cell
            }else if indexPath.row == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewContentTVCell", for: indexPath) as! NewContentTVCell
                if videoInfo != nil{
                    cell.btnReadMoreOutlet.addTarget(self, action: #selector(didTapReadMore), for: .touchUpInside)
                    
                    cell.setNewsVideoData(grData: videoInfo!)
                }
                return cell
            }else if indexPath.row == 2{
                let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentTVCell", for: indexPath) as! DocumentTVCell
                cell.viewController = (actualController as? NewsDetailVC).self
                if videoInfo != nil{
                    cell.setNewsVideoData(grData: videoInfo!)
                }
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "RelatedNewsTVCell", for: indexPath) as! RelatedNewsTVCell
                if videoInfo != nil{
                    cell.setNewsVideoData(grData: videoInfo!)
                }
                return cell
            }
        }else{
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsImageTVCell", for: indexPath) as! NewsImageTVCell
                cell.btnPlayOutlet.isHidden = true
                if newsData != nil{
                    cell.setNewsImgData(grData: newsData!)
                }
                
                return cell
            }else if indexPath.row == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewContentTVCell", for: indexPath) as! NewContentTVCell
                if newsData != nil{
                    cell.btnReadMoreOutlet.addTarget(self, action: #selector(didTapReadMore), for: .touchUpInside)
                    
                    cell.setNewsContentData(grData: newsData!)
                }
                return cell
            }else if indexPath.row == 2{
                let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentTVCell", for: indexPath) as! DocumentTVCell
                cell.viewController = (actualController as? NewsDetailVC).self
                if newsData != nil{
                    cell.setNewsDocumentData(grData: newsData!)
                }
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "RelatedNewsTVCell", for: indexPath) as! RelatedNewsTVCell
                if newsData != nil{
                    cell.viewController = (actualController as? NewsDetailVC).self
                    cell.setNewsRelatedNewsData(grData: newsData!)
                }
                return cell
            }
        }
    }
    override func didSelectRowAt(_ indexPath: IndexPath, tableView: UITableView) {
        
    }
    override func getHeightForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        if (actualController as! NewsDetailVC).isFromVideoList{
            if indexPath.row == 0{
                return UITableView.automaticDimension//370
            }else  if indexPath.row == 1{
                if BoolValue.isFromNewsContent{
                    return UITableView.automaticDimension
                }else{
                    return 169
                }
            }else  if indexPath.row == 2{
                if videoInfo?.documents?.count == 0 {
                    return 0
                }else{
                    return UITableView.automaticDimension
                }
                
            }else{
                if videoInfo?.related?.count == 0{
                    return 0
                }else{
                    return 376
                    
                }
            }
        }else{
            if indexPath.row == 0{
                return UITableView.automaticDimension//370
            }else  if indexPath.row == 1{
                if BoolValue.isFromNewsContent{
                    
                    return UITableView.automaticDimension
                }else{
                    return 169
                }
            }else  if indexPath.row == 2{
                if newsData?.documents?.count == 0 {
                    return 0
                }else{
                    return UITableView.automaticDimension
                }
                
            }else{
                if newsData?.related?.count == 0{
                    return 0
                }else{
                    return 376
                    
                }
            }
        }
       
    }
    @objc func didTapReadMore(sender:UIButton) {
        if sender.isSelected{
            sender.setTitle("Read More", for: .normal)
            sender.isSelected = false
            BoolValue.isFromNewsContent = false
            (self.actualController as! NewsDetailVC).tblNewsDetail.reloadData()
        }else{
            sender.isSelected = true
            sender.setTitle("Read Less", for: .normal)
            BoolValue.isFromNewsContent = true
            (self.actualController as! NewsDetailVC).tblNewsDetail.reloadData()
        }
        
    }
    @objc func btnPlayVideo(sender:UIButton) {
        if let videoURL = videoInfo?.video_link{
            guard let url = URL(string: videoURL) else { return }
            UIApplication.shared.open(url)
        }


    }
    
    //Call Webservice
    func callWebserviceFroNewInfo(newsId:String) {
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForNewsInfo(newsId: newsId) { (result) in
            GlobalObj.displayLoader(true, show: false)
            
            if let respCode = result.resp_code{
                
                if respCode == 200{
                    
                    if let objDate = result.data {
                        self.newsData = objDate
                        GlobalObj.displayLoader(true, show: false)
                        (self.actualController as! NewsDetailVC).tblNewsDetail.isHidden = false
                        (self.actualController as! NewsDetailVC).tblNewsDetail.reloadData()
                        
                        if (self.actualController as! NewsDetailVC).tblNewsDetail.numberOfRows(inSection: 0) != 0 {
                            (self.actualController as! NewsDetailVC).tblNewsDetail.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                        }
                    }else{
                        (self.actualController as! NewsDetailVC).tblNewsDetail.isHidden = false
                        
                        GlobalObj.displayLoader(true, show: false)
                    }
                }
                
                GlobalObj.displayLoader(true, show: false)
            }
        }
    }
    
    func callWebserviceFroVideoInfo(videoId:String) {
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForNewsVideoInfo(videoId: videoId) { (result) in
            GlobalObj.displayLoader(true, show: false)
            
            if let respCode = result.resp_code{
                
                if respCode == 200{
                    
                    if let objData = result.data {
                        
                        self.videoInfo = objData
                        
                        GlobalObj.displayLoader(true, show: false)
                        (self.actualController as! NewsDetailVC).tblNewsDetail.isHidden = false
                        (self.actualController as! NewsDetailVC).tblNewsDetail.reloadData()
                        
                        if (self.actualController as! NewsDetailVC).tblNewsDetail.numberOfRows(inSection: 0) != 0 {
                            (self.actualController as! NewsDetailVC).tblNewsDetail.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                        }
                      
                        
                    }else{
                        (self.actualController as! NewsDetailVC).tblNewsDetail.isHidden = false
                        
                        GlobalObj.displayLoader(true, show: false)
                    }
                    
                }
                
                GlobalObj.displayLoader(true, show: false)
                
            }
        }
    }
}
