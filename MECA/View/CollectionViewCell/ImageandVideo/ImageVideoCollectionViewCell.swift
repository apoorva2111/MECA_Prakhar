//
//  ImageVideoCollectionViewCell.swift
//  MECA
//
//  Created by Mohammed Sulaiman on 21/03/21.
//

import UIKit

class ImageVideoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var baseView: RCustomView!
    @IBOutlet weak var playBtnRef: UIButton!
    @IBOutlet weak var myImageView: RCustomImageView!
    
    var playVideo:(() -> ())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func onClickPlay(_ sender: UIButton) {
        self.playVideo?()
    }
}
