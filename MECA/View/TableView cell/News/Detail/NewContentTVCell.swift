

import UIKit

class NewContentTVCell: UITableViewCell {

    @IBOutlet weak var btnReadMoreOutlet: UIButton!
    @IBOutlet weak var lblContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setNewsContentData(grData:NewsDetail_Data){
        lblContent.text = grData.plain_description?.html2String
        
    }
    
    func setNewsVideoData(grData:VideoInfoData){
        print(grData)
        lblContent.text = grData.plain_description?.html2String

        
    }
}

