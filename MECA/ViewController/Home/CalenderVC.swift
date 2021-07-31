//
//  CalenderVC.swift
//  MECA
//
//  Created by Macbook  on 18/05/21.
//

import UIKit
import EventKit
import FSCalendar


class CalenderVC: UIViewController , FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
   
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var calendertopView: UIView!
    @IBOutlet weak var rightarrowbtn:UIButton!
    @IBOutlet weak var leftarrowbtn:UIButton!
    @IBOutlet weak var calenderDirectionView: UIView!
    @IBOutlet weak var calendarView: FSCalendar!
    let formatter = DateFormatter()
    @IBOutlet weak var headerdatetitle:UILabel!
    let darkGrey = UIColor(hexString: "#26478D")
    var datearr: [String] = []
    //Schedule
    var monthtext = ""
    var callendararrList = [calendardata]()
    var arrSortEvent = [calendardata]()
    var isDateSelect = false
    var viewModel : CalenderVM!
    
    
    var month = 0
    var year = 2021
    var filterdatestr = ""
    var isCalenderSelect = false
    var selectedDate = Date()
    var startDateDataArray = [Date]()
    var endDateDataArray = [Date]()
    var startDateArray = [Int]()
    var endDateArray = [Int]()
    var todayDate:Date = Date()
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    @IBOutlet weak var scheduletblview:UITableView!
    var datesWithEvent = [3, 19, 25, 30]
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.calendarView.selectedDates.removeAll()
        let style = CalendarView.Style()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
       
        style.cellShape = .round
        filterdatestr = ""
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
        
        calendarView.backgroundColor = darkGrey
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.allowsMultipleSelection = false
        calendarView.placeholderType = .none
        calendarView.headerHeight = 0.0
        calendarView.appearance.headerTitleColor = UIColor.gray
        calendarView.appearance.weekdayTextColor = UIColor.darkGray
        calendarView.appearance.caseOptions = FSCalendarCaseOptions.weekdayUsesUpperCase
        calendarView.appearance.weekdayFont = UIFont.init(name: "SF Pro, Semibold", size: 14) ?? UIFont.systemFont(ofSize: 14.0)
        calendarView.appearance.todaySelectionColor = UIColor.white
        calendarView.appearance.titleTodayColor = UIColor.blue
        /*calendarView.delegates = self
        calendarView.delegatesmonth = self
        calendarView.direction = .horizontal
        calendarView.multipleSelectionEnable = false
        calendarView.marksWeekends = true*/
       // calendarView.displayDateOnHeader(today)
        
        let monthInt = Calendar.current.component(.month, from: Date())
        print("monthInt...\(monthInt)")
        if monthtext == "" {
            monthtext = String(monthInt)
        }
        setupUI()
        print("...  hjasdha \(monthtext)")
        
        // Do any additional setup after loading the view.
    }
    func setupUI()  {
        viewModel = CalenderVM.init(controller: self)
        rightarrowbtn.backgroundColor = darkGrey
        leftarrowbtn.backgroundColor = darkGrey
        calenderDirectionView.backgroundColor = darkGrey
        headerdatetitle.backgroundColor = darkGrey
        calendertopView.backgroundColor = darkGrey
        self.calendertopView.roundCorners([.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 15.0, borderColor: UIColor.white, borderWidth: 1)
        scheduletblview.estimatedRowHeight = 80
        self.scheduletblview.rowHeight = UITableView.automaticDimension
        scheduletblview?.register(ScheduleTableCell.nib, forCellReuseIdentifier: ScheduleTableCell.identifier)
        scheduletblview?.dataSource = self
        scheduletblview?.delegate = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
       
        todayDate = Date()
        setMonthAndYearOnHeader(date: todayDate)
       // callwedservicecalendardata(month:monthtext, year: String(year))
//        for datearr in datearr {
//            print("objdate....\(datearr)")
//            let formatter = DateFormatter()
//            // initially set the format based on your datepicker date / server String
//            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//           // self.calendarView.selectedDates.append(formatter.date(from: objdate)!)
//
//            self.calendarView.selectDate(formatter.date(from: datearr)!)
//        }
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
        
        
        //self.calendarView.setDisplayDate(today)
        
//        self.datePicker.locale = self.calendarView.style.locale
//        self.datePicker.timeZone = self.calendarView.calendar.timeZone
//        self.datePicker.setDate(today, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated )
        callwedservicecalendardata(month:monthtext, year: String(year))
    }
    func callwedservicecalendardata(month: String, year: String)
    {
        GlobalObj.displayLoader(true, show: true)
        self.isCalenderSelect = false
        arrSortEvent.removeAll()
        APIClient.webserviceForCalendar(month: month, year: year){ (result) in
            print("result\(result)")
            if let respCode = result.resp_code{
                
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)

                    if let arrDate = result.data{
                        if self.callendararrList.count>0{
                            self.callendararrList.removeAll()
                        }
                        if self.viewModel.arrcalendarFeed.count>0{
                            self.viewModel.arrcalendarFeed.removeAll()
                        }
                        if arrDate.count>0{
                            if self.filterdatestr == "" {
                                self.viewModel.arrcalendarFeed = arrDate
                            }else{
                                print("\(arrDate)")
//                                for objdate in self.callendararrList{
//                                    let dateFormatter = DateFormatter()
//                                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//                                    dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
//                                    let datess = dateFormatter.date(from:objdate.start_date! )
//                                    let timeStr = dateFormatter.string(from: datess!)
//                                    if self.filterdatestr == timeStr {
//                                        self.viewModel.arrcalendarFeed = [objdate]
//                                    }
//                                }
                            }
                            

                        }
                        if self.callendararrList.count>0{
                            self.callendararrList.removeAll()
                            self.arrSortEvent.removeAll()
                        }
                        if arrDate.count>0{
                            print("\(arrDate)")
                            self.callendararrList = arrDate
                            
                            
                            if self.filterdatestr == "" {
                                print("filterdatestr// response ...\(self.filterdatestr)")
                            }
                            for objdate in self.callendararrList{
                                
                               
                                print("objdate....\(objdate)")
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
                                let date = dateFormatter.date(from:objdate.start_date! )
                                let date1 = dateFormatter.date(from:objdate.end_date! )
                                print("timeStamp start date ...\(date)")
                                print("timeStamp end date ...\(date1)")
                                // change to a readable time format and change to local time zone
                               
                                
                                if objdate.start_date == "" {
                                    
                                }else{
                                    self.selectedDate = date!
                                   // self.calendarView.select(date!)
                                    let calendar = Calendar.current
                                    let components = calendar.dateComponents([.year, .month, .day], from: date!)
                                    self.startDateArray.append(components.day ?? 0)
                                    self.startDateDataArray.append((date)!)
                                }
                                if objdate.end_date == "" {
                                    
                                }else{
                                    //self.calendarView.select(date1!)
                                    let calendar = Calendar.current
                                    let components = calendar.dateComponents([.year, .month, .day], from: date1!)
                                    self.endDateArray.append(components.day ?? 0)
                                    self.endDateDataArray.append((date1)!)
                                }
                             //   self.viewModel.arrcalendarFeed.append(objdate)
                                self.scheduletblview.reloadData()
                            }
                            
//                            for i in 0..<self.callendararrList.count {
//                                arrIndex.append(i)
//                            }
                            self.scheduletblview.reloadData()

                            if (self.callendararrList.last != nil){
                                self.isCalenderSelect = true
                            }
                            
                            
                        }
                        //print("/......\(String(describing: self.calendarView.selectDate))")
                        self.scheduletblview.reloadData()
                        self.calendarView.reloadData()
                    }
                }else{
                    GlobalObj.displayLoader(true, show: false)
                    self.calendarView.reloadData()

                }
            }
            
            GlobalObj.displayLoader(true, show: false)
            self.calendarView.reloadData()

        }
    }
    
    
   
    @IBAction func goToPreviousMonth(_ sender: Any) {
        filterdatestr = ""
        self.calendarView.setCurrentPage(getPreviousMonth(date: self.calendarView.currentPage), animated: true)
        let monthInt = Calendar.current.component(.month, from: self.calendarView.currentPage)
        monthtext = String(monthInt)
        if viewModel.calendarselecteddate.count>0{
            isDateSelect = false
        }else{
            isDateSelect = true
        }
//        scheduletblview.reloadData()
        callwedservicecalendardata(month:monthtext, year: String(year))
//        viewModel.callwedservicecalendardata(month:monthtext, year: String(year))

    }
    @IBAction func goToNextMonth(_ sender: Any) {
        filterdatestr = ""
        self.calendarView.setCurrentPage(getNextMonth(date: self.calendarView.currentPage), animated: true)
        let monthInt = Calendar.current.component(.month, from: self.calendarView.currentPage)
        monthtext = String(monthInt)
        if viewModel.calendarselecteddate.count>0{
            isDateSelect = false
        }else{
            isDateSelect = true
        }
    callwedservicecalendardata(month:monthtext, year: String(year))
    }
    func getNextMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: 1, to:date)!
    }

    func currentmont(date:Date) -> Date {
        return Calendar.current.date(byAdding: .month, value: 0, to: date)!
    }
    func getPreviousMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: -1, to:date)!
    }
    
    func setMonthAndYearOnHeader(date: Date) {
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "LLLL"
        headerdatetitle.text = monthFormatter.string(from: date) + " " + yearFormatter.string(from: date)
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        /*if Calendar.current.isDate(date, equalTo: todayDate, toGranularity: .day) {
            return UIColor.white
        }*/
        print("select date ...\(date)")
        return UIColor.gray
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        /*let dateString = self.dateFormatter2.string(from: date)
        if self.datesWithEvent.contains(dateString) {
            return 1
        }
        if self.datesWithMultipleEvents.contains(dateString) {
            return 3
        }*/
        
        return 0
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        if Calendar.current.isDate(date, equalTo: todayDate, toGranularity: .day) {
            return UIColor.white
        }
        if Calendar.current.isDate(date, equalTo: self.selectedDate, toGranularity: .day) {
            print("self./././?\(self.selectedDate)")
            return nil
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor? {
        print("self.startDateArray >>> \(self.startDateArray)")
        if self.startDateArray.contains((self.gregorian.component(.day, from: date))) {
            return UIColor.white
        }
        print("self.endDateArray >>> \(self.endDateArray)")
        if self.endDateArray.contains((self.gregorian.component(.day, from: date))) {
            return UIColor.white
        }
        return nil
        //return UIColor.yellow
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            // print(date)
        
        print("didselect\(dateStringFromDate(date))")
        viewModel.calendarselecteddate = dateStringFromDate(date)
//        if viewModel.calendarselecteddate.count>0{
//            isDateSelect = true
//        }else{
//            isDateSelect = false
//        }
        self.scheduletblview.reloadData()
//        if monthPosition == .previous || monthPosition == .next {
//            calendar.setCurrentPage(date, animated: true)
//        }
     
    }
    func dateStringFromDate(_ inputDate: Date) -> String {
        let df = DateFormatter()
      
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = df.string(from: inputDate)
        return dateString
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderSelectionColorFor date: Date) -> UIColor? {
        
        if Calendar.current.isDate(date, equalTo: self.selectedDate, toGranularity: .day) {
            return nil
        }
        return UIColor.darkGray
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderRadiusFor date: Date) -> CGFloat {
        return 2.0
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        if Calendar.current.isDate(date, equalTo: todayDate, toGranularity: .day) {
            return UIColor.black
        }
        return UIColor.white
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        startDateDataArray.removeAll()
        endDateDataArray.removeAll()
        startDateArray.removeAll()
        endDateArray.removeAll()
        setMonthAndYearOnHeader(date: calendar.currentPage)
        let monthInt = Calendar.current.component(.month, from: self.calendarView.currentPage)
        let yearInt = Calendar.current.component(.year, from: self.calendarView.currentPage)
        monthtext = String(monthInt)
        callwedservicecalendardata(month:String(monthInt), year: String(yearInt))
    }
    
    //FSCalender Delegate Methods
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
/*extension CalenderVC: CalendarViewDataSource {
    
      func startDate() -> Date {
          
          var dateComponents = DateComponents()
          dateComponents.month = -5
          
          let today = Date()
          print("startDate dateComponents\(dateComponents)")
        
          //let threeMonthsAgo = self.calendarView.calendar.date(byAdding: dateComponents, to: today)!
          
          //return threeMonthsAgo
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let date = dateFormatter.date(from:"2021-06-14 00:00:00")
        return date!
      }
      
      func endDate() -> Date {
          
          var dateComponents = DateComponents()
        
          dateComponents.month = 12
          let today = Date()
          
          //let twoYearsFromNow = self.calendarView.calendar.date(byAdding: dateComponents, to: today)!
          
          //return twoYearsFromNow
          
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let date = dateFormatter.date(from:"2021-06-15 00:00:00")
        return date!
    
      }
    
}*/

/*extension CalenderVC: CalendarViewDelegate {
   
    func calendar(_ calendar: CalendarView, didSelectDate date : Date, withEvents events: [CalendarEvent]) {
           
           print("Did Select: \(date) with \(events.count) events")
     
       /* if (!startDateDataArray.isEmpty) {
            self.calendarView.selectDate(startDateDataArray[0])
        }*/
         
        //self.calendarView.deselectDate(selectedDate)
         // selectedDate = date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        
        
        
        let dateconvert = dateFormatter.string(from: date)
        print("dateconvert...\(dateconvert)")
        filterdatestr = dateconvert
           //start_date
        print(dateconvert)
        if isCalenderSelect{
            arrSortEvent.removeAll()
            arrSortEvent = self.callendararrList.filter({($0.start_date!.localizedCaseInsensitiveContains(dateconvert))})
            
        scheduletblview.reloadData()
        }else{
            arrSortEvent = callendararrList
            scheduletblview.reloadData()
        }
        
        
       
       }
       
       func calendar(_ calendar: CalendarView, didScrollToMonth date : Date) {
           print("hjadfs ...\(self.calendarView.selectedDates)")
        
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
    
}*/



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
        
       
    }
}
