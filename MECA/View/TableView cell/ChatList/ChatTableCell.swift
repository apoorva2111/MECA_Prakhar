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
    
    var on3DotsClick: ((UIButton)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setCellChatuser(feed:Recentchatmodel) {
        namelbl.text = feed.display_user_name!
        
        let sec = feed.last_call_at!.msToSeconds
        print("gfgfhghjgjhjh....\(sec)")
        setBadge(count: feed.unread)
       // namelbl.text = feed.userprofile?.avatar!
        if feed.avatar != "" {
            let imgUrl = BaseURL + (feed.avatar!)
            chatprofileView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            chatprofileView.sd_setImage(with: URL(string: imgUrl), completed: nil)
        }
    }
    func setCelladminChatuser(feed:Adminchatusers) {
        setBadge(count: 0)
        namelbl.text = feed.display_user_name!
        if feed.avatar != "" {
            let imgUrl = BaseURL + (feed.avatar!)
            chatprofileView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            chatprofileView.sd_setImage(with: URL(string: imgUrl), completed: nil)
        }
    }
    func setCelluser(feed:Chatusers) {
        setBadge(count: 0)
        namelbl.text = feed.display_user_name!
        if feed.avatar != "" {
            let imgUrl = BaseURL + (feed.avatar!)
            chatprofileView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            chatprofileView.sd_setImage(with: URL(string: imgUrl), completed: nil)
        }
    }
    func setBadge(count: Int?) {
        Badgebl.isHidden = count ?? 0 == 0
        Badgebl.text = String(count ?? 0)
    }
    
    @IBAction func onClick3Dots(_ sender: UIButton) {
        on3DotsClick?(sender)
    }
}
extension Int {
    var msToSeconds: Double { Double(self) / 1000 }
}
