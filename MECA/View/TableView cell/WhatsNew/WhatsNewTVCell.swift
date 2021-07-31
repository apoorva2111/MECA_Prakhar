//
//  WhatsNewTVCell.swift
//  MECA
//


import UIKit

class WhatsNewTVCell: UITableViewCell {
    
    @IBOutlet weak var whatsNewCollection: UICollectionView!
    @IBOutlet weak var btnShowAllOutlet: RCustomButton!
    var arrHomeFeed:[Data_Home] = []
    var viewController = UIViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setCell(feed:[Data_Home]) {
        if arrHomeFeed.count>0{
            arrHomeFeed.removeAll()
        }
        arrHomeFeed = feed
        if arrHomeFeed.count > 0 {
            whatsNewCollection.register(UINib.init(nibName: "WhatsNewCVCell", bundle: nil), forCellWithReuseIdentifier: "WhatsNewCVCell")
            whatsNewCollection.delegate = self
            whatsNewCollection.dataSource = self
            whatsNewCollection.reloadData()
        }
    }
}

extension WhatsNewTVCell : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = whatsNewCollection.dequeueReusableCell(withReuseIdentifier: "WhatsNewCVCell", for: indexPath) as! WhatsNewCVCell
        cell.setCell(feed: arrHomeFeed[indexPath.row])
        
        return cell
    }
    
    
//    func collectionView(_ collectionView: UICollectionView,willDisplay cell: UICollectionViewCell,forItemAt indexPath: IndexPath) {
//         if let myCell = cell as? WhatsNewCVCell {
//            myCell.imgWhatsNew.addBlackGradientLayerInBackground(frame:myCell.imgWhatsNew.bounds, colors: [.clear, .black])
//         }
//    }
        
        

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - 30, height: 200)

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let story = UIStoryboard(name: "Category", bundle:nil)
        let obj = arrHomeFeed[indexPath.row]
        let vc = story.instantiateViewController(withIdentifier: "NewDetailVC") as! NewDetailVC
        vc.eventID = String(obj.id ?? 0)
        vc.isEvent =  obj.whatsnew_type == "event" ? true : false
        vc.Maasview = false
        vc.module = obj.whatsnew_type ?? "event"
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
}
