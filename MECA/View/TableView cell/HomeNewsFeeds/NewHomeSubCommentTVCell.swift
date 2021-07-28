//
//  NewHomeSubCommentTVCell.swift
//  MECA
//
//  Created by Apoorva Gangrade on 18/06/21.
//

import UIKit
import SDWebImage
class NewHomeSubCommentTVCell: UITableViewCell {
    @IBOutlet weak var imgAvtar: RCustomImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnLikeOutlet: UIButton!
    @IBOutlet weak var btnReplyOutlet: UIButton!
    @IBOutlet weak var btnDeleteOutlet: UIButton!
    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var lblLikeCount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCell(objDict:NewHomeSubComment) {
        print(objDict)
        lblDescription.text = objDict.comment
        if let imgAvtar = objDict.avatar{
            self.imgAvtar.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgAvtar.sd_setImage(with: URL.init(string: BaseURL + imgAvtar), completed: nil)
        }
        lblUserName.text = objDict.writer_name
//
//        if objDict.likes == 0{
//            imgLike.image = #imageLiteral(resourceName: "Like_BlueBorder")
//        }else{
//            imgLike.image = #imageLiteral(resourceName: "likes_Blue")
//        }
        lblLikeCount.text = String(objDict.likes ?? 0)
        
//        if objDict.is_admin{
//
//        }
//
        print(objDict.is_admin)
    }
}
