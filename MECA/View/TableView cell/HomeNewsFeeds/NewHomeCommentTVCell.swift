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
    @IBOutlet weak var btnViewReplyHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnViewReplyOutlet: UIButton!
   
  //  @IBOutlet weak var tblReplyHeightConstraint: NSLayoutConstraint!
    
    var arrSubComment = [NewHomeSubComment]()
    var tbleComment = UITableView()
    
    @IBOutlet weak var btnSendReplyOutlet: UIButton!
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
       
        if comment.isOwner == 0{
            btnDeleteOutlet.isHidden = true
        }else{
            btnDeleteOutlet.isHidden = false
        }

        lblLikeCount.text = String(comment.likes ?? 0)
        tblReply.register(UINib.init(nibName: "NewHomeSubCommentTVCell", bundle: nil), forCellReuseIdentifier: "NewHomeSubCommentTVCell")

        if comment.subcomments?.count == 0{
            tblReply.isHidden = true
            viewReply.isHidden = true
            tblReply.delegate = self
            tblReply.dataSource = self
            tblReply.estimatedRowHeight = 0
//            tblReply.reloadData()
//            tblReply.layoutIfNeeded()
            btnViewReplyOutlet.isHidden = true
            btnViewReplyHeightConstraint.constant = 0
        }else{
            if arrSubComment.count > 0 {
                arrSubComment.removeAll()
            }
            for i in 0..<comment.subcomments!.count {
                let objsubComment = comment.subcomments![i]
                arrSubComment.insert(objsubComment, at: i)
            }
            //arrSubComment = comment.subcomments!
            btnViewReplyOutlet.isHidden = false
            btnViewReplyHeightConstraint.constant = 20
             if userDef.value(forKey: UserDefaultKey.replyView) != nil {
                if userDef.value(forKey: UserDefaultKey.replyView) as! String == "hideTable"{
                    tblReply.delegate = self
                    tblReply.dataSource = self
                    tblReply.reloadData()
                    tblReply.layoutIfNeeded()
                    tblReply.isHidden = true
                    viewReply.isHidden = true
                   // viewReplyHeightConstraint.constant = 0
                }else{
                    tblReply.delegate = self
                    tblReply.dataSource = self
                    tblReply.reloadData()
                    tblReply.layoutIfNeeded()
                    tblReply.isHidden = false
                    viewReply.isHidden = false
                }
             }else{
                userDef.setValue("hideTable", forKey: UserDefaultKey.replyView)
                userDef.synchronize()
                tblReply.delegate = self
                tblReply.dataSource = self
                tblReply.reloadData()
                tblReply.isHidden = true
                viewReply.isHidden = true
             //   viewReplyHeightConstraint.constant = 0
             }
            
        }
    }
}

extension NewHomeCommentTVCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSubComment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblReply.dequeueReusableCell(withIdentifier: "NewHomeSubCommentTVCell", for: indexPath) as! NewHomeSubCommentTVCell
        cell.setCell(objDict: arrSubComment[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if userDef.value(forKey: UserDefaultKey.replyView) != nil {
           if userDef.value(forKey: UserDefaultKey.replyView) as! String == "hideTable"{
            viewReplyHeightConstraint.constant = 0
            viewReply.isHidden = true
            tblReply.isHidden = true
            return 0
           }else{
            viewReplyHeightConstraint.constant = 60
            return 100
           }
        }else{
            viewReplyHeightConstraint.constant = 0
            viewReply.isHidden = true
            tblReply.isHidden = true
            return 0
        }
        
    }
 
}

