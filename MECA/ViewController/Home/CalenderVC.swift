//
//  CalenderVC.swift
//  MECA
//
//  Created by Macbook  on 18/05/21.
//

import UIKit
import EventKit
class CalenderVC: UIViewController {
    
    
    
    
    @IBOutlet weak var viewFooter: FooterTabView!
    @IBOutlet weak var calendertopView: UIView!
    @IBOutlet weak var rightarrowbtn:UIButton!
    @IBOutlet weak var leftarrowbtn:UIButton!
    @IBOutlet weak var calenderDirectionView: UIView!
    @IBOutlet weak var calendarView: CalendarView!
    
    @IBOutlet weak var headerdatetitle:UILabel!
    let darkGrey = UIColor(hexString: "#26478D")
    var datearr = ["2021-06-21 22:48:53","2021-06-25 22:48:53"]
    //Schedule
    var monthtext = ""
    var callendararrList = [calendardata]()
    var viewModel : CalenderVM!
    var month = 0
    var year = 2021
    @IBOutlet weak var scheduletblview:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calendarView.selectedDates.removeAll()
        let style = CalendarView.Style()
        
        style.cellShape = .round
        
        style.cellColorDefault         = UIColor.clear
        style.cellColorToday           = UIColor.white
        style.cellSelectedBorderColor  = UIColor.white
        style.cellEventColor           = UIColor(red:1.00, green:0.63, blue:0.24, alpha:1.00)
        style.headerTextColor          = UIColor.gray
        
        style.cellTextColorDefault     = UIColor.white
        style.cellTextColorToday       = darkGrey
        style.cellTextColorWeekend     = UIColor.white
        style.cellColorOutOfRange      = UIColor.red
            
        style.headerBackgroundColor    = darkGrey
       
        style.weekdaysBackgroundColor  = darkGrey
        style.firstWeekday             = .sunday
        
        style.locale                   = Locale(identifier: "en_US")
        
        style.cellFont = UIFont.init(name: "SF Pro, Regular", size: 16) ?? UIFont.systemFont(ofSize: 16.0)
        style.headerFont = UIFont(name: ",Semibold", size: 20.0) ?? UIFont.systemFont(ofSize: 20.0)
        style.weekdaysFont = UIFont.init(name: "SF Pro, Semibold", size: 14) ?? UIFont.systemFont(ofSize: 14.0)
        
        calendarView.style = style
        calendarView.backgroundColor = darkGrey
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.delegates = self
        calendarView.delegatesmonth = self
        calendarView.direction = .horizontal
        calendarView.multipleSelectionEnable = false
        calendarView.marksWeekends = true
        let today = Date()
       // calendarView.displayDateOnHeader(today)
        
        let monthInt = Calendar.current.component(.month, from: Date())
        print("monthInt...\(monthInt)")
        if monthtext == "" {
            monthtext = String(monthInt)
        }
        setupUI()
        print("...  hjasdha \(monthtext)")
        callwedservicecalendardata(month:monthtext, year: String(year))
        // Do any additional setup after loading the view.
    }
    func setupUI()  {
        viewModel = CalenderVM.init(controller: self)
        rightarrowbtn.backgroundColor = darkGrey
        leftarrowbtn.backgroundColor = darkGrey
        calenderDirectionView.backgroundColor = darkGrey
        headerdatetitle.backgroundColor = darkGrey
        calendertopView.backgroundColor = darkGrey
        viewFooter.footerTabViewDelegate = self
        viewFooter.imgMore.image = UIImage.init(named: "More")
        viewFooter.imgCalender.image = UIImage.init(named: "Calendar Active")
        viewFooter.imgHome.image = UIImage.init(named: "Home_Inactive")
        self.calendertopView.roundCorners([.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 15.0, borderColor: UIColor.white, borderWidth: 1)
        scheduletblview.estimatedRowHeight = 80
        self.scheduletblview.rowHeight = UITableView.automaticDimension
        scheduletblview?.register(ScheduleTableCell.nib, forCellReuseIdentifier: ScheduleTableCell.identifier)
        scheduletblview?.dataSource = self
        scheduletblview?.delegate = self
        calendarView.isUserInteractionEnabled = false
    }
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
       
        let today = Date()
        
//        var tomorrowComponents = DateComponents()
//        tomorrowComponents.day = 1
//        
//        
//        let tomorrow = self.calendarView.calendar.date(byAdding: tomorrowComponents, to: today)!
//        self.calendarView.selectDate(tomorrow)

        #if KDCALENDAR_EVENT_MANAGER_ENABLED
//        self.calendarView.loadEvents() { error in
//            if error != nil {
//                let message = "The karmadust calender could not load system events. It is possibly a problem with permissions"
//                let alert = UIAlertController(title: "Events Loading Error", message: message, preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }
//        }
        #endif
        
        
        self.calendarView.setDisplayDate(today)
        
//        self.datePicker.locale = self.calendarView.style.locale
//        self.datePicker.timeZone = self.calendarView.calendar.timeZone
//        self.datePicker.setDate(today, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated )
        viewModel.callwedservicecalendardata(month:monthtext, year: String(year))

    }
    func callwedservicecalendardata(month: String, year: String)
    {
        GlobalObj.displayLoader(true, show: true)
        
        APIClient.webserviceForCalendar(month: month, year: year){ (result) in
            print("result\(result)")
            if let respCode = result.resp_code{
                
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)

                    if let arrDate = result.data{
                        if self.callendararrList.count>0{
                            self.callendararrList.removeAll()
                        }
                        if arrDate.count>0{
                            self.callendararrList = arrDate
                            for objdate in self.callendararrList{
                                
                               
                                print("objdate....\(objdate.start_date)")
                                let formatter = DateFormatter()
                                // initially set the format based on your datepicker date / server String
                                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                               // self.calendarView.selectedDates.append(formatter.date(from: objdate)!)
                                if objdate.start_date == "" {
                                    
                                }else{
                                    self.calendarView.selectDate(formatter.date(from: objdate.start_date!)!)
                                }
                                if objdate.end_date == "" {
                                    
                                }else{
                                    //self.calendarView.selectDate(formatter.date(from: objdate.end_date!)!)
                                }
                                
                            }
                        }
                        print("/......\(self.calendarView.selectDate)")
                    }
                    self.scheduletblview.reloadData()
                }else{
                    GlobalObj.displayLoader(true, show: false)

                }
            }
            
            GlobalObj.displayLoader(true, show: false)

        }
    }
    @IBAction func goToPreviousMonth(_ sender: Any) {
        
        self.calendarView.goToPreviousMonth()
    }
    @IBAction func goToNextMonth(_ sender: Any) {
       
        self.calendarView.goToNextMonth()
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CalenderVC: CalendarViewDataSource {
    
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

extension CalenderVC: CalendarViewDelegate {
    
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




//MARK:- Footerview Delegate
extension CalenderVC : FooterTabViewDelegate{
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

//MARK:- UITableview Delegate Datasource
extension CalenderVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumbersOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.getCellForRowAt(indexPath, tableView: scheduletblview)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        viewModel.getHeightForHeaderAt(section, tableView: scheduletblview)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        viewModel.getBaseTableHeaderViewFor(section, tableView: scheduletblview)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  viewModel.didSelectRowAt(indexPath, tableView: scheduletblview)
   
    }
}

////Mark: - Tableview Datasource Methods
//extension CalenderVC: UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleTableCell.identifier, for: indexPath) as? ScheduleTableCell
//
//         return cell!
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 40))
//
//            let label = UILabel()
//            label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
//            label.text = "Schedule"
//            label.font = .systemFont(ofSize: 16)
//            label.textColor = .yellow
//
//            headerView.addSubview(label)
//
//            return headerView
//        }
//}
////MARK: - TableView Delegate Methods
//extension CalenderVC: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
////        let cell = tableView.dequeueReusableCell(withIdentifier: SDGSListTableCell.identifier, for: indexPath) as? SDGSListTableCell
////        cell!.backgroundColor = UIColor.white
////
////        let obj = arrList[indexPath.row]
////
////
////        let story = UIStoryboard(name: "Category", bundle:nil)
////      //  let obj = arrList[indexPath.row]
////        let vc = story.instantiateViewController(withIdentifier: "SDGSListVC") as! SDGSListvc
////        vc.idvalue = String(obj.id ?? "0")
////        vc.headerImageValue = String(obj.lable ?? "0")
////
////        self.navigationController?.pushViewController(vc, animated: true)
////        self.SDGSCategoryTableView.reloadData()
//
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//            return 40
//        }
//}
extension CalenderVC:FilterVCDelegate{
    func filteringValue(filterStr: String) {
        print("filterStr...\(filterStr)")
        headerdatetitle.text! = filterStr
    }
    
}
extension CalenderVC:MonthVCDelegate{
    func monthValue(monthstr: String) {
        print("monthstr...\(monthstr)")
        monthtext = monthstr
        callwedservicecalendardata(month:monthtext, year: String(year))
        viewModel.callwedservicecalendardata(month:monthtext, year: String(year))
    }
}
