//
//  DescriptionTableCell.swift
//  MECA
//
//  Created by Macbook  on 29/05/21.
//

import UIKit

class DescriptionTableCell: UITableViewCell {
    @IBOutlet weak var lbldescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sizeToFit()
           layoutIfNeeded()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "DescriptionTableCell", bundle: nil)
    }
    func setEventData(dataEvent:Detailsinfo) {
        lbldescription.text = dataEvent.description

    }
    func setpdcainfoData(dataEvent:PdcaedetailModel) {
        lbldescription.text = dataEvent.description

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
