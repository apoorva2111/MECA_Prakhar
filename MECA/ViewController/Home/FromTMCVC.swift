//
//  FromTMCVC.swift
//  MECA
//
//  Created by Macbook  on 05/07/21.
//

import UIKit
import AVFoundation
import AVKit

#if os(iOS)
import MediaPlayer
#endif
class FromTMCVC: UIViewController {
    var audioplayer: AVPlayer? = AVPlayer()

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewTabbar: FooterTabView!
    var viewModel : FromTMCVM!
    @IBOutlet weak var calendarView: CalendarView!
    private var pullControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       setView()
    }
    func setView() {
        viewModel = FromTMCVM.init(controller: self)
        
        tblView.register(FromTmcPromotionCell.nib(), forCellReuseIdentifier: "FromTmcPromotionCell")
        tblView.register(FromTMCCell.nib(), forCellReuseIdentifier: "FromTMCCell")
        
        tblView.delegate = self
        tblView.dataSource = self
        viewTabbar.footerTabViewDelegate = self
        //viewTabbar.imgCalender.image = UIImage.init(named: "one_and_only")
        viewTabbar.imgHome.image = UIImage.init(named: "Home_Inactive")
        viewTabbar.imgNotification.image = UIImage.init(named: "From_tmc_active-1")
        viewTabbar.lblHome.font = UIFont.init(name: "SFPro-Regular", size: 12)
        viewTabbar.lblCalender.font = UIFont.init(name: "SFPro-Regular", size: 12)
        viewTabbar.lblCategory.font = UIFont.init(name: "SFPro-Regular", size: 12)
        viewTabbar.lblNotification.font = UIFont.init(name: "SFPro-Bold", size: 12)
        viewTabbar.lblMore.font = UIFont.init(name: "SFPro-Regular", size: 12)

        pullControl.tintColor = UIColor.gray
        pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tblView.refreshControl = pullControl
        } else {
            tblView.addSubview(pullControl)
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    //viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MPVolumeView.setVolume(0.0)
        audioplayer?.pause()
            audioplayer = nil
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated )
        viewModel.FromtmcsApicall()
        MPVolumeView.setVolume(0.7)

    }
    @objc private func refreshListData(_ sender: Any) {

        viewModel.FromtmcsApicall()
        self.pullControl.endRefreshing() // You can stop after API Call


        }


}
//MARK:- Footerview Delegate
extension FromTMCVC: FooterTabViewDelegate{
    func footerBarAction(strType: String) {
        if strType == "Home"{
            
            let mainVC = FlowController().instantiateViewController(identifier: "HomeNav", storyBoard: "Home")
            let appDel = UIApplication.shared.delegate as! AppDelegate
            appDel.window?.rootViewController = mainVC
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            let duration: TimeInterval = 0.3

            UIView.transition(with: appDel.window!, duration: duration, options: options, animations: {}, completion:
            { completed in
                // maybe do something on completion here
            })
            appDel.window?.makeKeyAndVisible()
    
    }else if strType == "Calendar"{
            
        let vc = FlowController().instantiateViewController(identifier: "Chatvcmain", storyBoard: "Home")
        self.navigationController?.pushViewController(vc, animated:false)
            
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

       
        }else if strType == "FROM TMC"{
            
           
         print("From TMC Selected Tab")
        }else{
            let vc = FlowController().instantiateViewController(identifier: "MoreVC", storyBoard: "Home")
            self.navigationController?.pushViewController(vc, animated:false)
        }
    }
    
    
}
//MARK:- UITableview Delegate Datasource
extension FromTMCVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
             viewModel.getNumbersOfRows(in: section)
       
      //  viewModel.getNumbersOfRows(in: section)
       
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.getCellForRowAt(indexPath, tableView: tblView)
    }
//
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.getHeightForRowAt(indexPath, tableView: tblView)
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        viewModel.getHeightForHeaderAt(section, tableView: tblView)
//    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        viewModel.getBaseTableHeaderViewFor(section, tableView: tblView)
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath, tableView: tblView)

    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {



        //MoveupBounce tableview
        let animation = TableAnimationFactory.makeMoveUpBounceAnimation(rowHeight: 292, duration: 0.5, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)

    }
}
