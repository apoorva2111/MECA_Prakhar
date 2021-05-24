//
//  ScheduleTableCell.swift
//  MECA
//
//  Created by Macbook  on 18/05/21.
//

import UIKit

class ScheduleTableCell: UITableViewCell {
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    @IBOutlet weak var datelbl:UILabel!
    @IBOutlet weak var schedulenamelbl:UILabel!
    @IBOutlet weak var schedulebtn:UIButton!
    @IBOutlet weak var topView: RCustomView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // self.topView.roundCorners([.layerMinXMaxYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMinYCorner], radius: 12.0, borderColor: UIColor.white, borderWidth: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCellcalendarvalue(feed:calendardata) {
        
        print("calendar feed...\(feed)")
        schedulenamelbl.text = feed.title
        
        let sdate = feed.start_date!
        let edate = feed.end_date!
        let convertedsdate =  GlobalObj.convertToStringforcalendar(dateString:sdate)
       // let convertededate =  GlobalObj.convertToString(dateString:edate)
        if edate == ""  {
            
            datelbl.text! = convertedsdate
        }else{
            
            datelbl.text! = convertedsdate
        }
        
    }
    
}
