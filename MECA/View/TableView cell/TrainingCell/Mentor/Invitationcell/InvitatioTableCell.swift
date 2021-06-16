//
//  InvitatioTableCell.swift
//  MECA
//
//  Created by Macbook  on 28/05/21.
//

import UIKit

class InvitatioTableCell: UITableViewCell {
    @IBOutlet weak var btnDownloadOutlet: UIButton!
    @IBOutlet weak var txtPresentation: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      //  txtPresentation.layer.borderWidth = 1
       
        txtPresentation.layer.cornerRadius = 4
        btnDownloadOutlet.setImage(#imageLiteral(resourceName: "download Documents_Blue"), for: .normal)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static func nib() -> UINib {
        return UINib(nibName: "InvitatioTableCell", bundle: nil)
    }
}
