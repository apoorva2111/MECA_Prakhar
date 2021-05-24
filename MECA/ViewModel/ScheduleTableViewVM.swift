//
//  ScheduleTableViewVM.swift
//  MECA
//
//  Created by Macbook  on 18/05/21.
//

import UIKit
import Foundation
class ScheduleTableViewVM: NSObject {
    
    var identifierItem = ""
    var nibItem = ""
    var actualController:UIViewController?
    var tableItems:[Any] = [Any]()
    var sections:[String] = []
    var baseTableHeaderView:ScheduleHeaderView!
    var baseHeaderTableViewHeight:CGFloat = 50
    var baseFooterTableViewHeight:CGFloat = 50
    var cellHeight:CGFloat = 80
    init(controller:UIViewController?) {
        self.actualController = controller
    }
}
//TABLE_VIEW_METHODS
extension ScheduleTableViewVM{
    
    @objc func getBaseTableHeaderViewFor(_ section:Int, tableView:UITableView)->UIView?{
        baseTableHeaderView = ScheduleHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: baseHeaderTableViewHeight))
        baseTableHeaderView.setInfo(title: "Schedule", hint: nil, imageFilterButton: nil)
        
        return baseTableHeaderView
    }
    
    @objc func getHeightForHeaderAt(_ section:Int, tableView:UITableView)->CGFloat{
        return baseHeaderTableViewHeight
    }
    
    @objc func getBaseTableFooterViewFor(_ section:Int, tableView:UITableView)->UIView?{
        return UIView()
    }
    
    @objc func getHeightForRowAt(_ indexPath:IndexPath, tableView:UITableView)->CGFloat{
        return cellHeight
    }
    
    @objc func canEditRowAt(_ indexPath:IndexPath)->Bool{
        return false
    }
    
    @objc func getCellForRowAt(_ indexPath:IndexPath, tableView:UITableView)->UITableViewCell{
        
        return UITableViewCell()
    }
    
    @objc func getNumbersOfRows(in section:Int)->Int{
        return tableItems.count
    }
    @objc func getNumbersOfSections()->Int{
        return sections.count
    }
    @objc func didSelectRowAt(_ indexPath:IndexPath, tableView:UITableView){
        
    }
    @objc func setData(_ data:[Any]){
        tableItems = data
    }
}
