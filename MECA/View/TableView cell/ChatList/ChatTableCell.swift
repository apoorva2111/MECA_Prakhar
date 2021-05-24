//
//  ChatTableCell.swift
//  MECA
//
//  Created by Macbook  on 12/05/21.
//

import UIKit
import SDWebImage
class ChatTableCell: UITableViewCell {
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var chatprofileView: UIImageView!
    @IBOutlet weak var ArrowimgView: UIImageView!
    @IBOutlet weak var btnselect: UIButton!
    @IBOutlet weak var namelbl:UILabel!
    @IBOutlet weak var Badgebl:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setCellChatuser(feed:Recentchatmodel) {
        if feed.is_admin_chat == 0 {
            var firstname : String!
            var lastname : String!
            firstname = feed.userprofile!.first_name!
            lastname = feed.userprofile!.last_name!
            namelbl.text =  firstname + " " + lastname
        }else{
            namelbl.text = feed.userprofile?.username!
        }
        
        if feed.unread! == 0  {
            Badgebl.isHidden = true
        }else{
            Badgebl.text = String(feed.unread!)
        }
       // namelbl.text = feed.userprofile?.avatar!
        if feed.userprofile?.avatar != "" {
            let imgUrl = BaseURL + (feed.userprofile?.avatar!)!
            chatprofileView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            chatprofileView.sd_setImage(with: URL(string: imgUrl), completed: nil)
        }
    }
    func setCelladminChatuser(feed:Adminchatusers) {
        Badgebl.isHidden = true
       // namelbl.text = feed.userprofile?.avatar!
        if feed.avatar != "" {
            let imgUrl = BaseURL + (feed.avatar!)
            chatprofileView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            chatprofileView.sd_setImage(with: URL(string: imgUrl), completed: nil)
        }
    }
    func setCelluser(feed:Chatusers) {
        
        Badgebl.isHidden = true
        namelbl.text = feed.first_name!  + feed.last_name!
        if feed.avatar != "" {
            let imgUrl = BaseURL + (feed.avatar!)
            chatprofileView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            chatprofileView.sd_setImage(with: URL(string: imgUrl), completed: nil)
        }
    }
    
    
}
