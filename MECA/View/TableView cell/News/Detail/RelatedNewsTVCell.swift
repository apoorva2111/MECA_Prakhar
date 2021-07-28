//
//  RelatedNewsTVCell.swift
//  MECA


import UIKit

class RelatedNewsTVCell: UITableViewCell {
    @IBOutlet weak var relatedNewsCollection: UICollectionView!
    var arrRelated = [Related]()
    var viewController : NewsDetailVC!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setNewsVideoData(grData:VideoInfoData){
        if let arrObj = grData.related{
            if arrRelated.count>0{
                arrRelated.removeAll()
            }
            arrRelated = arrObj
        }
        relatedNewsCollection.register(UINib.init(nibName: "LatestNewsCVCell", bundle: nil), forCellWithReuseIdentifier: "LatestNewsCVCell")
        relatedNewsCollection.delegate = self
        relatedNewsCollection.dataSource = self
        relatedNewsCollection.reloadData()
    }
    func setNewsRelatedNewsData(grData:NewsDetail_Data){
        if let arrObj = grData.related{
            if arrRelated.count>0{
                arrRelated.removeAll()
            }
            arrRelated = arrObj
        }
        relatedNewsCollection.register(UINib.init(nibName: "LatestNewsCVCell", bundle: nil), forCellWithReuseIdentifier: "LatestNewsCVCell")
        relatedNewsCollection.delegate = self
        relatedNewsCollection.dataSource = self
        relatedNewsCollection.reloadData()
    }
}

extension RelatedNewsTVCell : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrRelated.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = relatedNewsCollection.dequeueReusableCell(withReuseIdentifier: "LatestNewsCVCell", for: indexPath) as! LatestNewsCVCell
        cell.setNewsDetailCell(objDict: arrRelated[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 350, height: 280)
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = arrRelated[indexPath.row]
        viewController.isClickedRelatedNews = true
        if viewController.isFromVideoList{
            viewController.viewModel.callWebserviceFroVideoInfo(videoId: String(obj.id!))
        }else{
            viewController.viewModel.callWebserviceFroNewInfo(newsId: String(obj.id!))
        }
    }
}
