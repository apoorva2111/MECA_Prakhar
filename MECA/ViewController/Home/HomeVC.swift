//
//  HomeVC.swift
//  MECA
//
//  Created by Apoorva Gangrade on 19/03/21.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var viewTabbar: FooterTabView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tblView.register(HomeTVCell.nib(), forCellReuseIdentifier: "HomeTVCell")
        tblView.delegate = self
        tblView.dataSource = self
        viewTabbar.footerTabViewDelegate = self
    }
    
    @IBAction func btnPlusAction(_ sender: UIButton) {
        
        let story = UIStoryboard(name: "Home", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "PlusSelectCategoryVC") as! PlusSelectCategoryVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)

    }
    
}
//MARK:- Footerview Delegate
extension HomeVC: FooterTabViewDelegate{
    func footerBarAction(strType: String) {
        if strType == "Home"{

        }else if strType == "Calendar"{
            
        }else if strType == "Categories"{
            
        }else if strType == "Notification"{
            
        }else{
            
        }
    }
    
    
}

//MARK:- UITableview Delegate Datasource
extension HomeVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "HomeTVCell", for: indexPath) as! HomeTVCell
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 292
        
    }
}
