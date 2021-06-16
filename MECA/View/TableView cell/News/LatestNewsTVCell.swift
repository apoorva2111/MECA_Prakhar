

import UIKit

class LatestNewsTVCell: UITableViewCell {

    @IBOutlet weak var btnLatestNewShowAll: UIButton!
    @IBOutlet weak var collectionLatestNews: UICollectionView!
    @IBOutlet weak var lblCategory: UILabel!
    var viewController = UIViewController()
    
    var arrNews =  [NSDictionary]()
var sectionCount = 0
    var arrCategory = ["market_latest_news","toyota_latest_news","videos"]
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        //LatestNewsCVCell
        collectionLatestNews.register(UINib.init(nibName: "LatestNewsCVCell", bundle: nil), forCellWithReuseIdentifier: "LatestNewsCVCell")

        collectionLatestNews.delegate = self
        collectionLatestNews.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCell(dict:NSDictionary) {
        print(dict)
        if let arrDict = dict["items"] as? NSArray{
            if arrNews.count>0{
                arrNews.removeAll()
            }
            for item in arrDict {
                arrNews.append(item as! NSDictionary)
            }
            collectionLatestNews.reloadData()
        }
    }
}
//MARK:- UICollectionView Delegate Datasource

extension LatestNewsTVCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return arrNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionLatestNews.dequeueReusableCell(withReuseIdentifier: "LatestNewsCVCell", for: indexPath) as! LatestNewsCVCell
        let obj = arrNews[indexPath.row]
        lblCategory.text = obj["catTitle"] as? String
        cell.btnPlayVideo.tag = indexPath.row
        cell.btnPlayVideo.addTarget(self, action: #selector(self.playVideoAction), for: .touchUpInside)
        cell.setCell(objDict: obj)
        return cell

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 350, height: 280)
        }

    @objc func playVideoAction(sender: UIButton){
        let obj = arrNews[sender.tag]
        if let videoURL = obj["video_link"] as? String{
            guard let url = URL(string: videoURL) else { return }
            UIApplication.shared.open(url)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = arrNews[indexPath.row]
        let vc = FlowController().instantiateViewController(identifier: "NewsDetailVC", storyBoard: "NewsRC") as! NewsDetailVC
      //
        let objCat = obj["catTitle"]as! String
        if objCat == "Videos"{
            vc.isFromVideoList = true
        }else{
            vc.isFromVideoList = false
        }
        //
       vc.newsID = String(obj["id"]as! Int)
        viewController.navigationController?.pushViewController(vc, animated: true)

    }
}

