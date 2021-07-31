//
//  oneandonlydetailVM.swift
//  MECA
//
//  Created by Macbook  on 05/07/21.
//

import Foundation
import SDWebImage

class oneandonlydetailVM: BaseTableViewVM {
    
    let identifierCoverImgCell = "detailcoverimgcell"
    let identifiercontentcell = "oneandonlyContentTVCell"
    let oneandonlydocumentcell = "OneandonlyDocumentcell"
    let oneandonlylikeCell = "oneandonlylikeCell"
    
    var kaizenData : KaizenInfoDataModel?
    override init(controller: UIViewController?) {
        super.init(controller: controller)
    }
    
    override func getNumbersOfRows(in section: Int) -> Int {
        return 4
    }
    
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: identifierCoverImgCell, for: indexPath) as! detailcoverimgcell
            cell.btnBackOutlet.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
            
            
                if kaizenData != nil{
                    cell.setoneandonlyData(dataoneandonly: kaizenData!)
                }
            
            return cell
            
        }
        
        else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: identifiercontentcell, for: indexPath) as! oneandonlyContentTVCell



            if kaizenData != nil{
                cell.btnReadMoreOutlet.addTarget(self, action: #selector(didTapReadMore), for: .touchUpInside)
                cell.setoneandonlyData(dataoneandonly: kaizenData!)
            }

            return cell
        }else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: oneandonlydocumentcell, for: indexPath) as! OneandonlyDocumentcell
            cell.oneandonlyDetailVC = (actualController as? oneandonlydetailVC).self
            if kaizenData != nil{
            cell.setEventData(dataEvent: kaizenData!)
            }
            return cell
            
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: oneandonlylikeCell, for: indexPath) as! oneandonlylikeCell
            
            if kaizenData != nil{
            cell.setlikeData(dataEvent: kaizenData!)
                cell.btnlike.addTarget(self, action: #selector(didTaplikebtn), for: .touchUpInside)
            }
            return cell
            
        }
//        return UITableViewCell() oneandonlylikeCell
    }
    
    @objc func didTapReadMore(sender:UIButton) {
        if sender.isSelected{
            sender.setTitle("Read More", for: .normal)
            sender.isSelected = false
            BoolValue.isFromNewsContent = false
            (self.actualController as! oneandonlydetailVC).tblDetailView.reloadData()
        }else{
            sender.isSelected = true
            sender.setTitle("Read Less", for: .normal)
            BoolValue.isFromNewsContent = true
            (self.actualController as! oneandonlydetailVC).tblDetailView.reloadData()
        }
        
    }
    @objc func didTaplikebtn(sender:UIButton) {
        if sender.isSelected{
            sender.isSelected = false
            (self.actualController as! oneandonlydetailVC).tblDetailView.reloadData()
        }else{
            sender.isSelected = true
            (self.actualController as! oneandonlydetailVC).tblDetailView.reloadData()
        }
        
        
    }
    override func getHeightForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        if indexPath.row == 0{
            return UITableView.automaticDimension//440
        }else if indexPath.row == 1{
            return UITableView.automaticDimension//440
        }else if indexPath.row == 2{
            return UITableView.automaticDimension
        }
        else{
            return UITableView.automaticDimension
        }
    }
    @objc func didTapBackButton(sender:UIButton) {
        (actualController as! oneandonlydetailVC).navigationController?.popViewController(animated: true)
    }
    func callONEANDONLYInfoWebservice(completion:@escaping(Bool) -> Void) {
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForoneandonlyInfo(eventId: (actualController as! oneandonlydetailVC).eventID) { (result) in
            if let respCode = result.resp_code{
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)
                    
                    if let objDate = result.data {
                        print(objDate)
                        if result.data == nil{
                            (self.actualController as! oneandonlydetailVC).nodatalbl.isHidden = false
                        }else{
                            (self.actualController as! oneandonlydetailVC).nodatalbl.isHidden = true
                        }

                        self.kaizenData = objDate
                        (self.actualController as! oneandonlydetailVC).tblDetailView.isHidden = false
                        (self.actualController as! oneandonlydetailVC).tblDetailView.reloadData()
                        
                        
                        completion(true)
                    }else{
                        (self.actualController as! oneandonlydetailVC).tblDetailView.isHidden = true
                        GlobalObj.displayLoader(true, show: false)
                    }
                }else{
                    (self.actualController as! oneandonlydetailVC).tblDetailView.isHidden = true
                    GlobalObj.displayLoader(true, show: false)
                }
                
            }
        }
    }


}
