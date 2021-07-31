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
    var calendarselecteddate = ""
    var arrcalendarFeed:[calendardata] = []
    var arrcalendarselected:[calendardata] = []
    override init(controller: UIViewController?) {
        super.init(controller: controller)
        baseHeaderTableViewHeight = 60
    }
    
    override func getNumbersOfRows(in section: Int) -> Int {
        
        if calendarselecteddate == ""  {
            return arrcalendarFeed.count
        }else{
            if (actualController as! CalenderVC).isDateSelect{
                let results = arrcalendarFeed.filter { ($0.start_date ?? "") == calendarselecteddate   }
                print("getNumbersOfRows\(results)")
                arrcalendarselected = results
                return arrcalendarselected.count
            }else{
                return arrcalendarFeed.count

            }
        }
    }
    
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierItemCell, for: indexPath) as! ScheduleTableCell
        
        if calendarselecteddate == "" {
            let objFeed = arrcalendarFeed[indexPath.row]
            cell.setCellcalendarvalue(feed: objFeed)
            cell.schedulebtn.tag = indexPath.row
            cell.schedulebtn.addTarget(self, action: #selector(self.schedulebtnAction), for: .touchUpInside)
        }else{
            if (actualController as! CalenderVC).isDateSelect{
            cell.FromCalendarVC = (actualController as? CalenderVC).self
            let objFeed = arrcalendarselected[indexPath.row]
            if calendarselecteddate == objFeed.start_date {
                print("obj\(objFeed)")
                cell.setCellSelectcalendarvalue(feed: objFeed)
                cell.schedulebtn.tag = indexPath.row
                cell.schedulebtn.addTarget(self, action: #selector(self.schedulebtnAction), for: .touchUpInside)
            }else{
              //  callendararrLis
//                print((self.actualController as? CalenderVC).callendararrList)
                let objFeed = arrcalendarFeed[indexPath.row]
                cell.setCellcalendarvalue(feed: objFeed)
                cell.schedulebtn.tag = indexPath.row
                cell.schedulebtn.addTarget(self, action: #selector(self.schedulebtnAction), for: .touchUpInside)

            }
            }
        }
       
        
        return cell

    }
    @objc func schedulebtnAction(sender: UIButton){
        if calendarselecteddate == ""  {
            let objUrl = arrcalendarFeed[sender.tag].type
            if objUrl! == 1  {
                let objid = arrcalendarFeed[sender.tag]
                let story = UIStoryboard(name: "Category", bundle:nil)
                
                let vc = story.instantiateViewController(withIdentifier: "NewDetailVC") as! NewDetailVC
                vc.eventID = String(objid.id ?? 0)
                vc.isEvent = true
                vc.module = "Event"
                vc.Maasview = false

                (self.actualController as! CalenderVC).navigationController?.pushViewController(vc, animated: true)
            }else if objUrl! == 2{
                let objid = arrcalendarFeed[sender.tag]
                let story = UIStoryboard(name: "Category", bundle:nil)
                let vc = story.instantiateViewController(withIdentifier: "NewDetailVC") as! NewDetailVC
                
                vc.eventID = String(objid.id ?? 0)
                vc.isFromGR = true
                vc.module = "GR"
                (self.actualController as! CalenderVC).navigationController?.pushViewController(vc, animated: true)
            }else if objUrl! == 3{
                let objid = arrcalendarFeed[sender.tag]
                
                let story = UIStoryboard(name: "Category", bundle:nil)
                
                let vc = story.instantiateViewController(withIdentifier: "NewDetailVC") as! NewDetailVC
                print("String(obj.id ?? 0) sdgs \(String(objid.id ?? 0))")
                vc.eventID = String(objid.id ?? 0)
                vc.isEvent = false
                vc.ComingfromVC = "Sdgs"
                vc.module = "Sdgs"
                vc.Maasview = true
                (self.actualController as! CalenderVC).navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            let objUrl = arrcalendarselected[sender.tag].type
            if objUrl! == 1  {
                let objid = arrcalendarselected[sender.tag]
                let story = UIStoryboard(name: "Category", bundle:nil)
                
                let vc = story.instantiateViewController(withIdentifier: "NewDetailVC") as! NewDetailVC
                vc.eventID = String(objid.id ?? 0)
                vc.isEvent = true
                vc.module = "Event"
                vc.Maasview = false

                (self.actualController as! CalenderVC).navigationController?.pushViewController(vc, animated: true)
            }else if objUrl! == 2{
                let objid = arrcalendarselected[sender.tag]
                let story = UIStoryboard(name: "Category", bundle:nil)
                let vc = story.instantiateViewController(withIdentifier: "NewDetailVC") as! NewDetailVC
                
                vc.eventID = String(objid.id ?? 0)
                vc.isFromGR = true
                vc.module = "GR"
                (self.actualController as! CalenderVC).navigationController?.pushViewController(vc, animated: true)
            }else if objUrl! == 3{
                let objid = arrcalendarselected[sender.tag]
                
                let story = UIStoryboard(name: "Category", bundle:nil)
                
                let vc = story.instantiateViewController(withIdentifier: "NewDetailVC") as! NewDetailVC
                print("String(obj.id ?? 0) sdgs \(String(objid.id ?? 0))")
                vc.eventID = String(objid.id ?? 0)
                vc.isEvent = false
                vc.ComingfromVC = "Sdgs"
                vc.module = "Sdgs"
                vc.Maasview = true
                (self.actualController as! CalenderVC).navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        
        
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
