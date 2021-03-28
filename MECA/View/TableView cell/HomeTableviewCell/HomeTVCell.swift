//
//  HomeTVCell.swift
//  MECA
//
//  Created by Apoorva Gangrade on 19/03/21.
//

import UIKit
import SDWebImage
class HomeTVCell: UITableViewCell {
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
//        viewIMG.backgroundColor = .red
//        viewIMG.roundCorners([.topRight, .topLeft], radius: 16, fream: viewIMG)
        imgFeed.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imgFeed.layer.cornerRadius = 16

        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    static func nib() -> UINib {
        return UINib(nibName: "HomeTVCell", bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCell(feed:Data) {
      lblTitle.text = feed.title
        lblEventName.text = feed.whatsnew_type_lable
        let writerName = feed.writer_name!
        lblWritternBy.text = "Written by: \(writerName)"
        if feed.cover_image != "" {
            let imgUrl = BaseURL + feed.cover_image!
            //imgFeed.contentMode = .scaleAspectFill
            imgFeed.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgFeed.sd_setImage(with: URL(string: imgUrl), completed: nil)
          // imgFeed.roundCorners([.topLeft, .topRight], radius: 16)


        }

    }
    
}
