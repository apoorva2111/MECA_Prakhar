//
//  WalltitleTableCell.swift
//  MECA
//
//  Created by Macbook  on 03/06/21.
//

import UIKit

class WalltitleTableCell: UITableViewCell {
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    @IBOutlet weak var titlewalllbl:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.isOpaque = false 
        titlewalllbl.text! = "Certified \n Training Members"
        titlewalllbl.sizeToFit()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
