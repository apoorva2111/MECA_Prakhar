//
//  SpecialsitesVC.swift
//  MECA
//
//  Created by Macbook  on 20/07/21.
//

import UIKit

class SpecialsitesVC: UIViewController {
    @IBOutlet weak var tblActivity: UITableView!
    @IBOutlet weak var buttonPlus: UIButton!
   
    @IBOutlet weak var footerView: OrangeFooterView!
    var viewModel : SpecialsiteVM!
    var currentPage : Int = 1
    var checkPagination = ""
    var arrModule = [Modules]()

    private var pullControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        buttonPlus.isHidden = true
        setupUI()
        pullControl.tintColor = UIColor.gray
        pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tblActivity.refreshControl = pullControl
        } else {
            tblActivity.addSubview(pullControl)
        }
        // Do any additional setup after loading the view.
    }
    
    @objc private func refreshListData(_ sender: Any) {
        self.pullControl.endRefreshing()
        currentPage = 1
        self.checkPagination = "get"
        viewModel.callWebserviceForSpecialsiteVM()
    }
    
    func setupUI() {
       tblActivity.register(UINib.init(nibName: "SitetableCell", bundle: nil), forCellReuseIdentifier: "SitetableCell")
        tblActivity.register(UINib.init(nibName: "GrSiteselectionCell", bundle: nil), forCellReuseIdentifier: "GrSiteselectionCell")
        tblActivity.register(SpecialInfnTblCell.nib(), forCellReuseIdentifier: "SpecialInfnTblCell")
        
        tblActivity.delegate = self
        tblActivity.dataSource = self
        
        viewModel = SpecialsiteVM.init(controller: self)
        //viewModel.callWebserviceForSpecialsiteVM()
        footerView.lblTMC.sizeToFit()
        footerView.lblDistributor.sizeToFit()
        footerView.lblSpecialsite.sizeToFit()
        footerView.lblWhatsNew.sizeToFit()
        footerView.orangeFooterViewDelegate = self
        footerView.imgWhatsnew.image = UIImage.init(named: "Whats New")
        //footerView.imgFromDistributor.image = UIImage.init(named: "activity_report")
        footerView.imgFromTMC.image = UIImage.init(named: "Linkes")
        footerView.imgFromSpecialsite.image = UIImage.init(named: "special_sites_active")
        footerView.lblWhatsNew.text = "What's New"
        footerView.lblDistributor.text = "Activity Report"
        footerView.lblTMC.text = "Official Site"
            footerView.lblSpecialsite.text = "Special Site"
        footerView.bgView.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0, blue: 0, alpha: 1)
    }
  
    @IBAction func btnCrossAction(_ sender: UIButton) {
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
    }
    @IBAction func btnPlusAction(_ sender: UIButton) {
        let vc = FlowController().instantiateViewController(identifier: "CategoryCommonViewController", storyBoard: "Home") as! CategoryCommonViewController
        for objModule in arrModule {
            vc.module = objModule.id ?? 0
        }
        vc.myTitle = "Add New GR"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
        //Module
        func callWebserviceCategory() {
            GlobalObj.displayLoader(true, show: true)
            APIClient.webserviceForCategoryList { (result) in
                GlobalObj.displayLoader(true, show: false)
                if let respCode = result.resp_code{
                    if respCode == 200{
                        // GlobalObj.displayLoader(true, show: false)
                        
                        if let arrDate = result.data{
                            if let arr = arrDate.modules{
                                self.arrModule = arr
                            }
                        }
                        
                    }else{
                        // GlobalObj.displayLoader(true, show: false)
                        
                    }
                }
                
                GlobalObj.displayLoader(true, show: false)
                
            }
            
        }

}
//MARK:- Footerview Delegate
extension SpecialsitesVC : OrangeFooterViewDelegate{
    
    
    func footerBarAction1(strType: String){
        print("SpecialsitesVC\(strType)")
        if strType == "WhatsNew"{
            print("Type1")
            
            let vc = FlowController().instantiateViewController(identifier: "MEBITViewController", storyBoard: "Category")
            self.navigationController?.pushViewController(vc, animated: false)
            
        }else if strType == "FromDistributor"{
            print("Type2")
            let vc = FlowController().instantiateViewController(identifier: "GRActivityReportVC", storyBoard: "GR")
            self.navigationController?.pushViewController(vc, animated: false)
           
        }else if strType == "FromTMC"{
            print("Type3")
                let vc = FlowController().instantiateViewController(identifier: "GRLinksVC", storyBoard: "GR")
                self.navigationController?.pushViewController(vc, animated: false)
        }else if strType == "Special Sites"{
            print("activity select in special sites")
        }
    }
}
//MARK:- UITableview Delegate DataSourcew
extension SpecialsitesVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumbersOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.getCellForRowAt(indexPath, tableView: tblActivity)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.getHeightForRowAt(indexPath, tableView: tblActivity)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath, tableView: tblActivity)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //MoveupBounce tableview
        let animation = TableAnimationFactory.makeMoveUpBounceAnimation(rowHeight: viewModel.getHeightForRowAt(indexPath, tableView: tblActivity), duration: 0.5, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                if indexPath.row == viewModel.Mecad_informationList.count-1{
                    self.checkPagination = "pagination"
                    currentPage += 1
                    GlobalObj.run(after: 2) {
                        GlobalObj.displayLoader(true, show: true)
                        self.viewModel.callWebserviceForSpecialsiteVM()
                    }
                }
            }
        }
    }
}
