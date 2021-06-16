//
//  TrainingDetailVM.swift
//  MECA
//
//  Created by Macbook  on 29/05/21.
//

import Foundation
class TrainingDetailVM: BaseTableViewVM {
    let invitationCoverCell = "MentorTableCell"
    let descripcell = "DescriptionTableCell"
    let watchvideocell = "watchvideoTableCell"
    let uploadscell = "TBPReportTableCell"
    let pdcatablecel = "PdcaTableCell"
    
    var trainingtype = ""
    
    
    
    var eventData : Detailsinfo?
    var pdcainfodata : PdcaedetailModel?
    var sessionmodel : sessionFilemodel?
    
    
    override init(controller: UIViewController?) {
        super.init(controller: controller)
        actualController = controller
    }
    override func getNumbersOfRows(in section: Int) -> Int {
        
        
            if (actualController as! TrainingdetailVC).isFromPDCA {
                return 2
            }else{
                if self.trainingtype == "1" {
                    print("if \(self.trainingtype)")
                    return 4
                }else{
                    print("Int(self.trainingtype)\(self.trainingtype)")
                    return 3
                }
            }

    }
    
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
//        if (actualController as! TrainingdetailVC).isFromPDCA{
//            if indexPath.row == 0 {
//                let cell = tableView.dequeueReusableCell(withIdentifier: descripcell, for: indexPath) as! DescriptionTableCell
//                if (actualController as! TrainingdetailVC).isFromPDCA{
//            if pdcainfodata != nil{
//                cell.setpdcainfoData(dataEvent: pdcainfodata!)
//                cell.lbldescription.sizeToFit()
//                     cell.lbldescription.layoutIfNeeded()
//            }
//                }
//                return cell
//            }else if indexPath.row == 1{
////                PdcaTableCell
//                if indexPath.row == 0 {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: descripcell, for: indexPath) as! DescriptionTableCell
//                    if (actualController as! TrainingdetailVC).isFromPDCA{
//                if pdcainfodata != nil{
//                    cell.setpdcainfoData(dataEvent: pdcainfodata!)
//                    cell.lbldescription.sizeToFit()
//                         cell.lbldescription.layoutIfNeeded()
//                }
//                    }
//                    return cell
//
//            }
//
//        }else{
        if (actualController as! TrainingdetailVC).isFromPDCA {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: descripcell, for: indexPath) as! DescriptionTableCell
                if (actualController as! TrainingdetailVC).isFromPDCA{
                    if pdcainfodata != nil{
                        cell.setpdcainfoData(dataEvent: pdcainfodata!)
                                        cell.lbldescription.sizeToFit()
                                             cell.lbldescription.layoutIfNeeded()
                    }
                    
                }
                
                
                return cell

            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: pdcatablecel, for: indexPath) as! PdcaTableCell
                cell.trainingdetailVC = (actualController as? TrainingdetailVC).self
                if (actualController as! TrainingdetailVC).isFromPDCA{
                    if pdcainfodata != nil{
                        cell.setpdcavideoinfoData(dataEvent: pdcainfodata!)
                                       
                    }
                    
                }
                
                
                return cell

            }
                    }else {
            if self.trainingtype == "1" {
                if indexPath.row == 0{
                    let cell = tableView.dequeueReusableCell(withIdentifier: invitationCoverCell, for: indexPath) as! MentorTableCell
                    cell.trainingdetailVC = (actualController as? TrainingdetailVC).self
                    
                    if (actualController as! TrainingdetailVC).Trainingview{
                if eventData != nil{
                    cell.setEventData(dataEvent: eventData!)
                }
                        
                    }
                    return cell
                }else if indexPath.row == 1{
                    let cell = tableView.dequeueReusableCell(withIdentifier: descripcell, for: indexPath) as! DescriptionTableCell
                    if (actualController as! TrainingdetailVC).Trainingview{
                if eventData != nil{
                    cell.setEventData(dataEvent: eventData!)
                    cell.lbldescription.sizeToFit()
                         cell.lbldescription.layoutIfNeeded()
                }
                    }
                    return cell
                }else if indexPath.row == 2{
                    let cell = tableView.dequeueReusableCell(withIdentifier: watchvideocell, for: indexPath) as! watchvideoTableCell
                    if (actualController as! TrainingdetailVC).Trainingview{
                if eventData != nil{
                    cell.settrainingData(dataEvent: eventData!)
                   
                }
                    }
                    return cell
                }else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: uploadscell, for: indexPath) as! TBPReportTableCell
                    cell.trainingdetailVC = (actualController as? TrainingdetailVC).self
                    if (actualController as! TrainingdetailVC).Trainingview{
                if eventData != nil{
                    cell.settraininguploadData(dataEvent: eventData!)
                   
                }
                    }
                    return cell
                }
                
            }else{
                
                if indexPath.row == 0{
                    let cell = tableView.dequeueReusableCell(withIdentifier: invitationCoverCell, for: indexPath) as! MentorTableCell
                    cell.trainingdetailVC = (actualController as? TrainingdetailVC).self
                    if (actualController as! TrainingdetailVC).Trainingview{
                if eventData != nil{
                    cell.setEventData(dataEvent: eventData!)
                }
                    }
                    return cell
                }else if indexPath.row == 1{
                    let cell = tableView.dequeueReusableCell(withIdentifier: descripcell, for: indexPath) as! DescriptionTableCell
                    if (actualController as! TrainingdetailVC).Trainingview{
                if eventData != nil{
                    cell.setEventData(dataEvent: eventData!)
                    cell.lbldescription.sizeToFit()
                         cell.lbldescription.layoutIfNeeded()
                }
                    }
                    return cell
                }else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: watchvideocell, for: indexPath) as! watchvideoTableCell
                    if (actualController as! TrainingdetailVC).Trainingview{
                if eventData != nil{
                    cell.settrainingData(dataEvent: eventData!)
                   
                }
                    }
                    return cell
                }
                
                
            }
        
    }
        return UITableViewCell()
        }
        

        
        
        
    
    
    override func getHeightForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        if (actualController as! TrainingdetailVC).isFromPDCA {
            
            if indexPath.row == 0{
                if (actualController as! TrainingdetailVC).isFromPDCA{
                return UITableView.automaticDimension
                }
            } else if indexPath.row == 1{
                if (actualController as! TrainingdetailVC).isFromPDCA{
                    
                    if pdcainfodata != nil{
                        if pdcainfodata?.sessions != nil {
                            if (pdcainfodata?.sessions!.count)! > 0{
                                return UITableView.automaticDimension  //150
                            }else{
                                return 0
                            }

                    }else{
                        return 0
                    }
                    }
                }
            }
        }else{
        
        if self.trainingtype == "1" {
            if indexPath.row == 0 {
                if (actualController as! TrainingdetailVC).Trainingview{
                if eventData != nil{
                    if eventData?.invitations != nil {
                        if (eventData?.invitations!.count)! > 0{
                            return UITableView.automaticDimension//150
                        }else{
                            return 0
                        }
                    }else{
                        return 0
                    }
                }
                }
            }else if indexPath.row == 1{
                if (actualController as! TrainingdetailVC).Trainingview{
                return UITableView.automaticDimension
                }
            }else if indexPath.row == 2 {
                if (actualController as! TrainingdetailVC).Trainingview{
                if eventData != nil{
                    if eventData?.triaingvideo != nil {
                        if (eventData?.triaingvideo!.count)! > 0{
                            return UITableView.automaticDimension//150
                        }else{
                            return 0
                        }
                    }else{
                        return 0
                    }
                }
                }
            }else{
                if (actualController as! TrainingdetailVC).Trainingview{
                if eventData != nil {
                    if eventData?.triainguploads != nil {
                        if (eventData?.triainguploads!.count)! > 0{
                            return UITableView.automaticDimension//150
                        }else{
                            return 0
                        }
                    }else{
                        return 0
                    }
                }
                }
            }
            
            
        }
        else{
            if indexPath.row == 0 {
                if (actualController as! TrainingdetailVC).Trainingview{
                if eventData != nil{
                    if eventData?.invitations != nil {
                        if (eventData?.invitations!.count)! > 0{
                            return UITableView.automaticDimension//150
                        }else{
                            return 0
                        }
                    }else{
                        return 0
                    }
                }
                }
            }else if indexPath.row == 1{
                if (actualController as! TrainingdetailVC).Trainingview{
                return UITableView.automaticDimension
                }
            }else {
                if (actualController as! TrainingdetailVC).Trainingview{
                if eventData != nil{
                    if eventData?.triaingvideo != nil {
                        if (eventData?.triaingvideo!.count)! > 0{
                            return UITableView.automaticDimension//150
                        }else{
                            return 0
                        }
                    }else{
                        return 0
                    }
                }
                
                }
                
            }
        }
        
    }
        
        
//
//
        return 0
       
    }
    func callTrainingInfoWebservice() {
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForTrainingInfo(eventID:(actualController as! TrainingdetailVC).eventID) { [self] (result) in
            
            if let respCode = result.resp_code{
                
                if respCode == 200{
                    
                    if let objDate = result.data {
                        
                        eventData = objDate
                        trainingtype = (eventData?.type)!
                        userDef.setValue(eventData?.id, forKey: UserDefaultKey.traininguploadid)
                        
                        
                        print("eventData ... all...\(eventData)")
                        GlobalObj.displayLoader(true, show: false)
                        (actualController as! TrainingdetailVC).trainingdetailtblview.isHidden = false
                        (actualController as! TrainingdetailVC).trainingdetailtblview.reloadData()
                    }else{
                        (actualController as! TrainingdetailVC).trainingdetailtblview.isHidden = false
                        
                        GlobalObj.displayLoader(true, show: false)
                    }
                    
                }
                
                GlobalObj.displayLoader(true, show: false)
                
            }
        }
    }
    
    
    func callTrainingPDCAInfoWebservice() {
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForTrainingPDCAInfo(eventID:(actualController as! TrainingdetailVC).eventID) { [self] (result) in
            
            if let respCode = result.resp_code{
                
                if respCode == 200{
                    
                    if let objDate = result.data {
                        
                        pdcainfodata = objDate
                        
                       
                        userDef.setValue(eventData?.id, forKey: UserDefaultKey.trainingpdcauploadid)
                        
                        
                        print("eventData ... all...\(eventData)")
                        GlobalObj.displayLoader(true, show: false)
                        (actualController as! TrainingdetailVC).trainingdetailtblview.isHidden = false
                        (actualController as! TrainingdetailVC).trainingdetailtblview.reloadData()
                    }else{
                        (actualController as! TrainingdetailVC).trainingdetailtblview.isHidden = false
                        
                        GlobalObj.displayLoader(true, show: false)
                    }
                    
                }
                
                GlobalObj.displayLoader(true, show: false)
                
            }
        }
    }
    
}


