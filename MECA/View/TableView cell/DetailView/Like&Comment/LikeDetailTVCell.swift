//
//  LikeDetailTVCell.swift
//  MECA
//
//  Created by Apoorva Gangrade on 16/05/21.
//

import UIKit
import SDWebImage
class LikeDetailTVCell: UITableViewCell {
    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgUserProfile: RCustomImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if GlobalValue.tabCategory == "GR"{
            imgLike.image = #imageLiteral(resourceName: "like_Red")
        }else if  GlobalValue.tabCategory == "Maas" || GlobalValue.tabCategory == "Hydrogen" || GlobalValue.tabCategory == "SDGS"{
            imgLike.image = #imageLiteral(resourceName: "like_Blue")
        }else{
            imgLike.image = #imageLiteral(resourceName: "like_Orange")
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static func nib() -> UINib {
        return UINib(nibName: "LikeDetailTVCell", bundle: nil)
    }
    func setCell(linkListData : Like_ListData) {
        lblUserName.text = linkListData.username
        let img = BaseURL + (linkListData.avatar ?? "")
        imgUserProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imgUserProfile.sd_setImage(with: URL.init(string: img), completed: nil)

    }
}
