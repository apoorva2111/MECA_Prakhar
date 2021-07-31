//
//  Connecttblcell.swift
//  MECA
//
//  Created by Macbook  on 21/07/21.
//

import UIKit

class Connecttblcell: UITableViewCell {
    @IBOutlet weak var connectbtn:UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static func nib() -> UINib {
        return UINib(nibName: "Connecttblcell", bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
