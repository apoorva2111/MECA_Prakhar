
import UIKit
import SDWebImage
class CommentReplyTVCell: UITableViewCell {
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var imgProfile: RCustomImageView!
    @IBOutlet weak var lbDay: UILabel!
    @IBOutlet weak var btnReplyOutlet: UIButton!
    @IBOutlet weak var imgComment: UIImageView!
    @IBOutlet weak var imgCommentHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnDeleteOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCell(commentData : Subcomments) {
        print(commentData)
        if BoolValue.isFromReplyComment{
            btnReplyOutlet.setTitle("Reply", for: .normal)
            btnReplyOutlet.isSelected = false
        }
        lblUserName.text = commentData.writer_name
        let date = GlobalObj.convertToString(dateString: commentData.created_at ?? "")

        lbDay.text = date
        
        if commentData.isfile == 1{
            if let urlstr = commentData.comment {
                let url = BaseURL + urlstr
                imgComment.contentMode = .scaleToFill
                imgCommentHeightConstraint.constant = 150
                lblComment.isHidden = true
                imgComment.sd_setImage(with: URL.init(string: url), completed: nil)
      
            }
        }else{
            lblComment.text = commentData.comment
            imgCommentHeightConstraint.constant = 0
            lblComment.isHidden = false
            imgComment.isHidden = true
        }
        if let imgPro = commentData.avatar{
            let img = BaseURL + imgPro
            imgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgProfile.sd_setImage(with: URL.init(string: img), completed: nil)
        }else{
            imgProfile.image = #imageLiteral(resourceName: "editprofile")
        }
    }
}
