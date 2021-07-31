//
//  OneandonlydayVM.swift
//  MECA
//
//  Created by Macbook  on 05/07/21.
//

import UIKit

class OneandonlydayVM: BaseTableViewVM {
    let identifierItemCell = "OneandonlyTVCell"
    var arrList : [oneandonlyvalues] = []
    override init(controller: UIViewController?) {
        super.init(controller: controller)
        baseHeaderTableViewHeight = 70
    }
    override func getNumbersOfRows(in section: Int) -> Int {
        return arrList.count
    }
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierItemCell, for: indexPath) as! OneandonlyTVCell
        let objFeed = arrList[indexPath.row]
        
        cell.setCelloneandonlay(feed: objFeed)
        return cell

    }
    override func getHeightForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        return 50
    }
    override func getHeightForHeaderAt(_ section: Int, tableView: UITableView) -> CGFloat {
    return 50
    }
    override func getBaseTableHeaderViewFor(_ section: Int, tableView: UITableView) -> UIView? {

        let headerView:UIView =  UIView()
        headerView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        let label = UILabel(frame: CGRect(x: 16, y: 15, width: 200, height: 24))
        label.text = "One & Only day"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        headerView.addSubview(label)

        
            return headerView

}
    
    override func didSelectRowAt(_ indexPath: IndexPath, tableView: UITableView) {
        let story = UIStoryboard(name: "Category", bundle:nil)
        let obj = arrList[indexPath.row]
        let vc = story.instantiateViewController(withIdentifier: "oneandonlydetailvc") as! oneandonlydetailVC
        vc.eventID = String(obj.id ?? 0)
        (actualController as! HomeVC).navigationController?.pushViewController(vc, animated: true)
    }
    
    func OneandonlydayApicall()  {
       
        let param : [String:Any] = [
                                    "type" : 0]//"keyword" : "test"
        print(param)
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForoneandonlylistapi(limit: "10",page: "1",params: param) { (result) in
            print("oneandonly api response \(result)")
            if let repo = result.resp_code{
                GlobalObj.displayLoader(true, show: false)
               
                if repo == 200 {
                    
                    if let arrList = result.data{
                        print(arrList)
                        if arrList.count > 0  {
                            self.arrList.removeAll()
                        }
                        for obj in arrList {
                            self.arrList.append(obj)
                        }
                        
                    }
                    (self.actualController as! HomeVC).tblView.reloadData()
                }else{
                    GlobalObj.displayLoader(true, show: false)
                }
            }else{
                
                
                GlobalObj.displayLoader(true, show: false)
            }
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
