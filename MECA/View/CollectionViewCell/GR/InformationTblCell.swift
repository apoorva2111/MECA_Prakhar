//
//  InformationTblCell.swift
//  MECA
//
//  Created by Macbook  on 20/07/21.
//

import UIKit
import SDWebImage
class InformationTblCell: UITableViewCell {
    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var viewIMG: UIView!
    
    @IBOutlet weak var imgFeed: UIImageView!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblWritternBy: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    var FromSpecialsitesinfn : SpecialsitesVC!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgFeed.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imgFeed.layer.cornerRadius = 16
    }
  
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    static func nib() -> UINib {
        return UINib(nibName: "InformationTblCell", bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setCellGRMecad(feed:Mecad_information) {
        lblTitle.text = feed.title
        
        
        if feed.cover_image != "" {
            let imgUrl = BaseURL + feed.cover_image!
            imgFeed.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgFeed.sd_setImage(with: URL(string: imgUrl), completed: nil)
        }
        let convertedFormat =  GlobalObj.convertToString(dateString: feed.created_at!)
        lblEventName.text = convertedFormat
    }
    func setCellGRDistribution(feed:Distributor_information) {
        lblTitle.text = feed.title
        
        
        if feed.cover_image != "" {
            let imgUrl = BaseURL + feed.cover_image!
            imgFeed.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgFeed.sd_setImage(with: URL(string: imgUrl), completed: nil)
        }
        let convertedFormat =  GlobalObj.convertToString(dateString: feed.created_at!)
        lblEventName.text = convertedFormat
    }
}
