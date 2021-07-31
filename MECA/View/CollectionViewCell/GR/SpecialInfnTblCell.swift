//
//  SpecialInfnTblCell.swift
//  MECA
//
//  Created by Macbook  on 21/07/21.
//

import UIKit
import SDWebImage
class SpecialInfnTblCell: UITableViewCell {
    @IBOutlet weak var tblDocument: UITableView!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnSeeMoreOutlet: UIButton!
    @IBOutlet weak var seeMoreHeightConstraint: NSLayoutConstraint!
    var arrMecad_infoList = [Mecad_information]()
    var arrDistrib_infolist = [Distributor_information]()
    
    var Specialsite : SpecialsitesVC!
    var isFromDistributor = true
    override func awakeFromNib() {
        super.awakeFromNib()
       // btnSeeMoreOutlet.isHidden = true
        //seeMoreHeightConstraint.constant = 0
        //btnSeeMoreOutlet.isHidden = true
        // Initialization code
    }
    static func nib() -> UINib {
        return UINib(nibName: "SpecialInfnTblCell", bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setsiteData(dataforspecialsite:SpecialsiteData){
        
        print("\(isFromDistributor)")
        if isFromDistributor {
            print("Distributor")
            if dataforspecialsite.distributor_information?.count == 0 {
               // seeMoreHeightConstraint.constant = 0
            }else{
                if dataforspecialsite.distributor_information!.count > 0 {
                    arrDistrib_infolist.removeAll()
                }
                arrDistrib_infolist = dataforspecialsite.distributor_information!
                if self.arrDistrib_infolist.count > 0{

                    //btnSeeMoreOutlet.isHidden = true
                    //seeMoreHeightConstraint.constant = 0
                   // btnSeeMoreOutlet.isHidden = true
                    tblHeightConstraint.constant = CGFloat(292 * arrDistrib_infolist.count)
                   // tblHeightConstraint.constant = CGFloat(43 * 3)

                }
                
            }
        }else{
            print("Mecad")
            if dataforspecialsite.mecad_information?.count == 0 {
               // seeMoreHeightConstraint.constant = 0
            }else{
                if dataforspecialsite.mecad_information!.count > 0 {
                    arrMecad_infoList.removeAll()
                }
                arrMecad_infoList = dataforspecialsite.mecad_information!
                if self.arrMecad_infoList.count > 0{

                    //btnSeeMoreOutlet.isHidden = true
                    //seeMoreHeightConstraint.constant = 0
                   // btnSeeMoreOutlet.isHidden = true
                    tblHeightConstraint.constant = CGFloat(292 * arrMecad_infoList.count)
                   // tblHeightConstraint.constant = CGFloat(43 * 3)

                }
                
            }
        }
        tblDocument.register(InformationTblCell.nib(), forCellReuseIdentifier: "InformationTblCell")
        tblDocument.delegate = self
        tblDocument.dataSource = self
        tblDocument.reloadData()
        Specialsite.tblActivity.beginUpdates()
        Specialsite.tblActivity.endUpdates()
       
        
    }
}
extension SpecialInfnTblCell:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("special site lol \(arrMecad_infoList.count)")
        if isFromDistributor {
            return arrDistrib_infolist.count
        }else{
            return arrMecad_infoList.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblDocument.dequeueReusableCell(withIdentifier: "InformationTblCell", for: indexPath) as! InformationTblCell
        
       
        if isFromDistributor {
            let allvalueDist = arrDistrib_infolist[indexPath.row]
            cell.setCellGRDistribution(feed: allvalueDist)
        }else{
            let allvalue = arrMecad_infoList[indexPath.row]
            cell.setCellGRMecad(feed: allvalue)
        }
        
//        if let imgUrl = arrMecad_infoList[indexPath.row].cover_image{
//            let url = BaseURL + imgUrl
//            cell.imgCover.sd_imageIndicator = SDWebImageActivityIndicator.gray
//            cell.imgCover.sd_setImage(with: URL.init(string: url), completed: nil)
//        }
        
       // cell.lblTitle.text = arrFROMTMCList
//        cell.btnDownloadOutlet.tag = indexPath.row
//        cell.btnDownloadOutlet.addTarget(self, action: #selector(self.DownloadDocument), for: .touchUpInside)
       // cell.btnDownloadOutlet.addTarget(self, action: #selector(self.DownloadDocument), for: .touchUpInside)

        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objUrl = arrMecad_infoList[indexPath.row]

        if isFromDistributor {
            let allvalueDist = arrDistrib_infolist[indexPath.row]
            let story = UIStoryboard(name: "Category", bundle:nil)
            let vc = story.instantiateViewController(withIdentifier: "NewDetailVC") as! NewDetailVC
            let obj = arrDistrib_infolist[indexPath.row]
            vc.eventID = String(obj.id ?? 0)
            vc.isFromGR = true
            vc.module = "GR"
            Specialsite.navigationController?.pushViewController(vc, animated: true)
        }else{
            let objUrl = arrMecad_infoList[indexPath.row]
            
            let story = UIStoryboard(name: "Category", bundle:nil)
            let vc = story.instantiateViewController(withIdentifier: "NewDetailVC") as! NewDetailVC
            let obj = arrMecad_infoList[indexPath.row]
            vc.eventID = String(obj.id ?? 0)
            vc.isFromGR = true
            vc.module = "GR"
            Specialsite.navigationController?.pushViewController(vc, animated: true)

        }
//        let vc = FlowController().instantiateViewController(identifier: "PDFReaderVC", storyBoard: "Category") as! PDFReaderVC
//        let pdfurl = objUrl.doc_link!
//
//        vc.isFromDetailPage = true
//        if pdfurl != ""{
//            vc.detailPageurl =  pdfurl
//        }
//        FromTMCVC.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 292
    }

}
