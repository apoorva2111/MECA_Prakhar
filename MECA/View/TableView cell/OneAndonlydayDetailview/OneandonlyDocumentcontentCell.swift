//
//  OneandonlyDocumentcontentCell.swift
//  MECA
//
//  Created by Macbook  on 06/07/21.
//

import UIKit

class OneandonlyDocumentcontentCell: UITableViewCell {
    @IBOutlet weak var btnDownloadOutlet: UIButton!
    @IBOutlet weak var txtPresentation: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        txtPresentation.layer.borderWidth = 1
        txtPresentation.layer.borderColor = UIColor.getCustomBlueColor().cgColor
        txtPresentation.layer.cornerRadius = 4
        btnDownloadOutlet.setImage(#imageLiteral(resourceName: "download Documents_Blue"), for: .normal)
        txtPresentation.textColor = UIColor.getCustomBlueColor()
        // Initialization code
    }
    static func nib() -> UINib {
        return UINib(nibName: "OneandonlyDocumentcontentCell", bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
