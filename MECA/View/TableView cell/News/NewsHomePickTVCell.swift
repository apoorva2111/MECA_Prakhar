//
//  NewsHomeTVCell.swift
//  MECA
//
//  Created by Apoorva Gangrade on 28/05/21.
//

import UIKit

class NewsHomePickTVCell: UITableViewCell {

    @IBOutlet weak var collectionPick: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionPick.delegate = self
        collectionPick.dataSource = self
        
        collectionPick.register(UINib.init(nibName: "OverPicksCVCell", bundle: nil), forCellWithReuseIdentifier: "OverPicksCVCell")

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


//MARK:- UICollectionView Delegate Datasource

extension NewsHomePickTVCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionPick.dequeueReusableCell(withReuseIdentifier: "OverPicksCVCell", for: indexPath) as! OverPicksCVCell
        return cell

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 300, height: 160)
        }
    
}
