//
//  FromTMCCell.swift
//  MECA
//
//  Created by Macbook  on 06/07/21.
//

import UIKit
import SDWebImage
class FromTMCCell: UITableViewCell {
    @IBOutlet weak var tblDocument: UITableView!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnSeeMoreOutlet: UIButton!
    @IBOutlet weak var seeMoreHeightConstraint: NSLayoutConstraint!
    var arrFROMTMCList = [Tmcs]()
    var FromTMCVC : FromTMCVC? 
    override func awakeFromNib() {
        super.awakeFromNib()
        btnSeeMoreOutlet.isHidden = true
        seeMoreHeightConstraint.constant = 0
        btnSeeMoreOutlet.isHidden = true
        // Initialization code
    }
    static func nib() -> UINib {
        return UINib(nibName: "FromTMCCell", bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setTMCData(dataEventfortmc:DatafromTMC){
        
        //self.arrFROMTMCList.append(dataEventfortmc)
        if dataEventfortmc.tmcs?.count == 0 {
            seeMoreHeightConstraint.constant = 0
        }else{
            if dataEventfortmc.tmcs!.count > 0 {
                arrFROMTMCList.removeAll()
            }
            arrFROMTMCList = dataEventfortmc.tmcs!
            if self.arrFROMTMCList.count > 0{

                btnSeeMoreOutlet.isHidden = true
                seeMoreHeightConstraint.constant = 0
                btnSeeMoreOutlet.isHidden = true
                tblHeightConstraint.constant = CGFloat(280 * arrFROMTMCList.count)
               // tblHeightConstraint.constant = CGFloat(43 * 3)

            }
            tblDocument.register(FromtmcindexCell.nib(), forCellReuseIdentifier: "FromtmcindexCell")
            tblDocument.delegate = self
            tblDocument.dataSource = self
            tblDocument.reloadData()
            FromTMCVC?.tblView.beginUpdates()
            FromTMCVC?.tblView.endUpdates()
        }
        
        print("setTMCData.... \(dataEventfortmc)")
        print("arrFROMTMCList.... \(self.arrFROMTMCList)")
        
        print("counr >>>> \(self.arrFROMTMCList.count)")
        
    }
}
extension FromTMCCell:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("arun prasath \(arrFROMTMCList.count)")
        return arrFROMTMCList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblDocument.dequeueReusableCell(withIdentifier: "FromtmcindexCell", for: indexPath) as! FromtmcindexCell
        
        if let imgUrl = arrFROMTMCList[indexPath.row].cover_image{
            let url = BaseURL + imgUrl
            cell.imgCover.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgCover.sd_setImage(with: URL.init(string: url), completed: nil)
        }
        
       // cell.lblTitle.text = arrFROMTMCList
//        cell.btnDownloadOutlet.tag = indexPath.row
//        cell.btnDownloadOutlet.addTarget(self, action: #selector(self.DownloadDocument), for: .touchUpInside)
       // cell.btnDownloadOutlet.addTarget(self, action: #selector(self.DownloadDocument), for: .touchUpInside)

        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objUrl = arrFROMTMCList[indexPath.row]

        let vc = FlowController().instantiateViewController(identifier: "PDFReaderVC", storyBoard: "Category") as! PDFReaderVC
        let pdfurl = objUrl.doc_link!
        
        vc.isFromDetailPage = true
        if pdfurl != ""{
            vc.detailPageurl =  pdfurl
        }
        FromTMCVC?.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }

}
