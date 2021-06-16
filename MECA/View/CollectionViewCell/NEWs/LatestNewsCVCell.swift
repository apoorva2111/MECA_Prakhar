

import UIKit
import SDWebImage
class LatestNewsCVCell: UICollectionViewCell {

    @IBOutlet weak var lblWriterName: UILabel!
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnPlayVideo: UIButton!
    @IBOutlet weak var lblTags: UILabel!
    @IBOutlet weak var viewBG: RCustomView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgNews.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imgNews.layer.cornerRadius = 12
    }
    func setCell(objDict:NSDictionary){
        print(objDict)
        if let video = objDict["catTitle"] as? String {
            if let imgUrl = objDict["cover_image"] as? String{
                let url = BaseURL + imgUrl
                self.imgNews.sd_imageIndicator = SDWebImageActivityIndicator.gray
                imgNews.sd_setImage(with: URL.init(string: url), completed: nil)
            }
            if video == "Videos"{
                //
                let urlYoutube = objDict["video_link"] as? String
                let urlID = urlYoutube?.youtubeID
                let urlStr = "http://img.youtube.com/vi/\(urlID ?? "")/1.jpg"
                let url = URL(string: urlStr)!
                self.imgNews.sd_imageIndicator = SDWebImageActivityIndicator.gray
                
                imgNews.sd_setImage(with: url, completed: nil)
              
                btnPlayVideo.isHidden = false
            }else{
                btnPlayVideo.isHidden = true
            }
        }
        
        
        lblTitle.text = objDict["title"] as? String
        lblWriterName.text = objDict["writer_name"] as? String
        let convertedFormat =  GlobalObj.convertToString(dateString: objDict["created_at"] as? String ?? "")
        lblDate.text = convertedFormat
        
        if let arrTag = objDict["tags"]{
            print(arrTag)
           // let formattedArray = (arrTag.map{String($0)}).joined(separator: ", ")

           // lblTags.text = formattedArray
        }
       
    }
    
    func setListCell(objDict:NewsListData){
        print(objDict)
        btnPlayVideo.isHidden = true
        if let imgUrl = objDict.cover_image{
                let url = BaseURL + imgUrl
                self.imgNews.sd_imageIndicator = SDWebImageActivityIndicator.gray
                imgNews.sd_setImage(with: URL.init(string: url), completed: nil)
            }

        
        
        lblTitle.text = objDict.title
        lblWriterName.text = objDict.writer_name
        let convertedFormat =  GlobalObj.convertToString(dateString: objDict.created_at ?? "")
        lblDate.text = convertedFormat
        
        if let arrTag = objDict.tags{
            print(arrTag)
            let formattedArray = (arrTag.map{String($0)}).joined(separator: ", ")
            lblTags.text = formattedArray
        }
       
    }
    
    func setNewsDetailCell(objDict:Related){
        print(objDict)
        btnPlayVideo.isHidden = true
        if let imgUrl = objDict.cover_image{
            let url = BaseURL + imgUrl
            self.imgNews.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgNews.sd_setImage(with: URL.init(string: url), completed: nil)
        }
        lblTitle.text = objDict.title
        lblWriterName.text = objDict.category
        let convertedFormat = NSString.convertFormatOfDate(date: objDict.created_at ?? "", originalFormat: "yyyy-mm-dd HH:mm:ss", destinationFormat: "dd MMMM yyyy")

        lblDate.text = convertedFormat
        
        if let arrTag = objDict.tags{
            print(arrTag)
            let formattedArray = (arrTag.map{String($0)}).joined(separator: ", ")


            lblTags.text = formattedArray
        }
       
    }
    
}

