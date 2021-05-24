//
//  CalenderVM.swift
//  MECA
//
//  Created by Macbook  on 18/05/21.
//


import UIKit
import AVFoundation

class CalenderVM: ScheduleTableViewVM {
    let identifierItemCell = "ScheduleTableCell"
    
    var arrcalendarFeed:[calendardata] = []
    override init(controller: UIViewController?) {
        super.init(controller: controller)
        baseHeaderTableViewHeight = 60
    }
    
    override func getNumbersOfRows(in section: Int) -> Int {
        return arrcalendarFeed.count
    }
    
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierItemCell, for: indexPath) as! ScheduleTableCell
        let objFeed = arrcalendarFeed[indexPath.row]
        cell.setCellcalendarvalue(feed: objFeed)
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
        headerView.backgroundColor = UIColor.white
        let label = UILabel(frame: CGRect(x: 16, y: 15, width: 200, height: 20))
        label.text = "Schedule"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        headerView.addSubview(label)

        
            return headerView

}
  
    func callwedservicecalendardata(month: String, year: String)
    {
        GlobalObj.displayLoader(true, show: true)
        
        APIClient.webserviceForCalendar(month: month, year: year){ (result) in
            print("result\(result)")
            if let respCode = result.resp_code{
                
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)

                    if let arrDate = result.data{
                        if self.arrcalendarFeed.count>0{
                            self.arrcalendarFeed.removeAll()
                        }
                        if arrDate.count>0{
                            self.arrcalendarFeed = arrDate

                        }
                    }
                    (self.actualController as! CalenderVC).scheduletblview.reloadData()
                }else{
                    GlobalObj.displayLoader(true, show: false)

                }
            }
            
            GlobalObj.displayLoader(true, show: false)

        }
    }
}
