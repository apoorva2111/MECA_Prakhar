//
//  LatestNewsCVCell.swift
//  MECA
//
//  Created by Apoorva Gangrade on 28/05/21.
//

import UIKit
import SDWebImage
class LatestNewsCVCell: UICollectionViewCell {

    @IBOutlet weak var lblWriterName: UILabel!
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnPlayVideo: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgNews.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imgNews.layer.cornerRadius = 20
    }
    func setCell(objDict:NSDictionary){
        print(objDict)
        if objDict["catTitle"] as! String == "Videos"{
            btnPlayVideo.isHidden = false
        }else{
            btnPlayVideo.isHidden = true
        }
        if let imgUrl = objDict["cover_image"] as? String{
            let url = BaseURL + imgUrl
            self.imgNews.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgNews.sd_setImage(with: URL.init(string: url), completed: nil)
        }
        lblTitle.text = objDict["title"] as? String
        lblWriterName.text = objDict["writer_name"] as? String
        let convertedFormat =  GlobalObj.convertToString(dateString: objDict["created_at"] as? String ?? "")
        lblDate.text = convertedFormat
        

    }
    
}

