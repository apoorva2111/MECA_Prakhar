//
//  PdcaindexCell.swift
//  MECA
//
//  Created by Macbook  on 04/06/21.
//

import UIKit

class PdcaindexCell: UITableViewCell {
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    @IBOutlet weak var pdcavideotblDocument: UITableView!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnDownloadOutlet: UIButton!
    @IBOutlet weak var txttitlelbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setpdcauplodadatainfo(pdcavideodata:sessionFilemodel) {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
