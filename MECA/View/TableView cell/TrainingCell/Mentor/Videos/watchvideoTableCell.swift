//
//  watchvideoTableCell.swift
//  MECA
//
//  Created by Macbook  on 29/05/21.
//

import UIKit
import SDWebImage
import AVFoundation
import AVKit
class watchvideoTableCell: UITableViewCell {
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    @IBOutlet weak var videotblDocument: UITableView!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnSeeMoreOutlet: UIButton!
    @IBOutlet weak var seeMoreHeightConstraint: NSLayoutConstraint!
    
    var trainingdetailVC : TrainingdetailVC!
    var arrVideoLink = [Trainingvideolinks]()
    override func awakeFromNib() {
        super.awakeFromNib()
        tblHeightConstraint.constant = CGFloat(154 * arrVideoLink.count)
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func settrainingData(dataEvent:Detailsinfo) {
        print("arrVideoLink111... \(dataEvent)")
        if dataEvent.triaingvideo!.count > 0{
            
            if arrVideoLink.count>0{
                arrVideoLink.removeAll()
            }
            arrVideoLink = dataEvent.triaingvideo!
            print("arrVideoLink2222 ... \(arrVideoLink)")
//            if arrVideoLink.count > 3{
//                seeMoreHeightConstraint.constant = 30
//
//
//                tblHeightConstraint.constant = CGFloat(154 * 3)
//
//            }else{
              //  seeMoreHeightConstraint.constant = 0
                
                tblHeightConstraint.constant = CGFloat(154 * dataEvent.triaingvideo!.count)

           // }
            videotblDocument.register(TrainingvideoTableCell.nib(), forCellReuseIdentifier: "TrainingvideoTableCell")
            videotblDocument.delegate = self
            videotblDocument.dataSource = self
           // tblHeightConstraint.constant = CGFloat(154*arrVideoLink.count)
            videotblDocument.reloadData()
          //  trainingdetailVC.trainingdetailtblview.beginUpdates()
          //  trainingdetailVC.trainingdetailtblview.endUpdates()
        }
    }
}
extension watchvideoTableCell : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(arrVideoLink.count)")
            return arrVideoLink.count
    
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = videotblDocument.dequeueReusableCell(withIdentifier: "TrainingvideoTableCell", for: indexPath) as! TrainingvideoTableCell
        
           // cell.imgyoutube.image = arrVideoLink[indexPath.row].file
           
            let urlYoutube = arrVideoLink[indexPath.row].link
            let urlID = urlYoutube?.youtubeID
            let urlStr = "http://img.youtube.com/vi/\(urlID ?? "")/1.jpg"
            let url = URL(string: urlStr)!
            cell.videoImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.videoImg.sd_setImage(with: url, completed: nil)
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 154
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            let obj = arrVideoLink[indexPath.row]
            if obj.link != ""{
                let objLink = (obj.link)!

                guard let url = URL(string: objLink) else { return }
                UIApplication.shared.open(url)
            }
        
    }
    
}
