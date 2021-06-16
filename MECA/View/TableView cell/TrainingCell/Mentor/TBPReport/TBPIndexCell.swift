//
//  TBPIndexCell.swift
//  MECA
//
//  Created by Macbook  on 01/06/21.
//

import UIKit

class TBPIndexCell: UITableViewCell {
    @IBOutlet weak var videoView: RCustomView!
    @IBOutlet weak var externalView: RCustomView!
    @IBOutlet weak var titlelbl:UILabel!
    @IBOutlet weak var filenamelbl:UILabel!
    @IBOutlet weak var downloadlinkbtn:UIButton!
    @IBOutlet weak var revisedlinkbtn:UIButton!
    @IBOutlet weak var uploadbtn:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static func nib() -> UINib {
        return UINib(nibName: "TBPIndexCell", bundle: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
