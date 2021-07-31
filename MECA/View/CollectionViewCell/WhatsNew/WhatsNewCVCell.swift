//
//  WhatsNewCVCell.swift
//  MECA
//
//  Created by Apoorva Gangrade on 21/07/21.
//

import UIKit
import SDWebImage
class WhatsNewCVCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgWhatsNew: RCustomImageView!
    @IBOutlet weak var imgview:GradientView!
    override func awakeFromNib() {
        super.awakeFromNib()
//        let maskLayer = CAGradientLayer(layer: imgWhatsNew.layer)
//        maskLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
//        maskLayer.startPoint = CGPoint(x: 0, y: 1.5)
//        maskLayer.endPoint = CGPoint(x: 0, y: 0)
//        maskLayer.frame = fram
//        imgWhatsNew.layer.mask = maskLayer
//        imgWhatsNew.contentMode =  .scaleToFill
        imgview.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        imgview.layer.cornerRadius = 10
    }
    func setCell(feed: Data_Home) {
        print(feed)
        lblTitle.text = feed.title
        if feed.cover_image != "" {
            let imgUrl = BaseURL + feed.cover_image!
            imgWhatsNew.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgWhatsNew.sd_setImage(with: URL(string: imgUrl), completed: nil)
        }
    }
   
}

