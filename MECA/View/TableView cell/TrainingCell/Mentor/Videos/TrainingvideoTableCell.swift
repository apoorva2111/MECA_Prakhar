//
//  TrainingvideoTableCell.swift
//  MECA
//
//  Created by Macbook  on 31/05/21.
//

import UIKit

class TrainingvideoTableCell: UITableViewCell {
    @IBOutlet weak var videoView: RCustomView!
    @IBOutlet weak var externalView: RCustomView!
    @IBOutlet weak var videoImg: UIImageView!
    @IBOutlet weak var transparentimage:UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // transparentimage.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
    }

    static func nib() -> UINib {
        return UINib(nibName: "TrainingvideoTableCell", bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
