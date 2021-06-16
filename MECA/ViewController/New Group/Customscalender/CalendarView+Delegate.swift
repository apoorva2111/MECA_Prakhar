/*
 * CalendarView+Delegate.swift
 //  MECA
 //
 //  Created by Macbook  on 12/05/21.
 //
 */

import UIKit

extension CalendarView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        print("multipleSelectionEnable///// ...\(multipleSelectionEnable)")
        guard let date = self.dateFromIndexPath(indexPath) else { return }
        
        if let index = selectedIndexPaths.firstIndex(of: indexPath) {
            print("index\(index)")
            delegate?.calendar(self, didDeselectDate: date)
            if enableDeselection {
                // bug: when deselecting the second to last item programmatically, during
                // didDeselectDate delegation, the index returned is out of the bounds of
                // the selectedIndexPaths array.  This guard prevents the crash
//                guard index < selectedIndexPaths.count, index < selectedDates.count else {
//                    return
//                }
//                selectedIndexPaths.remove(at: index)
//                selectedDates.remove(at: index)
                
            }
            
        } else {
//            if let currentCell = collectionView.cellForItem(at: indexPath) as? CalendarDayCell, currentCell.isOutOfRange || currentCell.isAdjacent {
//                self.reloadData()
//                return
//            }
            multipleSelectionEnable = false
            print("!multipleSelectionEnable... \(multipleSelectionEnable)")
            if multipleSelectionEnable == true {
//                selectedIndexPaths.removeAll()
//                selectedDates.removeAll()
                selectedIndexPaths.removeAll()
            selectedDates.removeAll()
            }else{
                selectedDates.removeAll()
                
            }
            
            
//            if enableDeselection {
//                guard index < selectedIndexPaths.count, index < selectedDates.count else {
//                    return
//                }
//                selectedIndexPaths.remove(at: index)
//                selectedDates.remove(at: index)
//            }
            
            selectedIndexPaths.append(indexPath)
            selectedDates.append(date)
            
            }
//            let eventsForDaySelected = eventsByIndexPath[indexPath] ?? []
//            delegate?.calendar(self, didSelectDate: date, withEvents: eventsForDaySelected)
    
        
        self.reloadData()
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {

        guard let dateBeingSelected = self.dateFromIndexPath(indexPath) else { return false }

        if let delegate = self.delegate {
            return delegate.calendar(self, canSelectDate: dateBeingSelected)
        }

        return false // default
    }
    
    // MARK: UIScrollViewDelegate
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.updateAndNotifyScrolling()
        
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.updateAndNotifyScrolling()
    }
    
    func updateAndNotifyScrolling() {
        
        guard let date = self.dateFromScrollViewPosition() else { return }
        
        self.displayDateOnHeader(date)
        self.delegate?.calendar(self, didScrollToMonth: date)
        
    }

    @discardableResult
    func dateFromScrollViewPosition() -> Date? {
        var page: Int = 0
        
        switch self.direction {
        case .horizontal:
            let offsetX = ceilf(Float(self.collectionView.contentOffset.x))
            let width = self.collectionView.bounds.size.width
            page = Int(floor(offsetX / Float(width)))
        case .vertical:
            let offsetY = ceilf(Float(self.collectionView.contentOffset.y))
            let height = self.collectionView.bounds.size.height
            page = Int(floor(offsetY / Float(height)))
        @unknown default:
            fatalError()
        }
        
        page = page > 0 ? page : 0
        
        var monthsOffsetComponents = DateComponents()
        monthsOffsetComponents.month = page
        
        return self.calendar.date(byAdding: monthsOffsetComponents, to: self.firstDayCache);
    }
    
    func displayDateOnHeader(_ date: Date) {
        let month = self.calendar.component(.month, from: date) // get month
        print("month..... \(month)")
        delegatesmonth?.monthValue(monthstr: String(month))
        let formatter = DateFormatter()
        formatter.locale = style.locale
        formatter.timeZone = style.calendar.timeZone
        
        let monthName = formatter.standaloneMonthSymbols[(month-1) % 12].capitalized // 0 indexed array
        
        let year = self.calendar.component(.year, from: date)
        print("dataSource?.headerString(date) ?? monthName + ", " + String(year)\(dataSource?.headerString(date) ?? monthName + " " + String(year))")
        delegates?.filteringValue(filterStr: dataSource?.headerString(date) ?? monthName + " " + String(year))
//        self.headerView.monthLabel.text = dataSource?.headerString(date) ?? monthName + " " + String(year)
        
        self.displayDate = date
    }
//    func callwedservicecalendardata(month: String, year: String)
//    {
//        GlobalObj.displayLoader(true, show: true)
//
//        APIClient.webserviceForCalendar(month: month, year: year){ (result) in
//            print("result\(result)")
//            if let respCode = result.resp_code{
//
//                if respCode == 200{
//                    GlobalObj.displayLoader(true, show: false)
//
//                    if let arrDate = result.data{
//                        if self.callendararrList.count>0{
//                            self.callendararrList.removeAll()
//                        }
//                        if arrDate.count>0{
//                            self.callendararrList = arrDate
//                            for objdate in self.callendararrList{
//
//
//                                print("objdate....\(objdate.start_date)")
//                                let formatter = DateFormatter()
//                                // initially set the format based on your datepicker date / server String
//                                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//                               // self.calendarView.selectedDates.append(formatter.date(from: objdate)!)
//                                if objdate.start_date == "" {
//
//                                }else{
//                                    self.calendarView.selectDate(formatter.date(from: objdate.start_date!)!)
//                                }
//                                if objdate.end_date == "" {
//
//                                }else{
//                                    //self.calendarView.selectDate(formatter.date(from: objdate.end_date!)!)
//                                }
//
//                            }
//                        }
//                        //print("/......\(self.calendarView.selectDate)")
//                    }
//                    self.scheduletblview.reloadData()
//                }else{
//                    GlobalObj.displayLoader(true, show: false)
//
//                }
//            }
//
//            GlobalObj.displayLoader(true, show: false)
//
//        }
//    }
}
