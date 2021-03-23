//
//  HomeVM.swift
//  MECA
//
//  Created by Apoorva Gangrade on 21/03/21.
//

import UIKit

class HomeVM: BaseTableViewVM {
   
    let identifierItemCell = "HomeTVCell"
    var items:[String] = []

    
    override init(controller: UIViewController?) {
        super.init(controller: controller)
        baseHeaderTableViewHeight = 70
    }
    override func getNumbersOfRows(in section: Int) -> Int {
        return 5
    }
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierItemCell, for: indexPath) as! HomeTVCell
        return cell

    }
    override func didSelectRowAt(_ indexPath: IndexPath, tableView: UITableView) {
    }
    override func getHeightForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        return 50

    }
    override func getHeightForHeaderAt(_ section: Int, tableView: UITableView) -> CGFloat {
    return 50
    }
    override func getBaseTableHeaderViewFor(_ section: Int, tableView: UITableView) -> UIView? {
        baseTableHeaderView = BaseTableHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: baseHeaderTableViewHeight))
        baseTableHeaderView.setInfo(title: "What's new", hint: nil, imageFilterButton: nil)

        return baseTableHeaderView
}
    

}
