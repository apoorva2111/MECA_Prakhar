//
//  MEBITViewController.swift
//  MECA
//
//  Created by Mohammed Sulaiman on 20/03/21.
//

import UIKit

class MEBITViewController: UIViewController {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var headerView: RCustomView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var dismissRefBtn: UIButton!
    @IBOutlet weak var MEBITTableView: UITableView!
    @IBOutlet weak var footerView: OrangeFooterView!
    var headerImageValue = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MEBITTableView.register(HomeTVCell.nib(), forCellReuseIdentifier: "HomeTVCell")
        MEBITTableView.delegate = self
        MEBITTableView.dataSource = self
        footerView.orangeFooterViewDelegate = self
        setupUI()
        // Do any additional setup after loading the view.
    }
    func setupUI() {
        if headerImageValue == "0" {
            headerImage.image = UIImage(named: "MEBIT1")
            
        }
        else if headerImageValue == "1" {
            
        }
        else if headerImageValue == "2" {
            
        }
        else if headerImageValue == "3" {
            
        }
        else if headerImageValue == "4" {
            //SDGS
            headerImage.image = UIImage(named: "SDGS")
        }
        else if headerImageValue == "5" {
            
        }
        
        
    }
    
    @IBAction func onClickDismiss(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension  MEBITViewController : OrangeFooterViewDelegate{
   

    func footerBarAction1(strType: String) {
        if strType == "WhatsNew"{
            print("Type1")

        }else if strType == "FromDistributor"{
            print("Type2")
            
            
        }else if strType == "FromTMC"{
            print("Type3")
//            let story = UIStoryboard(name: "Home", bundle:nil)
//            let vc = story.instantiateViewController(withIdentifier: "MEBITViewController") as! MEBITViewController
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: true)
            
            
        
    }
    
    
}
}
//MARK:- UITableview Delegate Datasource
extension MEBITViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MEBITTableView.dequeueReusableCell(withIdentifier: "HomeTVCell", for: indexPath) as! HomeTVCell
        cell.newImage.image = UIImage(named: "new1")
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 292
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
                       let story = UIStoryboard(name: "Category", bundle:nil)
                       let vc = story.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                       vc.modalPresentationStyle = .fullScreen
                       self.present(vc, animated: true)
        }
        else if indexPath.row == 1 {
            
        }
    }
}
