//
//  ReminderTableCell.swift
//  MECA
//
//  Created by Macbook  on 11/05/21.
//

import UIKit

class ReminderTableCell: UITableViewCell {
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    @IBOutlet weak var remindertitleLbl: UILabel!
    @IBOutlet weak var reminderdateLbl: UILabel!
    @IBOutlet weak var reminderimgview: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCellreminderdetails(feed:Reminderdata) {
        
        if feed.status == 1 {
            reminderimgview.image = UIImage(named: "done")
        }else{
            reminderimgview.image = UIImage(named: "to_do")
        }
        reminderdateLbl.text! = feed.due_date!
        remindertitleLbl.text! = feed.title!
        
        
    }
}
