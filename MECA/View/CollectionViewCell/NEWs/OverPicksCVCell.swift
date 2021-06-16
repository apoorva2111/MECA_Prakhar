

import UIKit
import SDWebImage
class OverPicksCVCell: UICollectionViewCell {

    @IBOutlet weak var imgPicks: RCustomImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(objDict:Ourpicks) {
        self.imgPicks.sd_imageIndicator = SDWebImageActivityIndicator.gray
        
        if let imgUrl = objDict.cover_image{
            let url = BaseURL + imgUrl
            self.imgPicks.sd_setImage(with: URL.init(string: url), completed: nil)
        }
    }
}
