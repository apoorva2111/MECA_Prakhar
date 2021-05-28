//
//  NewsHomeVM.swift
//  MECA
//
//  Created by Apoorva Gangrade on 28/05/21.
//

import UIKit

class NewsHomeVM: BaseTableViewVM {
    
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
            return 5
        }
    }
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsHomePickTVCell", for: indexPath) as! NewsHomePickTVCell
            return cell
        }else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "LatestNewsTVCell", for: indexPath) as! LatestNewsTVCell
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
}
