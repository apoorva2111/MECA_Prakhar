
import UIKit
import SDWebImage
class NewsImageTVCell: UITableViewCell {
    @IBOutlet weak var imgTOp: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var btnPlayOutlet: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setNewsImgData(grData:NewsDetail_Data){
        btnPlayOutlet.isHidden = true
        let imgURL = BaseURL + grData.cover_image!
        imgTOp.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imgTOp.sd_setImage(with: URL(string:imgURL), completed: nil)
        
        lblTitle.text = grData.title
        let startDate = NSString.convertFormatOfDate(date: grData.created_at ?? "", originalFormat: "yyyy-mm-dd HH:mm:ss", destinationFormat: "dd MMMM yyyy")
        lblDate.text = startDate
        
        if let arrTag = grData.tags{
            print(arrTag)
            let strTag = arrTag.joined(separator: ",")
            lblTag.text = strTag
        }
        
    }
    
    
    func setNewsVideoData(grData:VideoInfoData){
        btnPlayOutlet.isHidden = false
        lblTitle.text = grData.title
        let startDate = NSString.convertFormatOfDate(date: grData.created_at ?? "", originalFormat: "yyyy-mm-dd HH:mm:ss", destinationFormat: "dd MMMM yyyy")
        lblDate.text = startDate
        
        if let arrTag = grData.tags{
            print(arrTag)
            let strTag = arrTag.joined(separator: ",")
            lblTag.text = strTag
        }
        
        let urlYoutube = grData.video_link
        let urlID = urlYoutube?.youtubeID
        let urlStr = "http://img.youtube.com/vi/\(urlID ?? "")/1.jpg"
        let url = URL(string: urlStr)!
        self.imgTOp.sd_imageIndicator = SDWebImageActivityIndicator.gray
        
        imgTOp.sd_setImage(with: url, completed: nil)
    }
}

