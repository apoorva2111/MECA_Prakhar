

import UIKit

class NotificationVC: UIViewController {
    @IBOutlet weak var viewFooter: FooterTabView!
    @IBOutlet weak var tblNotification: UITableView!
    var viewModel : NotificationVM!
    var currentPage : Int = 1
    var checkPagination = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = NotificationVM.init(controller: self)
        viewFooter.footerTabViewDelegate = self
        viewFooter.imgMore.image = UIImage.init(named: "More")
        viewFooter.imgCalender.image = UIImage.init(named: "Calendar")
        viewFooter.imgHome.image = UIImage.init(named: "Home_Inactive")
        viewFooter.imgNotification.image = UIImage.init(named: "Notification Active")
        viewFooter.lblHome.font = UIFont.init(name: "SFPro-Regular", size: 12)
        viewFooter.lblCalender.font = UIFont.init(name: "SFPro-Regular", size: 12)
        viewFooter.lblCategory.font = UIFont.init(name: "SFPro-Regular", size: 12)
        viewFooter.lblNotification.font = UIFont.init(name: "SFPro-Bold", size: 12)
        viewFooter.lblMore.font = UIFont.init(name: "SFPro-Regular", size: 12)
        
        tblNotification.register(SignUpListTVCell.nib(), forCellReuseIdentifier: "SignUpListTVCell")
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
            
            let vc = FlowController().instantiateViewController(identifier: "HomeVC", storyBoard: "Home")
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
            let vc = FlowController().instantiateViewController(identifier: "FromTMCvc", storyBoard: "Home")
            self.navigationController?.pushViewController(vc, animated:false)
        }else{
            let vc = FlowController().instantiateViewController(identifier: "MoreVC", storyBoard: "Home")
            self.navigationController?.pushViewController(vc, animated:false)
        }
    }
}

extension NotificationVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumbersOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.getCellForRowAt(indexPath, tableView: tblNotification)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath, tableView: tblNotification)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.getHeightForRowAt(indexPath, tableView: tblNotification)
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            
            if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
                if indexPath == lastVisibleIndexPath {
                    if indexPath.row == viewModel.arrNoticationList.count-1{
                        self.checkPagination = "pagination"
                        currentPage += 1
                        GlobalObj.displayLoader(true, show: true)
                        GlobalObj.run(after: 2) {
                            self.viewModel.callWebserviceForNotificationList(limit: "10", page: String(self.currentPage))
                    }
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          
          if editingStyle == .delete {
//               terms.remove(at: indexPath.row)
//               tableView.deleteRows(at: [indexPath], with: .bottom)
          }
      }
}
