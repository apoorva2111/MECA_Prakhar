//
//  GrSupportLInkTblCell.swift
//  MECA
//
//  Created by Macbook  on 21/07/21.
//

import UIKit

class GrSupportLInkTblCell: UITableViewCell {
    @IBOutlet weak var openlinkbtn:UIButton!
    @IBOutlet weak var namelbl:UILabel!
    @IBOutlet weak var positionlbl:UILabel!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCellsupportdetails(feed:GRSupportdatas) {
        namelbl.text! = feed.name!
        positionlbl.text! = feed.position!
        openlinkbtn.setTitle(feed.email!, for: UIControl.State.normal)
       
        
    }
}
