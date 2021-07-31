//
//  SpecialsiteLinkCell.swift
//  MECA
//
//  Created by Macbook  on 20/07/21.
//

import UIKit
import SDWebImage
class SpecialsiteLinkCell: UICollectionViewCell {
    @IBOutlet weak var imgSpecialsite: RCustomImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setspecialsiteCell(objDict:Special_sites) {
        self.imgSpecialsite.sd_imageIndicator = SDWebImageActivityIndicator.gray
        
        if let imgUrl = objDict.img{
            let url = BaseURL + imgUrl
            print("urlsite \(url)")
            self.imgSpecialsite.sd_setImage(with: URL.init(string: url), completed: nil)
        }
    }
}
