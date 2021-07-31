//
//  FromtmcindexCell.swift
//  MECA
//
//  Created by Macbook  on 07/07/21.
//

import UIKit

class FromtmcindexCell: UITableViewCell {
    @IBOutlet weak var imgCover: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgCover.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imgCover.layer.cornerRadius = 12
    }
    static func nib() -> UINib {
        return UINib(nibName: "FromtmcindexCell", bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
