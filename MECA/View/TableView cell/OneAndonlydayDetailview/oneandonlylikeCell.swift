//
//  oneandonlylikeCell.swift
//  MECA
//
//  Created by Macbook  on 06/07/21.
//

import UIKit

class oneandonlylikeCell: UITableViewCell {
    @IBOutlet weak var lbllike:UILabel!
    @IBOutlet weak var btnlike:UIButton!
    @IBOutlet weak var imglike:UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setlikeData(dataEvent:KaizenInfoDataModel) {
        
        lbllike.text  = String(dataEvent.likes!)
        
        
    }
}
