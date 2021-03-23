//
//  DetailViewController.swift
//  MECA
//
//  Created by Mohammed Sulaiman on 21/03/21.
//

import UIKit

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
    @IBOutlet weak var videoLinkRefBtn: UIButton!
    @IBOutlet weak var CommentsLikeView: UIView!
    @IBOutlet weak var likeIcon: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentIcon: UIImageView!
    @IBOutlet weak var commentlabel: UILabel!
    @IBOutlet weak var likeBtnRef: UIButton!
    @IBOutlet weak var commentBtnRef: UIButton!
    @IBOutlet weak var separatorlabel3: UILabel!
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    var arrcatImg = [UIImage.init(named: "News"),UIImage.init(named: "MEBIT"),UIImage.init(named: "MaaS"),UIImage.init(named: "Hydrogen"),UIImage.init(named: "SDGs"),UIImage.init(named: "GR")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.imageCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        self.videoCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")
        videoCollectionView.dataSource = self
        videoCollectionView.delegate = self
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        setupUI()

        // Do any additional setup after loading the view.
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
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth/2, height: 120)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        imageCollectionView!.collectionViewLayout = layout
        videoCollectionView!.collectionViewLayout = layout
        
    }
    
    @IBAction func onClickDismissVC(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickReadMore(_ sender: UIButton) {
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == imageCollectionView) {
            let cell  = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageVideoCollectionViewCell", for: indexPath) as! ImageVideoCollectionViewCell
           // cell.myImageView.image = arrcatImg[indexPath.row]
            cell.myImageView.image = UIImage(named: "image 1")
            cell.playBtnRef.isHidden = true
            return cell
        }
        else if (collectionView == videoCollectionView) {
            let cell1  = videoCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageVideoCollectionViewCell", for: indexPath) as! ImageVideoCollectionViewCell
            cell1.myImageView.image = UIImage(named: "image 2")
            cell1.playBtnRef.isHidden = false
            cell1.playVideo = {
                print("Video is atpped")
            }
            return cell1
        }
        return UICollectionViewCell()
        
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
}
