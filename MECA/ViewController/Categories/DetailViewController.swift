

import UIKit
import SDWebImage
import AVFoundation
import AVKit

class DetailViewController: UIViewController {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var DismissRefBtn: UIButton!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var toyota2021TitleLabel: UILabel!
    @IBOutlet weak var separatorLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var startView: RCustomView!
    @IBOutlet weak var dateIcon: UIImageView!
    @IBOutlet weak var eventStartDateLabel: UILabel!
    @IBOutlet weak var eventStartDayLabel: UILabel!
    @IBOutlet weak var timeIcon: UIImageView!
    @IBOutlet weak var eventStartTimeLabel: UILabel!
    @IBOutlet weak var eventStartTime2Label: UILabel!
    @IBOutlet weak var endView: RCustomView!
    @IBOutlet weak var endDateIcon: UIImageView!
    @IBOutlet weak var eventEndDateLabel: UILabel!
    @IBOutlet weak var eventEndDaylabel: UILabel!
    @IBOutlet weak var endTimeIcon: UIImageView!
    @IBOutlet weak var eventEndTimeLabel: UILabel!
    @IBOutlet weak var eventEndTime2Label: UILabel!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var mapView: RCustomView!
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var aboutEventLabel: UILabel!
    @IBOutlet weak var eventSubTitleLabel: UILabel!
    @IBOutlet weak var readMoreRefBtn: UIButton!
    @IBOutlet weak var imageandVideoView: UIView!
    @IBOutlet weak var surveyLinkLabel: UILabel!
    @IBOutlet weak var surveyLinkRefBtn: UIButton!
    @IBOutlet weak var imagelabelRef: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var videoTitleRef: UILabel!
    @IBOutlet weak var videoCollectionView: UICollectionView!
    @IBOutlet weak var eventContentsLabel: UILabel!
    @IBOutlet weak var presentation1TextField: UITextField!
    @IBOutlet weak var downloadDoc1RefBtn: UIButton!
    @IBOutlet weak var presentation2TextField: UITextField!
    @IBOutlet weak var downloadDoc2RefBtn: UIButton!
    @IBOutlet weak var videoLinklabel: UILabel!
 
    @IBOutlet weak var videoLinkImg1: UIImageView!
    @IBOutlet weak var videoLinkImg2: UIImageView!
    @IBOutlet weak var videoLinkTitle1: UILabel!
    @IBOutlet weak var videoLinkTitle2: UILabel!
    @IBOutlet weak var videoLinkInfo1: UILabel!
    @IBOutlet weak var videoLinkInfo2: UILabel!
    @IBOutlet weak var videoLink1: UILabel!
    @IBOutlet weak var videoLink2: UILabel!
    @IBOutlet weak var viewVedioLink1: RCustomView!
    @IBOutlet weak var viewVideoLink2: RCustomView!
    
    @IBOutlet weak var videoLinkSeeMoreBtn: UIButton!
    @IBOutlet weak var viewVideoLink: UIView!
    @IBOutlet weak var viewVideoLinkHeightConstraint: NSLayoutConstraint!
  
    @IBOutlet weak var viewVideoLinkTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var documentLinkRefBtn1: UIButton!
    @IBOutlet weak var documentLinkRefBtn2: UIButton!
    @IBOutlet weak var documentLinkSeeMoreBtn1: UIButton!
    @IBOutlet weak var viewDocumentLinkTOpConstrainrt: NSLayoutConstraint!
    @IBOutlet weak var viewDocumentLinkHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var viewDocumentLink: UIView!
    
    @IBOutlet weak var CommentsLikeView: UIView!
    @IBOutlet weak var likeIcon: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentIcon: UIImageView!
    @IBOutlet weak var commentlabel: UILabel!
    @IBOutlet weak var likeBtnRef: UIButton!
    @IBOutlet weak var commentBtnRef: UIButton!
    @IBOutlet weak var separatorlabel3: UILabel!
    
    @IBOutlet weak var viewSurvayLinkHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var viewImagCollection: UIView!
    @IBOutlet weak var viewImgCollectHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var viewVideoCollection: UIView!
   
    @IBOutlet weak var viewViideoHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var locationviewHeightConstraint: NSLayoutConstraint!
 
    @IBOutlet weak var viewLinkTopContraint: NSLayoutConstraint!
    
    @IBOutlet weak var viewImgTopConstrint: NSLayoutConstraint!
    @IBOutlet weak var viewVideoTopCOnstrint: NSLayoutConstraint!
    
    @IBOutlet weak var viewImgPreview: UIView!
 
    @IBOutlet weak var imgPreview: UIImageView!
    @IBOutlet weak var viewEventContent: UIView!
    @IBOutlet weak var viewEventContentHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewEvenContentOne: UIView!
    @IBOutlet weak var viewEvenContentTwo: UIView!
    @IBOutlet weak var seeMoreEventContentOutlet: UIButton!
    @IBOutlet weak var viewEventTopConstraint: NSLayoutConstraint!
  
    @IBOutlet weak var tblVideoLink: UITableView!
    @IBOutlet weak var tblVideoLinkHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tblDocumentLink: UITableView!
    @IBOutlet weak var tblDocumentLinkHeightConstraint: NSLayoutConstraint!
    var navValue = ""
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var eventID = ""
	var isEvent = false

    var arrcatImg = [UIImage.init(named: "News"),UIImage.init(named: "MEBIT"),UIImage.init(named: "MaaS"),UIImage.init(named: "Hydrogen"),UIImage.init(named: "SDGs"),UIImage.init(named: "GR")]
    
    
    
    //Api Array
    var viewModel : EventInfoVM!
    var viewModel1 : KaizenVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        viewImgPreview.isHidden = true
        
        tblVideoLink.register(VideoLinkTableViewCell.nib(), forCellReuseIdentifier: "VideoLinkTableViewCell")
      
        tblDocumentLink.register(DetailDocumentLinkTVCell.nib(), forCellReuseIdentifier: "DetailDocumentLinkTVCell")

        
        tblVideoLink.delegate = self
        tblVideoLink.dataSource = self
        tblDocumentLink.delegate = self
        tblDocumentLink.dataSource = self


        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")

        self.videoCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")

        if navValue == "0" {
            //rootVC : Home vc
            print("From Home VC")
            if isEvent
            {
                self.imageCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")

                self.videoCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")

                viewModel = EventInfoVM.init(controller: self)
                viewModel.callEventInfoWebservice()
                
            }
            else
            {
                viewModel1 = KaizenVM.init(controller: self)
                viewModel1.callKaizenInfoWebservice { (info) in
                    if info == true{
                        if self.viewModel1.arrEventImg.count>0{
                            self.imageCollectionView.delegate = self
                            self.imageCollectionView.dataSource = self
                            self.imageCollectionView.reloadData()
                        }
                        
                        if self.viewModel1.arrEventVideos.count>0{
                            self.videoCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")
                            self.videoCollectionView.dataSource = self
                            self.videoCollectionView.delegate = self
                            self.videoCollectionView.delegate = self
                            self.videoCollectionView.dataSource = self
                            self.videoCollectionView.reloadData()
                        }
                    }
                }
            }
            
        }
        else if navValue == "1" {
            //root VC : MEBIT VC
         
            if isEvent
            {
                self.imageCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")

                self.videoCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")
                
                viewModel = EventInfoVM.init(controller: self)
                viewModel.callEventInfoWebservice()
            }
            else
            {
                viewModel1 = KaizenVM.init(controller: self)
                viewModel1.callKaizenInfoWebservice { (info) in
                    if info == true{
                        if self.viewModel1.arrEventImg.count>0{
                          //  self.imageCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")

                            self.imageCollectionView.delegate = self
                            self.imageCollectionView.dataSource = self
                            self.imageCollectionView.reloadData()
                        }
                        
                        if self.viewModel1.arrEventVideos.count>0{
                          //  self.videoCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")

                            self.videoCollectionView.delegate = self
                            self.videoCollectionView.dataSource = self
                            self.videoCollectionView.reloadData()
                        }
                    }
                }
            }
        }else{
            viewModel1 = KaizenVM.init(controller: self)
            viewModel1.callKaizenInfoWebservice { (info) in
                if info == true{
                    if self.viewModel1.arrEventImg.count>0{
                        self.imageCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")

                        self.imageCollectionView.delegate = self
                        self.imageCollectionView.dataSource = self
                        self.imageCollectionView.reloadData()
                    }
                    
                    if self.viewModel1.arrEventVideos.count>0{
                        self.videoCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")

                        self.videoCollectionView.delegate = self
                        self.videoCollectionView.dataSource = self
                        self.videoCollectionView.reloadData()
                    }
                }        }
            
            
        }
        setupUI()

    }

    func setupUI() {
        presentation1TextField.layer.borderWidth = 1
        presentation1TextField.layer.borderColor = #colorLiteral(red: 0.9803921569, green: 0.6235294118, blue: 0.2039215686, alpha: 1)
        presentation1TextField.layer.cornerRadius = 4
        presentation2TextField.layer.borderWidth = 1
        presentation2TextField.layer.borderColor = #colorLiteral(red: 0.9803921569, green: 0.6235294118, blue: 0.2039215686, alpha: 1)
        presentation2TextField.layer.cornerRadius = 4
        likeBtnRef.layer.cornerRadius = 15
        commentBtnRef.layer.cornerRadius = 15
        
        let layoutImg: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
        layoutImg.itemSize = CGSize(width: screenWidth/2, height: 120)
        layoutImg.minimumInteritemSpacing = 0
        layoutImg.minimumLineSpacing = 0
        layoutImg.scrollDirection = .horizontal
        imageCollectionView!.collectionViewLayout = layoutImg
        imageCollectionView.reloadData()
        
        let layoutVideo: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
        layoutVideo.itemSize = CGSize(width: screenWidth/2, height: 120)
        layoutVideo.minimumInteritemSpacing = 0
        layoutVideo.minimumLineSpacing = 0
        layoutVideo.scrollDirection = .horizontal
        videoCollectionView!.collectionViewLayout = layoutVideo
        videoCollectionView.reloadData()
    }
   

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
        {
            let touch = touches.first
            if touch?.view != self.imgPreview
            {
                self.viewImgPreview.isHidden = true
            }
        }
    
    @IBAction func onClickDismissVC(_ sender: UIButton) {
       // self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func onClickReadMore(_ sender: UIButton) {
        if isEvent
        {
        if viewModel.strdescription != ""{
            let vc = FlowController().instantiateViewController(identifier: "AboutDetailVC", storyBoard: "Category") as! AboutDetailVC
            vc.strdescrtiption = viewModel.strdescription
            //vc.navigationController?.pushViewController(vc, animated: true)
            vc.modalPresentationStyle = .fullScreen

            self.present(vc, animated: true, completion: nil)
            
        }
        }else{
            if viewModel1.strdescription != ""{
                let vc = FlowController().instantiateViewController(identifier: "AboutDetailVC", storyBoard: "Category") as! AboutDetailVC
                vc.strdescrtiption = viewModel1.strdescription
                //vc.navigationController?.pushViewController(vc, animated: true)
                vc.modalPresentationStyle = .fullScreen

                self.present(vc, animated: true, completion: nil)
                
            }
        }
    }
   
    
    
    @IBAction func onClickSurveyLink(_ sender: UIButton) {
    }
    
    @IBAction func onClickDownloadDoc1(_ sender: UIButton) {
    }
    
    @IBAction func onClickDownloadDov2(_ sender: UIButton) {
    }
    
    
    @IBAction func onClickVideoLink(_ sender: UIButton) {
    }
    
    @IBAction func onClickLike(_ sender: UIButton) {
    }
    
    @IBAction func onClickComment(_ sender: UIButton) {
    }
    
}
//MARK:- UICollectionView
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if navValue == "0" {
            //rootVC : Home vc
            if isEvent
            {
                if collectionView == imageCollectionView{
                    return viewModel.arrEventImg.count
                }else{
                    return viewModel.arrEventVideos.count
                }
                
            }
            else
            {
                if collectionView == imageCollectionView{
                    return viewModel1.arrEventImg.count
                }else{
                    return viewModel1.arrEventVideos.count
                }
            }

        }
        else if navValue == "1" {
            //root VC : MEBIT VC
            if isEvent
            {
                if collectionView == imageCollectionView{
                    return viewModel.arrEventImg.count
                }else{
                    return viewModel.arrEventVideos.count
                }
                
            }
            else
            {
                if collectionView == imageCollectionView{
                    return viewModel1.arrEventImg.count
                }else{
                    return viewModel1.arrEventVideos.count
                }
            }
        }else{
            if collectionView == imageCollectionView{
                return viewModel1.arrEventImg.count
            }else{
                return viewModel1.arrEventVideos.count
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if navValue == "0" {
            if isEvent{
                
                if (collectionView == imageCollectionView) {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageVideoCollectionViewCell", for: indexPath) as! ImageVideoCollectionViewCell
                    cell.isHidden = false
                    let objImage = viewModel.arrEventImg[indexPath.row]
                    if objImage.file != ""{
                        let url = BaseURL + (objImage.file)!
                        cell.myImageView.sd_setImage(with: URL(string:url), completed: nil)
                    }else{
                        cell.myImageView.image = UIImage(named: "image 1")
                    }
                    
                    cell.playBtnRef.isHidden = true
                    return cell
                }
                else if (collectionView == videoCollectionView) {
                    let cell1  = videoCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageVideoCollectionViewCell", for: indexPath) as! ImageVideoCollectionViewCell
                    
                    let objImage = viewModel.arrEventVideos[indexPath.row]
                    if objImage.file != ""{
                        let urlimg = BaseURL + (objImage.file)!
                        let url = URL(string: urlimg)!
                        
                        if let thumbnailImage = getThumbnailImage(forUrl: url) {
                            cell1.myImageView.image = thumbnailImage
                        }
                    }
                    
                    
                    cell1.playBtnRef.isHidden = false
                    cell1.playVideo = {
                        print("Video is atpped")
                    }
                    return cell1
                }
            }else{
                
                if (collectionView == imageCollectionView) {
                    let cell  = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageVideoCollectionViewCell", for: indexPath) as! ImageVideoCollectionViewCell
                    let objImage = viewModel1.arrEventImg[indexPath.row]
                    if objImage.file != ""{
                        let url = BaseURL + (objImage.file)!
                        cell.myImageView.sd_setImage(with: URL(string:url), completed: nil)
                    }else{
                        cell.myImageView.image = UIImage(named: "image 1")
                    }
                    
                    cell.playBtnRef.isHidden = true
                    return cell
                }
                else if (collectionView == videoCollectionView) {
                    let cell1  = videoCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageVideoCollectionViewCell", for: indexPath) as! ImageVideoCollectionViewCell
                    let objImage = viewModel1.arrEventVideos[indexPath.row]
                    cell1.playBtnRef.isHidden = false
                    if objImage.file != ""{
                        let urlimg = BaseURL + (objImage.file)!
                        let url = URL(string: urlimg)!
                        
                        if let thumbnailImage = getThumbnailImage(forUrl: url) {
                            cell1.myImageView.image = thumbnailImage
                        }
                    }
                    cell1.playVideo = {
                        print("Video is atpped")
                    }
                    return cell1
                }
            }
        }else if navValue == "1"{
            if isEvent{
                
                if (collectionView == imageCollectionView) {
                    let cell  = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageVideoCollectionViewCell", for: indexPath) as! ImageVideoCollectionViewCell
                    let objImage = viewModel.arrEventImg[indexPath.row]
                    if objImage.file != ""{
                        let url = BaseURL + (objImage.file)!
                        cell.myImageView.sd_setImage(with: URL(string:url), completed: nil)
                    }else{
                        cell.myImageView.image = UIImage(named: "image 1")
                    }
                    cell.playBtnRef.isHidden = true
                    return cell
                }
                else if (collectionView == videoCollectionView) {
                    let cell1  = videoCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageVideoCollectionViewCell", for: indexPath) as! ImageVideoCollectionViewCell
                    let objImage = viewModel.arrEventVideos[indexPath.row]
                    if objImage.file != ""{
                        let urlimg = BaseURL + (objImage.file)!
                        let url = URL(string: urlimg)!
                        
                        if let thumbnailImage = getThumbnailImage(forUrl: url) {
                            cell1.myImageView.image = thumbnailImage
                        }
                    }
                    cell1.playBtnRef.isHidden = false
                    cell1.playVideo = {
                        print("Video is atpped")
                    }
                    return cell1
                }
            }else{
                
                if (collectionView == imageCollectionView) {
                    let cell  = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageVideoCollectionViewCell", for: indexPath) as! ImageVideoCollectionViewCell
                    let objImage = viewModel1.arrEventImg[indexPath.row]
                    if objImage.file != ""{
                        let url = BaseURL + (objImage.file)!
                        cell.myImageView.sd_setImage(with: URL(string:url), completed: nil)
                    }else{
                        cell.myImageView.image = UIImage(named: "image 1")
                    }
                    cell.playBtnRef.isHidden = true
                    return cell
                }
                else if (collectionView == videoCollectionView) {
                    let cell1  = videoCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageVideoCollectionViewCell", for: indexPath) as! ImageVideoCollectionViewCell
                    let objImage = viewModel1.arrEventVideos[indexPath.row]
                    if objImage.file != ""{
                        let urlimg = BaseURL + (objImage.file)!
                        let url = URL(string: urlimg)!
                        
                        if let thumbnailImage = getThumbnailImage(forUrl: url) {
                            cell1.myImageView.image = thumbnailImage
                        }
                    }
                    cell1.playBtnRef.isHidden = false
                    cell1.playVideo = {
                        print("Video is atpped")
                    }
                    return cell1
                }
            }
        }else{
            
            if (collectionView == imageCollectionView) {
                let cell  = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageVideoCollectionViewCell", for: indexPath) as! ImageVideoCollectionViewCell
                let objImage = viewModel1.arrEventImg[indexPath.row]
                if objImage.file != ""{
                    let url = BaseURL + (objImage.file)!
                    cell.myImageView.sd_setImage(with: URL(string:url), completed: nil)
                }else{
                    cell.myImageView.image = UIImage(named: "image 1")
                }
                cell.playBtnRef.isHidden = true
                return cell
            }
            else if (collectionView == videoCollectionView) {
                let cell1  = videoCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageVideoCollectionViewCell", for: indexPath) as! ImageVideoCollectionViewCell
                let objImage = viewModel1.arrEventVideos[indexPath.row]
                if objImage.file != ""{
                    let urlimg = BaseURL + (objImage.file)!
                    let url = URL(string: urlimg)!
                    
                    if let thumbnailImage = getThumbnailImage(forUrl: url) {
                        cell1.myImageView.image = thumbnailImage
                    }
                }
                cell1.playBtnRef.isHidden = false
                cell1.playVideo = {
                    print("Video is atpped")
                }
                return cell1
            }
        }
        
        return UICollectionViewCell()
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if navValue == "0" {
            if isEvent{
                
                if (collectionView == imageCollectionView) {
                    let objImage = viewModel.arrEventImg[indexPath.row]
                    if objImage.file != ""{
                        let url = BaseURL + (objImage.file)!
                        viewImgPreview.isHidden = false
                        imgPreview.sd_setImage(with: URL(string:url), completed: nil)
                    }else{
                        imgPreview.image = UIImage(named: "image 1")
                    }

                }
                else if (collectionView == videoCollectionView) {
                    let obj = viewModel.arrEventVideos[indexPath.row]
                    if obj.file != ""{
                        let urlimg = BaseURL + (obj.file)!

                    guard let videoURL = URL(string: urlimg) else {
                              return
                        }
                        let player = AVPlayer(url: videoURL)
                        let playerViewController = AVPlayerViewController()
                        playerViewController.player = player
                        self.present(playerViewController, animated: true) {
                          playerViewController.player?.play()
                        }
                    }
                   
                }
            }else{
                
                if (collectionView == imageCollectionView) {
                    let objImage = viewModel1.arrEventImg[indexPath.row]
                    if objImage.file != ""{
                        let url = BaseURL + (objImage.file)!
                        viewImgPreview.isHidden = false
                        imgPreview.sd_setImage(with: URL(string:url), completed: nil)
                    }else{
                        imgPreview.image = UIImage(named: "image 1")
                    }
                }
                else if (collectionView == videoCollectionView) {
                    let obj = viewModel1.arrEventVideos[indexPath.row]
                    if obj.file != ""{
                        let urlimg = BaseURL + (obj.file)!

                    guard let videoURL = URL(string: urlimg) else {
                              return
                        }
                        let player = AVPlayer(url: videoURL)
                        let playerViewController = AVPlayerViewController()
                        playerViewController.player = player
                        self.present(playerViewController, animated: true) {
                          playerViewController.player?.play()
                        }
                    }
                }
            }
        }else if navValue == "1"{
            if isEvent{
                
                if (collectionView == imageCollectionView) {
                    let objImage = viewModel.arrEventImg[indexPath.row]
                    if objImage.file != ""{
                        let url = BaseURL + (objImage.file)!
                        viewImgPreview.isHidden = false
                        imgPreview.sd_setImage(with: URL(string:url), completed: nil)
                    }else{
                        imgPreview.image = UIImage(named: "image 1")
                    }
                }
                else if (collectionView == videoCollectionView) {
                    let obj = viewModel.arrEventVideos[indexPath.row]
                    if obj.file != ""{
                        let urlimg = BaseURL + (obj.file)!

                    guard let videoURL = URL(string: urlimg) else {
                              return
                        }
                        let player = AVPlayer(url: videoURL)
                        let playerViewController = AVPlayerViewController()
                        playerViewController.player = player
                        self.present(playerViewController, animated: true) {
                          playerViewController.player?.play()
                        }
                    }
                   
                }
            }else{
                
                if (collectionView == imageCollectionView) {
                    let objImage = viewModel1.arrEventImg[indexPath.row]
                    if objImage.file != ""{
                        let url = BaseURL + (objImage.file)!
                        viewImgPreview.isHidden = false
                        imgPreview.sd_setImage(with: URL(string:url), completed: nil)
                    }else{
                        imgPreview.image = UIImage(named: "image 1")
                    }
                }
                else if (collectionView == videoCollectionView) {
                    let obj = viewModel1.arrEventVideos[indexPath.row]
                    if obj.file != ""{
                        let urlimg = BaseURL + (obj.file)!

                    guard let videoURL = URL(string: urlimg) else {
                              return
                        }
                        let player = AVPlayer(url: videoURL)
                        let playerViewController = AVPlayerViewController()
                        playerViewController.player = player
                        self.present(playerViewController, animated: true) {
                          playerViewController.player?.play()
                        }
                    }
                }
            }
        }else{
            
            if (collectionView == imageCollectionView) {
                let objImage = viewModel1.arrEventImg[indexPath.row]
                if objImage.file != ""{
                    let url = BaseURL + (objImage.file)!
                    viewImgPreview.isHidden = false
                    imgPreview.sd_setImage(with: URL(string:url), completed: nil)
                }else{
                    imgPreview.image = UIImage(named: "image 1")
                }
               
            }
            else if (collectionView == videoCollectionView) {
                let obj = viewModel1.arrEventVideos[indexPath.row]
                if obj.file != ""{
                    let urlimg = BaseURL + (obj.file)!

                guard let videoURL = URL(string: urlimg) else {
                          return
                    }
                    let player = AVPlayer(url: videoURL)
                    let playerViewController = AVPlayerViewController()
                    playerViewController.player = player
                    self.present(playerViewController, animated: true) {
                      playerViewController.player?.play()
                    }
                }
            }
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == imageCollectionView) {
            print("Width: \(imageCollectionView.frame.size.width / 2)")
            return CGSize(width: screenWidth/2, height: 120)
        }
        else if (collectionView == videoCollectionView) {
            print("Width: \(videoCollectionView.frame.size.width / 2)")
            return CGSize(width: screenWidth/2, height: 120)
        }
        return CGSize()
        
    }
    
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)

        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }

        return nil
    }
}

//MARK:- Tableview Delegate
extension DetailViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblDocumentLink{
            return viewModel1.arrDocumentLink.count
        }else{
            if isEvent{
                return viewModel.arrVideoLink.count
            }else{
                return viewModel1.arrVideoLink.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblDocumentLink{
            let cell = tblDocumentLink.dequeueReusableCell(withIdentifier: "DetailDocumentLinkTVCell", for: indexPath) as! DetailDocumentLinkTVCell
          cell.lblDocumentLink.text = viewModel1.arrDocumentLink[indexPath.row].link
            return cell
        }else{
            if isEvent{
                let cell = tblVideoLink.dequeueReusableCell(withIdentifier: viewModel.identifierItemCell, for: indexPath) as! VideoLinkTableViewCell
                cell.videoTitleLbl.text = viewModel.arrVideoLink[indexPath.row].title
                cell.videoInfoLbl.text = viewModel.arrVideoLink[indexPath.row].info
                cell.videoLinkLbl.text = viewModel.arrVideoLink[indexPath.row].link
                let urlYoutube = viewModel.arrVideoLink[indexPath.row].link
                let urlID = urlYoutube?.youtubeID
                let urlStr = "http://img.youtube.com/vi/\(urlID ?? "")/1.jpg"
                let url = URL(string: urlStr)!
                
                cell.videoImg.sd_setImage(with: url, completed: nil)
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: viewModel1.identifierItemCell, for: indexPath) as! VideoLinkTableViewCell
                cell.videoTitleLbl.text = viewModel1.arrVideoLink[indexPath.row].title
                cell.videoInfoLbl.text = viewModel1.arrVideoLink[indexPath.row].info
                cell.videoLinkLbl.text = viewModel1.arrVideoLink[indexPath.row].link
                let urlYoutube = viewModel1.arrVideoLink[indexPath.row].link
                let urlID = urlYoutube?.youtubeID
                let urlStr = "http://img.youtube.com/vi/\(urlID ?? "")/1.jpg"
                let url = URL(string: urlStr)!
                
                cell.videoImg.sd_setImage(with: url, completed: nil)
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tblDocumentLink{
            return 40
        }else{
            if isEvent{
                return 154
            }else{
                return 154
            }
        }
    }

}
