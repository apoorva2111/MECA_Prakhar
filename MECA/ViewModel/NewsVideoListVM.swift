//
//  NewsVideoListVM.swift
//  MECA
//

import UIKit


class NewsVideoListVM: BaseTableViewVM {
   
   var arrVideoList = [VideoListData]()
    
    override init(controller: UIViewController?) {
        super.init(controller: controller)
    }
    override func getNumbersOfSections()-> Int{
        return self.arrVideoList.count
    }
 
    override func getNumbersOfRows(in section: Int) -> Int {
        return self.arrVideoList[section].videos!.count
        
    }
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCatTVCell", for: indexPath) as! NewsCatTVCell
        let obj = arrVideoList[indexPath.section].videos![indexPath.row]
        cell.btnPlayOutlet.tag = indexPath.row
        cell.btnPlayOutlet.addTarget(self, action: #selector(self.playVideoAction), for: .touchUpInside)

        cell.setCellVideoNews(objList: obj)
        return cell
        
    }
    override func getHeightForHeaderAt(_ section: Int, tableView: UITableView) -> CGFloat {
    return 50
    }
    override func getBaseTableHeaderViewFor(_ section: Int, tableView: UITableView) -> UIView? {

        let headerView:UIView =  UIView()
        headerView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        let label = UILabel(frame: CGRect(x: 16, y: 15, width: 200, height: 20))
        let obj = arrVideoList[section].title
        label.text = obj
        label.textColor = .black
        label.font = UIFont.init(name: "SFPro-Bold", size: 22)
        headerView.addSubview(label)

        
            return headerView

}
    override func didSelectRowAt(_ indexPath: IndexPath, tableView: UITableView) {
        let vc = FlowController().instantiateViewController(identifier: "NewsDetailVC", storyBoard: "NewsRC") as! NewsDetailVC
        let obj = arrVideoList[indexPath.section].videos?[indexPath.row]
        vc.newsID = String(obj?.id ?? 0)
        vc.isFromVideoList = true
        (self.actualController as! NewsVideoListVC).navigationController?.pushViewController(vc, animated: true)

    }
    override func getHeightForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        return 300
    }
   

    @objc func playVideoAction(sender: UIButton){
        let arrList = arrVideoList[sender.tag].videos
        let obj = arrList?[sender.tag]
        if let videoURL = obj?.video_link{
            guard let url = URL(string: videoURL) else { return }
            UIApplication.shared.open(url)
        }
    }
    //Call Webservice
    func callWebserviceForVideo(keyword:String) {
        GlobalObj.displayLoader(true, show: true)
        let param : [String:Any] = ["keyword":keyword]
        APIClient.webserviceForNewsVideoList(params: param) { (result) in
            GlobalObj.displayLoader(true, show: false)
            if let respCode = result.resp_code{
                
                if respCode == 200{
                    if self.arrVideoList.count>0{
                        self.arrVideoList.removeAll()
                    }
                    if let objDate = result.data {
                        for obj in objDate {
                            self.arrVideoList.append(obj)
                        }
                        
                        if self.arrVideoList.count>0{
                            (self.actualController as! NewsVideoListVC).tblVideoList.delegate = (self.actualController as! NewsVideoListVC).self
                            (self.actualController as! NewsVideoListVC).tblVideoList.dataSource = (self.actualController as! NewsVideoListVC).self
                            (self.actualController as! NewsVideoListVC).tblVideoList.reloadData()
                            (self.actualController as! NewsVideoListVC).tblVideoList.isHidden = false
                        }else{
                            (self.actualController as! NewsVideoListVC).tblVideoList.isHidden = true
                        }
                    }else{
                        GlobalObj.displayLoader(true, show: false)

                    }
                }else{
                    GlobalObj.displayLoader(true, show: false)

                }
            }
        }
    }
}
