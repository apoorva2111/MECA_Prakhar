//
//  OneandonlyTVCell.swift
//  MECA
//
//  Created by Macbook  on 05/07/21.
//

import UIKit
import SDWebImage
class OneandonlyTVCell: UITableViewCell {

    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var viewIMG: UIView!
    
    @IBOutlet weak var imgFeed: UIImageView!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblWritternBy: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgFeed.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imgFeed.layer.cornerRadius = 16
        lblTitle.sizeToFit()
        
    }
  
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    static func nib() -> UINib {
        return UINib(nibName: "OneandonlyTVCell", bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setCelloneandonlay(feed:oneandonlyvalues) {
        print(feed)
        lblTitle.text = feed.title!
        let convertedFormat = GlobalObj.convertToString(dateString: feed.created_at!)
       
        
        lblDate.text = convertedFormat
        print("\(String(describing: feed.writer_name))")
        lblEventName.text = feed.writer_name!
        
        lblWritternBy.text = feed.description!
//        if let ownerprofile = feed.ownerprofile {
//           // lblAdmin.text = ownerprofile.username
//            print(ownerprofile)
//        }
//
        if feed.cover_image != "" {
            let imgUrl = BaseURL + feed.cover_image!
            imgFeed.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgFeed.sd_setImage(with: URL(string: imgUrl), completed: nil)
        }
        
    }
}
