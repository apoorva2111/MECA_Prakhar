//
//  NotificationVC.swift
//  MECA
//
//  Created by Apoorva Gangrade on 25/05/21.
//

import UIKit

class NotificationVC: UIViewController {
    @IBOutlet weak var viewFooter: FooterTabView!

    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        viewFooter.footerTabViewDelegate = self
//        viewFooter.imgMore.image = UIImage.init(named: "More")
//        viewFooter.imgCalender.image = UIImage.init(named: "Calendar")
//        viewFooter.imgHome.image = UIImage.init(named: "Home_Inactive")
    }
    
}

//MARK:- Footerview Delegate
extension NotificationVC : FooterTabViewDelegate{
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
            let vc = FlowController().instantiateViewController(identifier: "NotificationVC", storyBoard: "Home")
            self.navigationController?.pushViewController(vc, animated:false)
        }else{
            let vc = FlowController().instantiateViewController(identifier: "MoreVC", storyBoard: "Home")
            self.navigationController?.pushViewController(vc, animated:false)
        }
    }
    
    
}
