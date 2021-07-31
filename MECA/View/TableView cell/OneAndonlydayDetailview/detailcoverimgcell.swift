//
//  detailcoverimgcell.swift
//  MECA
//
//  Created by Macbook  on 05/07/21.
//

import UIKit
import SDWebImage
class detailcoverimgcell: UITableViewCell {
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var btnBackOutlet: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static func nib() -> UINib {
        return UINib(nibName: "detailcoverimgcell", bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setoneandonlyData(dataoneandonly:KaizenInfoDataModel) {
        
        if dataoneandonly.cover_image != "" {
            let imgURL = BaseURL + dataoneandonly.cover_image!
            imgCover.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgCover.sd_setImage(with: URL(string:imgURL), completed: nil)
        }
        let convertedFormat = GlobalObj.convertToString(dateString: dataoneandonly.created_at!)
        lblTitle.text = dataoneandonly.title!
        
        lblStartDate.text = convertedFormat
        
    }
}
