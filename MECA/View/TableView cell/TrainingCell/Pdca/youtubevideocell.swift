//
//  youtubevideocell.swift
//  MECA
//
//  Created by Macbook  on 30/05/21.
//

import UIKit
import SDWebImage

protocol pdfVCDelegate {
    func pdfValue(pdfStr:String)
}
class youtubevideocell: UITableViewCell {
   
    @IBOutlet weak var pdcavideotblDocument: UITableView!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var urlnameView: RCustomView!
    @IBOutlet weak var videosview: RCustomView!
    @IBOutlet weak var imgyoutube: UIImageView!
    @IBOutlet weak var namelbl:UILabel!
    @IBOutlet weak var eyebtn:UIButton!
    @IBOutlet weak var uploadbtn:UIButton!
    @IBOutlet weak var downloadbtn:UIButton!
    @IBOutlet weak var imagebtn:UIButton!
    @IBOutlet weak var filenamelbl:UILabel!
    var pdcaeventData = [Pdca_VideosModel]()
    var pdcauploadeventData = [Pdca_uploadModel]()
    var passsessionmodel = [sessionFilemodel]()
    var newpasspdcauploads : Pdca_uploadModel?
    var trainingdetailVC : TrainingdetailVC!
    var trainingvm : TrainingDetailVM!
   public var delegates: pdfVCDelegate?
    var actualController:UIViewController?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.pdcavideotblDocument.separatorStyle = UITableViewCell.SeparatorStyle.none
        // Initialization code

    }

    static func nib() -> UINib {
        return UINib(nibName: "youtubevideocell", bundle: nil)
    }
    
    func setpdcavideodatainfo(pdcavideodata:sessionFilemodel) {
        print("pdcavideodata ... \(pdcavideodata)")
        print("passsessionmodel ... \(passsessionmodel)")
        
        //videos
        if pdcavideodata.videos!.count > 0 {
            
            if pdcaeventData.count > 0  {
                pdcaeventData.removeAll()
            }
            pdcaeventData = pdcavideodata.videos!
        }
        print("uploaddata... \(pdcaeventData)")
        //upload
        if  pdcaeventData.count > 0{
            for newdata in pdcaeventData {
                
                if newdata.isViewed == 0 {
                    eyebtn.setImage(UIImage(named: "not_seen"), for: UIControl.State.normal)
                }else{
                    eyebtn.setImage(UIImage(named: "Seen"), for: UIControl.State.normal)
                }
                let urlYoutube  = newdata.videoLink!
                print("sfdfs \(urlYoutube)")
                let urlID = urlYoutube.youtubeID
                let urlStr = "http://img.youtube.com/vi/\(urlID ?? "")/1.jpg"
                            let url = URL(string: urlStr)!
                
                
                            imgyoutube.sd_imageIndicator = SDWebImageActivityIndicator.gray
                            imgyoutube.sd_setImage(with: url, completed: nil)
            }
            
            
        }
        if pdcavideodata.uploads!.count > 0 {
            
            if pdcauploadeventData.count > 0  {
                pdcauploadeventData.removeAll()
            }
            pdcauploadeventData = pdcavideodata.uploads!
            tblHeightConstraint.constant = CGFloat(43 * pdcavideodata.uploads!.count)
        }
       
      //  pdcavideotblDocument.register(PdcaindexCell.nib, forCellReuseIdentifier: PdcaindexCell.identifier)
        pdcavideotblDocument.register(PdcauploadindexTableCell.nib(), forCellReuseIdentifier: "PdcauploadindexTableCell")
        pdcavideotblDocument.delegate = self
        pdcavideotblDocument.dataSource = self
        pdcavideotblDocument.reloadData()
//        trainingdetailVC.trainingdetailtblview.beginUpdates()
//        trainingdetailVC.trainingdetailtblview.endUpdates()

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension youtubevideocell:UITableViewDelegate,UITableViewDataSource{
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            print("pdcaeventData.count \(pdcaeventData.count)")
//            return pdcaeventData.count
//        }else {
            print("pdcauploadeventData.count \(pdcauploadeventData.count)")
            return pdcauploadeventData.count
//        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
//        if (indexPath.section == 0) {
//       // let cell = tableView.dequeueReusableCell(withIdentifier: "PdcaindexCell", for: indexPath) as! PdcaindexCell
//            let cell = tableView.dequeueReusableCell(withIdentifier: PdcaindexCell.identifier) as? PdcaindexCell
//
//        cell!.txttitlelbl.text = pdcaeventData[indexPath.row].title
//        cell!.btnDownloadOutlet.tag = indexPath.row
//       // cell.btnDownloadOutlet.addTarget(self, action: #selector(self.DownloadDocument), for: .touchUpInside)
//
//
//
//        return cell!
//        }else
       // if indexPath.section == 0{
            let uploadcell = tableView.dequeueReusableCell(withIdentifier: "PdcauploadindexTableCell") as? PdcauploadindexTableCell
        uploadcell!.trainingdetailVC = (actualController as? TrainingdetailVC).self
        print("allvalue... \(pdcauploadeventData.count)")
            let allvalue = pdcauploadeventData[indexPath.row]
            print("allvalue... \(allvalue)")
            uploadcell!.setpdcauploaddatainfo(pdcavideodata: allvalue)
            
//            let NOof : Int = allvalue.noOfAttempts!
//            let myString = String(NOof)

            
            
             return uploadcell!
    //    }
       // return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select index video ")
        let objUrl = pdcauploadeventData[indexPath.row]
        print("\(objUrl.documentLink)")
        
        delegates?.pdfValue(pdfStr: objUrl.documentLink!)
//
//        let story = UIStoryboard(name: "Category", bundle:nil)
//        //let vc = FlowController().instantiateViewController(identifier: "PDFReaderVC", storyBoard: "Category") as! PDFReaderVC
//        let  myViewController = story.instantiateViewController(withIdentifier: "PDFReaderVC") as! PDFReaderVC
//        myViewController.isFromDetailPage = true
//        if objUrl.documentLink != ""{
//            myViewController.detailPageurl = BaseURL + objUrl.documentLink!
//        }
//
//        self.navigationController?.pushViewController(myViewController, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43
    }

}
