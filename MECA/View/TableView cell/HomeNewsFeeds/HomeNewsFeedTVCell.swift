//
//  HomeNewsFeedTVCell.swift
//  MECA
//


import UIKit
import SDWebImage
class HomeNewsFeedTVCell: UITableViewCell {

    @IBOutlet weak var imgProfile: RCustomImageView!
    @IBOutlet weak var btnMoreOutlet: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgFeed: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnLikeUnlikeOutlet: UIButton!
    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var btnLikeOutlet: UIButton!
    @IBOutlet weak var lblCommentCount: UILabel!
    @IBOutlet weak var btnCommentOutllet: UIButton!
    @IBOutlet weak var btnSeeMoreOutlet: UIButton!
    @IBOutlet weak var viewImgCollection: UIView!
    @IBOutlet weak var imgPageControl: UIPageControl!
    @IBOutlet weak var buttonPlayOutlet: UIButton!
    @IBOutlet weak var viewLike: UIView!
    @IBOutlet weak var viewComment: UIView!
    @IBOutlet weak var viewCommentHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewLikeHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var lblLine: UILabel!
    var arrImgPage = [String]()
    var arrImage = [UIImageView]()
    var pagerController = UserImagesPagerController()
    var viewcontrollerHome = UIViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCell(objFeed:NewHomeData)  {
        print(objFeed)
        if let imgAvtar = objFeed.avatar{
            imgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgProfile.sd_setImage(with: URL.init(string: BaseURL + imgAvtar), completed: nil)
        }
        if objFeed.type == 1{
            
            if let imgFeed = objFeed.images{
//                if imgFeed.count > 0 {
//                    arrImgPage = imgFeed
//                    createImagePagerControllers()
//                }
                buttonPlayOutlet.isHidden = true
                self.imgFeed.sd_imageIndicator = SDWebImageActivityIndicator.gray
                self.imgFeed.sd_setImage(with: URL.init(string: BaseURL + imgFeed[0]), completed: nil)
               
            }
        }else{
            let videoLink = objFeed.video_link
            let urlID = videoLink?.youtubeID
            let urlStr = "http://img.youtube.com/vi/\(urlID ?? "")/1.jpg"
            let url = URL(string: urlStr)!
            imgFeed.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgFeed.sd_setImage(with: url, completed: nil)
            buttonPlayOutlet.isHidden = false
        }
        
        lblName.text = objFeed.writer_name
        lblDescription.text = objFeed.content
        if lblDescription.text!.count >= 100 {
            btnSeeMoreOutlet.isHidden = false
        }else{
            btnSeeMoreOutlet.isHidden = true
        }
   
        if objFeed.likes! > 1{
            lblLikeCount.text = String(objFeed.likes ?? 0) + " Likes"
        }else{
            lblLikeCount.text = String(objFeed.likes ?? 0) + " Like"

        }
        let islike = objFeed.isLiked
        if islike == 0{
            imgLike.image = #imageLiteral(resourceName: "Like_BlueBorder")
        }else{
            imgLike.image = #imageLiteral(resourceName: "likes_Blue")
        }
        if objFeed.comments_count! > 1{
        lblCommentCount.text = String(objFeed.comments_count ?? 0) + " Comments"
        }else{
            lblCommentCount.text = String(objFeed.comments_count ?? 0) + " Comment"
        }
         if objFeed.isOwner == 0 && objFeed.document_link == "" {
            btnMoreOutlet.isHidden = true
         }else{
            btnMoreOutlet.isHidden = false

         }
    }
    
    func createImagePagerControllers(){
        var imageControllers = [UIViewController]()
        imgPageControl.numberOfPages = arrImgPage.count

        arrImage.removeAll()
       // if viewModel.items.count > 0{
            for image in arrImgPage{
                let controller = UIViewController()
                controller.view.backgroundColor = .clear
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImgCollection.frame.size.width, height: viewImgCollection.frame.size.height))
                imageView.contentMode = .scaleAspectFill

                imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray

                //imageView.sd_setImage(with: URL(string: image.url), completed: nil)
                let url = BaseURL + image
                imageView.sd_setImage(with: URL(string: url), placeholderImage:nil)

                if arrImage.contains(imageView){
                    
                }else{
                    arrImage.append(imageView)
                }
                
                controller.view.clipsToBounds = true
                imageView.clipsToBounds = true
                controller.view.addSubview(imageView)
                
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
                imageView.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
                imageView.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor).isActive = true
                imageView.topAnchor.constraint(equalTo: controller.view.topAnchor).isActive = true
                
                imageControllers.append(controller)

            }
       // }
        
        viewcontrollerHome.removeChilds()
        pagerController.dismiss(animated: true, completion: nil)
        pagerController = UserImagesPagerController()
        pagerController.viewControllers = imageControllers
        pagerController.userImagesDelegate = self
        viewcontrollerHome.configureChildViewController(childController: pagerController, onView: viewImgCollection)
        
    }
    
}

extension HomeNewsFeedTVCell:UserImagesPagerControllerDelegate{
    func didScrollToPosition(_ position: Int) {
        //TODO: PAINT PAGER INDICATOR
        print("scrolled to position \(position)")
       imgPageControl.currentPage = position
    }
}
