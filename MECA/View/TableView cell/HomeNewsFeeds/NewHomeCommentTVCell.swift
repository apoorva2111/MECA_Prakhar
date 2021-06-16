//
//  NewHomeCommentTVCell.swift
//  MECA


import UIKit
import SDWebImage
class NewHomeCommentTVCell: UITableViewCell {
    @IBOutlet weak var imgAvtar: RCustomImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnLikeOutlet: UIButton!
    @IBOutlet weak var btnReplyOutlet: UIButton!
    @IBOutlet weak var btnDeleteOutlet: UIButton!
    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var tblReply: customTblView!
    @IBOutlet weak var viewReply: UIView!
    @IBOutlet weak var viewReplyHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var txtComment: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCell(comment:NewHomeCommentData){
        print(comment)
        lblDescription.text = comment.comment
        if let imgAvtar = comment.avatar{
            self.imgAvtar.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgAvtar.sd_setImage(with: URL.init(string: BaseURL + imgAvtar), completed: nil)
        }
        lblUserName.text = comment.writer_name
        
        if comment.subcomments?.count == 0{
            tblReply.isHidden = true
            viewReply.isHidden = true
            viewReplyHeightConstraint.constant = 0
        }
    }
}
