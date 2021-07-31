

import UIKit

class HomeVC: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewTabbar: FooterTabView!
    var viewModel : OneandonlydayVM!
    @IBOutlet weak var calendarView: CalendarView!
    private var pullControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        // Do any additional setup after loading the view.
       setView()
    }
    func setView() {
        viewModel = OneandonlydayVM.init(controller: self)
        
        tblView.register(OneandonlyTVCell.nib(), forCellReuseIdentifier: "OneandonlyTVCell")
        tblView.delegate = self
        tblView.dataSource = self
//        viewTabbar.footerTabViewDelegate = self
//        viewTabbar.imgCalender.image = UIImage.init(named: "one_and_only_active")
//        viewTabbar.imgHome.image = UIImage.init(named: "Home_Inactive")
//        viewTabbar.lblHome.font = UIFont.init(name: "SFPro-Regular", size: 12)
//        viewTabbar.lblCalender.font = UIFont.init(name: "SFPro-Bold", size: 12)
//        viewTabbar.lblCategory.font = UIFont.init(name: "SFPro-Regular", size: 12)
//        viewTabbar.lblNotification.font = UIFont.init(name: "SFPro-Regular", size: 12)
//        viewTabbar.lblMore.font = UIFont.init(name: "SFPro-Regular", size: 12)

        pullControl.tintColor = UIColor.gray
        pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tblView.refreshControl = pullControl
        } else {
            tblView.addSubview(pullControl)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated )
        viewModel.OneandonlydayApicall()

    }
    @objc private func refreshListData(_ sender: Any) {

        viewModel.OneandonlydayApicall()
        self.pullControl.endRefreshing() // You can stop after API Call


        }
    @IBAction func onClickDismiss(_ sender: UIButton) {
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
}
//MARK:- UIButton Action
extension HomeVC{
    @IBAction func btnPlusAction(_ sender: UIButton) {
        
        let vc = FlowController().instantiateViewController(identifier: "PlusSelectCategoryVC", storyBoard: "Home")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:- Footerview Delegate
//extension HomeVC: FooterTabViewDelegate{
//    func footerBarAction(strType: String) {
//        if strType == "Home"{
//
//            let mainVC = FlowController().instantiateViewController(identifier: "HomeNav", storyBoard: "Home")
//            let appDel = UIApplication.shared.delegate as! AppDelegate
//            appDel.window?.rootViewController = mainVC
//            let options: UIView.AnimationOptions = .transitionCrossDissolve
//            let duration: TimeInterval = 0.3
//
//            UIView.transition(with: appDel.window!, duration: duration, options: options, animations: {}, completion:
//            { completed in
//                // maybe do something on completion here
//            })
//            appDel.window?.makeKeyAndVisible()
//
//    }else if strType == "Calendar"{
//
////            let vc = FlowController().instantiateViewController(identifier: "HomeVC", storyBoard: "Home")
////            self.navigationController?.pushViewController(vc, animated:false)
//
//        let mainVC = FlowController().instantiateViewController(identifier: "HomeVC", storyBoard: "HomeVC")
//        let appDel = UIApplication.shared.delegate as! AppDelegate
//        appDel.window?.rootViewController = mainVC
//        let options: UIView.AnimationOptions = .transitionCrossDissolve
//        let duration: TimeInterval = 0.3
//
//        UIView.transition(with: appDel.window!, duration: duration, options: options, animations: {}, completion:
//        { completed in
//            // maybe do something on completion here
//        })
//        appDel.window?.makeKeyAndVisible()
//
//        }else if strType == "Categories"{
//
//            let mainVC = FlowController().instantiateViewController(identifier: "NavCategory", storyBoard: "Category")
//            let appDel = UIApplication.shared.delegate as! AppDelegate
//            appDel.window?.rootViewController = mainVC
//            let options: UIView.AnimationOptions = .transitionCrossDissolve
//            let duration: TimeInterval = 0.3
//
//            UIView.transition(with: appDel.window!, duration: duration, options: options, animations: {}, completion:
//            { completed in
//                // maybe do something on completion here
//            })
//            appDel.window?.makeKeyAndVisible()
//
//
//        }else if strType == "FROM TMC"{
//
////            let vc = FlowController().instantiateViewController(identifier: "FromTMCvc", storyBoard: "Home")
////            self.navigationController?.pushViewController(vc, animated:false)
//            let mainVC = FlowController().instantiateViewController(identifier: "FromTMCvc", storyBoard: "FromTMCvc")
//            let appDel = UIApplication.shared.delegate as! AppDelegate
//            appDel.window?.rootViewController = mainVC
//            let options: UIView.AnimationOptions = .transitionCrossDissolve
//            let duration: TimeInterval = 0.3
//
//            UIView.transition(with: appDel.window!, duration: duration, options: options, animations: {}, completion:
//            { completed in
//                // maybe do something on completion here
//            })
//            appDel.window?.makeKeyAndVisible()
//
//        }else{
//            let vc = FlowController().instantiateViewController(identifier: "MoreVC", storyBoard: "Home")
//            self.navigationController?.pushViewController(vc, animated:false)
//        }
//    }
//
//
//}

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
        return 312
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
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        
        
        //MoveupBounce tableview
        let animation = TableAnimationFactory.makeMoveUpBounceAnimation(rowHeight: 292, duration: 0.5, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
        
    }
}
extension HomeVC: CalendarViewDataSource {
    
      func startDate() -> Date {
          
          var dateComponents = DateComponents()
          dateComponents.month = -5
          
          let today = Date()
          print("startDate dateComponents\(dateComponents)")
          let threeMonthsAgo = self.calendarView.calendar.date(byAdding: dateComponents, to: today)!
          
          return threeMonthsAgo
      }
      
      func endDate() -> Date {
          
          var dateComponents = DateComponents()
        
          dateComponents.month = 12
          let today = Date()
          
          let twoYearsFromNow = self.calendarView.calendar.date(byAdding: dateComponents, to: today)!
          
          return twoYearsFromNow
    
      }
    
}

extension HomeVC: CalendarViewDelegate {
    
    func calendar(_ calendar: CalendarView, didSelectDate date : Date, withEvents events: [CalendarEvent]) {
           
           print("Did Select: \(date) with \(events.count) events")
           for event in events {
               print("\t\"\(event.title)\" - Starting at:\(event.startDate)")
           }
           
       }
       
       func calendar(_ calendar: CalendarView, didScrollToMonth date : Date) {
           print(self.calendarView.selectedDates)
        
          // self.datePicker.setDate(date, animated: true)
       }
       
       
       func calendar(_ calendar: CalendarView, didLongPressDate date : Date, withEvents events: [CalendarEvent]?) {
           
           if let events = events {
               for event in events {
                   print("\t\"\(event.title)\" - Starting at:\(event.startDate)")
               }
           }
           
           let alert = UIAlertController(title: "Create New Event", message: "Message", preferredStyle: .alert)
           
           alert.addTextField { (textField: UITextField) in
               textField.placeholder = "Event Title"
           }
           
           let addEventAction = UIAlertAction(title: "Create", style: .default, handler: { (action) -> Void in
               let title = alert.textFields?.first?.text
               //self.calendarView.addEvent(title!, date: date)
           })
           
           let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
           
           alert.addAction(addEventAction)
           alert.addAction(cancelAction)
           
           self.present(alert, animated: true, completion: nil)
           
       }
    
}
