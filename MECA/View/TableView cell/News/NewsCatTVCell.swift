//
//  NewsCatTVCell.swift
//  MECA
//


import UIKit
import SDWebImage
class NewsCatTVCell: UITableViewCell {

    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var btnPlayOutlet: UIButton!
    @IBOutlet weak var lblWriterName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTags: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgCover.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imgCover.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCell(objList: NewsListData)  {
        print(objList)
        if let imgUrl = objList.cover_image{
            let url = BaseURL + imgUrl
            self.imgCover.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgCover.sd_setImage(with: URL.init(string: url), completed: nil)
            
            lblWriterName.text = objList.writer_name
            
            lblTitle.text = objList.title
            
            let strDate = NSString.convertFormatOfDate(date: objList.created_at ?? "", originalFormat: "yyyy-mm-dd HH:mm:ss", destinationFormat: "dd MMMM yyyy")

            lblDate.text = strDate
           
            if let arrTag = objList.tags{
                print(arrTag)
                let formattedArray = (arrTag.map{String($0)}).joined(separator: ", ")


                lblTags.text = formattedArray
            }
        }
    }
    
    func setCellVideoNews(objList: Videos_News)  {
        print(objList)
        btnPlayOutlet.isHidden = false
            
            lblWriterName.text = objList.writer_name
            
            lblTitle.text = objList.title
            
            let strDate = NSString.convertFormatOfDate(date: objList.created_at ?? "", originalFormat: "yyyy-mm-dd HH:mm:ss", destinationFormat: "dd MMMM yyyy")

            lblDate.text = strDate
           
            if let arrTag = objList.tags{
                print(arrTag)
                let formattedArray = (arrTag.map{String($0)}).joined(separator: ", ")
                lblTags.text = formattedArray
            }
        let urlYoutube = objList.video_link
        let urlID = urlYoutube?.youtubeID
        let urlStr = "http://img.youtube.com/vi/\(urlID ?? "")/1.jpg"
        let url = URL(string: urlStr)!
        self.imgCover.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imgCover.sd_setImage(with: url, completed: nil)
    }
    }

