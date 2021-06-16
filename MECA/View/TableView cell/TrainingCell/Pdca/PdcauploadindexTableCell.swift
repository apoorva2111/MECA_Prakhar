//
//  PdcauploadindexTableCell.swift
//  MECA
//
//  Created by Macbook  on 04/06/21.
//

import UIKit

class PdcauploadindexTableCell: UITableViewCell {
   
    @IBOutlet weak var txtnamelbl: UILabel!
    @IBOutlet weak var txtstatuslbl: UILabel!
    var trainingdetailVC : TrainingdetailVC!
    var trainingvm : TrainingDetailVM!
    override func awakeFromNib() {
        super.awakeFromNib()
        txtnamelbl.sizeToFit()
        txtstatuslbl.sizeToFit()
        // Initialization code
    }
    func setpdcauploaddatainfo(pdcavideodata:Pdca_uploadModel) {
        
                    if pdcavideodata.display_lable_text != "" {
                        txtnamelbl.text! = pdcavideodata.display_lable_text!
                    }
                if pdcavideodata.display_status_text != "" {
                    txtstatuslbl.text! = pdcavideodata.display_status_text!
        
                }
                if pdcavideodata.text_color != "" {
                   txtstatuslbl.textColor = UIColor.hexStringToUIColor(hex: pdcavideodata.text_color!)
                }
        
    }
    static func nib() -> UINib {
        return UINib(nibName: "PdcauploadindexTableCell", bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
