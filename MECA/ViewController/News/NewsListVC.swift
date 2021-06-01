//
//  NewsListVC.swift
//  MECA
//
//  Created by Apoorva Gangrade on 29/05/21.
//

import UIKit

class NewsListVC: UIViewController {

    @IBOutlet weak var listCollection: UICollectionView!
   
    var viewModel : NewsListVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = NewsListVM.init(controller: self)
        listCollection.register(UINib.init(nibName: "OverPicksCVCell", bundle: nil), forCellWithReuseIdentifier: "OverPicksCVCell")
        // Do any additional setup after loading the view.
    }
    @IBAction func btnbackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCreateNewsAction(_ sender: UIButton) {
   
    }
}

extension NewsListVC : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getNumbersOfItemsForSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        viewModel.getItemForRowAt(indexPath, collectionView: listCollection)
    }
    
    
}
