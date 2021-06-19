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
    var viewcontrollerHome = UIViewController()
    var index: Int = 0
    var autoScrollTimer:Timer?
    
    // MARK: - Constants
    let cellWidth = UIScreen.main.bounds.width
    let sectionSpacing = 0
    let cellSpacing = 0
    let layout = PagingCollectionViewLayout()
    
    // MARK: - UI Components
    
    lazy var collectionviewPager: UICollectionView = {
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: CGFloat(sectionSpacing), bottom: 0, right: CGFloat(sectionSpacing))
        layout.itemSize = CGSize(width: cellWidth, height: viewImgCollection.frame.size.height)
        layout.minimumLineSpacing = CGFloat(cellSpacing)
        let collectionView = UICollectionView(frame:viewImgCollection.frame , collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.decelerationRate = .fast
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionviewPager.register(UINib.init(nibName: "newHomePagerCVCell", bundle: nil), forCellWithReuseIdentifier: "newHomePagerCVCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCell(objFeed:NewHomeData, arrID:[NewHomeData])  {
        print(objFeed)
        if let imgAvtar = objFeed.avatar{
            imgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgProfile.sd_setImage(with: URL.init(string: BaseURL + imgAvtar), completed: nil)
        }
        if objFeed.type == 1{
            
            if let imgFeed = objFeed.images{
                if imgFeed.count > 0 {
                    arrImgPage.removeAll()
                    for obj in imgFeed{
                        arrImgPage.append(obj)
                    }
                    viewImgCollection.isHidden = false
                    self.imgFeed.isHidden = true
                    startTimer()
                    imgPageControl.numberOfPages = arrImgPage.count
                    imgPageControl.currentPage = 0
                    applyConstraints()
                    collectionviewPager.reloadData()
                }
                buttonPlayOutlet.isHidden = true
//                self.imgFeed.sd_imageIndicator = SDWebImageActivityIndicator.gray
                
            }
        }else{
            viewImgCollection.isHidden = true
            self.imgFeed.isHidden = false
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
        
        if arrID.count > 0 {
            for objDict in arrID {
                if objDict.id == objFeed.id{
                    if objDict.likes! > 1{
                        lblLikeCount.text = String(objDict.likes ?? 0) + " Likes"
                    }else{
                        if objDict.likes! >= 0 {
                            lblLikeCount.text = String(objDict.likes ?? 0) + " Like"
                        }
                    }
                    let islike = objDict.isLiked
                    if islike == 0{
                        
                        imgLike.image = #imageLiteral(resourceName: "Like_BlueBorder")
                        
                    }else{
                        imgLike.image = #imageLiteral(resourceName: "likes_Blue")
                    }
                }else{
                    if objFeed.likes! > 1{
                        lblLikeCount.text = String(objFeed.likes ?? 0) + " Likes"
                    }else{
                        if objDict.likes! >= 0 {
                            lblLikeCount.text = String(objDict.likes ?? 0) + " Like"
                        }
                    }
                    let islike = objFeed.isLiked
                    if islike == 0{
                        
                        imgLike.image = #imageLiteral(resourceName: "Like_BlueBorder")
                        
                    }else{
                        imgLike.image = #imageLiteral(resourceName: "likes_Blue")
                    }
                }
            }
            
        }else{
            if objFeed.likes! > 1{
                lblLikeCount.text = String(objFeed.likes ?? 0) + " Likes"
            }else{
                if objFeed.likes! >= 0 {
                    lblLikeCount.text = String(objFeed.likes ?? 0) + " Like"
                }
            }
            let islike = objFeed.isLiked
            if islike == 0{
                
                imgLike.image = #imageLiteral(resourceName: "Like_BlueBorder")
                
            }else{
                imgLike.image = #imageLiteral(resourceName: "likes_Blue")
            }
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
    
    private func applyConstraints() {
        
        self.viewImgCollection.addSubview(collectionviewPager)
        collectionviewPager.translatesAutoresizingMaskIntoConstraints = false
        collectionviewPager.topAnchor.constraint(equalTo: self.viewImgCollection.topAnchor).isActive = true
        collectionviewPager.bottomAnchor.constraint(equalTo: self.viewImgCollection.bottomAnchor).isActive = true
        collectionviewPager.leadingAnchor.constraint(equalTo: self.viewImgCollection.leadingAnchor, constant: 0).isActive = true
        collectionviewPager.trailingAnchor.constraint(equalTo: self.viewImgCollection.trailingAnchor, constant: 0).isActive = true
    }
    
    func startTimer() {

        _ =  Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }


    @objc func scrollAutomatically(_ timer1: Timer) {

        index = index + 1
        index = index >= arrImgPage.count ? 0 : index
        collectionviewPager.scrollToItem(at: IndexPath.init(row: index, section: 0), at: .centeredHorizontally, animated: true)

    }
}

extension HomeNewsFeedTVCell:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionviewPager.dequeueReusableCell(withReuseIdentifier: "newHomePagerCVCell", for: indexPath) as! newHomePagerCVCell
        let obj = arrImgPage[indexPath.row]
        cell.imgFeed.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imgFeed.sd_setImage(with: URL.init(string: BaseURL + obj), completed: nil)
        if arrImgPage.count > 1 {
            cell.pageContrl.numberOfPages = arrImgPage.count
            cell.pageContrl.isHidden = false
        }else{
            cell.pageContrl.isHidden = true

        }
        cell.pageContrl.currentPage = indexPath.row
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImgPage.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionviewPager.frame.width, height: collectionviewPager.frame.height)
    }
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
}
