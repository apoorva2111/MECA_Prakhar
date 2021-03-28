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
    var viewModel : HomeVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel = HomeVM.init(controller: self)
        
        tblView.register(HomeTVCell.nib(), forCellReuseIdentifier: "HomeTVCell")
        tblView.delegate = self
        tblView.dataSource = self
        viewTabbar.footerTabViewDelegate = self
        viewModel.callHomeFeedWebservice()
    }
    
    
    @IBAction func btnPlusAction(_ sender: UIButton) {
        
        let vc = FlowController().instantiateViewController(identifier: "PlusSelectCategoryVC", storyBoard: "Home")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
//MARK:- Footerview Delegate
extension HomeVC: FooterTabViewDelegate{
    func footerBarAction(strType: String) {
        if strType == "Home"{

        }else if strType == "Calendar"{
            
            
            
        }else if strType == "Categories"{

            let mainVC = FlowController().instantiateViewController(identifier: "NavCategory", storyBoard: "Category")
            let appDel = UIApplication.shared.delegate as! AppDelegate
            appDel.window?.rootViewController = mainVC
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            let duration: TimeInterval = 0.3

            UIView.transition(with: appDel.window!, duration: duration, options: options, animations: {}, completion:
            { completed in
                // maybe do something on completion here
            })
            appDel.window?.makeKeyAndVisible()

       
        }else if strType == "Notification"{
            
        }else{
            
        }
    }
    
    
}

//MARK:- UITableview Delegate Datasource
extension HomeVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumbersOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.getCellForRowAt(indexPath, tableView: tblView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 292
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        viewModel.getHeightForHeaderAt(section, tableView: tblView)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        viewModel.getBaseTableHeaderViewFor(section, tableView: tblView)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath, tableView: tblView)
    }
}
