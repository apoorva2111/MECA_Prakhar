//
//  WallofframedetailVC.swift
//  MECA
//
//  Created by Macbook  on 03/06/21.
//

import UIKit
import SDWebImage
class WallofframedetailVC: UIViewController {
    var checkdetailfame : [walloffame_detailModel] = []
    var frame: Int?
var country: String?
var courseStatus: Int?
var courseDate: String?
var step1Status: Int?
var step1Date: String?
var step13_Status: Int?
var step13_Date: String?
var step15_Status: Int?
var step15_Date: String?
var finalReportStatus: Int?
var finalReportDate: String?
var mentorPassedStatus: Int?
var mentorPassedDate, mentorExperience, gradeAndYear, displayName: String?
var companyName, profession, avatar: String?
    @IBOutlet weak var frameimge:UIImageView!
    @IBOutlet weak var badgeimge:UIImageView!
    @IBOutlet weak var avatarimge:UIImageView!
    @IBOutlet weak var nameboardimge:UIImageView!
    @IBOutlet weak var namelbl:UILabel!
    @IBOutlet weak var companybl:UILabel!
    @IBOutlet weak var professionlbl:UILabel!
    @IBOutlet weak var step1btn:UIButton!
    @IBOutlet weak var step13btn:UIButton!
    @IBOutlet weak var step15btn:UIButton!
    @IBOutlet weak var finalbtn:UIButton!
    @IBOutlet weak var mentorbtn:UIButton!
    @IBOutlet weak var mentordatelbl:UILabel!
    @IBOutlet weak var mentorexperiencelbl:UILabel!
    @IBOutlet weak var gradeyearlbl:UILabel!
    @IBOutlet weak var mentorview:RCustomView!
    @IBOutlet weak var bottomview:RCustomView!
    @IBOutlet weak var DmDPbtn: UIButton!
    
    @IBOutlet weak var ste1datelbl:UILabel!
    @IBOutlet weak var ste13datelbl:UILabel!
    @IBOutlet weak var ste15datelbl:UILabel!
    @IBOutlet weak var finalreportlbl:UILabel!
    
    @IBOutlet weak var coursedatelbl:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if  frame == 1 {
            frameimge.image = UIImage.init(named: "Frame-Gold")
            badgeimge.image = UIImage.init(named: "Badge-Gold")
            nameboardimge.image = UIImage.init(named: "Nameboard_gold")
        }else if frame == 2{
            frameimge.image = UIImage.init(named: "Frame-Silver")
            badgeimge.image = UIImage.init(named: "Badge-Silver")
            nameboardimge.image = UIImage.init(named: "Nameboard_silver")
        }else if frame == 3{
            frameimge.image = UIImage.init(named: "Frame-Bronze")
            badgeimge.image = UIImage.init(named: "Badge-Bronze")
            nameboardimge.image = UIImage.init(named: "Nameboard_bronze")
        }else if frame == 4{
            frameimge.image = UIImage.init(named: "Frame-White")
            badgeimge.image = UIImage.init(named: "Badge-White")
            nameboardimge.image = UIImage.init(named: "Nameboard_white")
        }
        if avatar != "" {
            let imgUrl = BaseURL + (avatar!)
            avatarimge.sd_imageIndicator = SDWebImageActivityIndicator.gray
            avatarimge.sd_setImage(with: URL(string: imgUrl), completed: nil)
        }else{
            avatarimge.image = UIImage.init(named: "dummy_profile")
        }
        if displayName != "" {
            namelbl.text! = displayName!
        }
        if companyName != "" {
            companybl.text! = companyName!
        }
        if profession != "" {
            professionlbl.text! = profession!
        }
        if step1Status == 1 {
            step1btn.setImage(UIImage(named: "follow_up"), for: UIControl.State.normal)
            ste1datelbl.isHidden = false
            ste1datelbl.text! = step1Date!
        }
        if step13_Status == 1 {
            step13btn.setImage(UIImage(named: "follow_up"), for: UIControl.State.normal)
            ste13datelbl.isHidden = false
            ste13datelbl.text! = step13_Date!
        }
        if step15_Status == 1 {
            step15btn.setImage(UIImage(named: "follow_up"), for: UIControl.State.normal)
            ste15datelbl.isHidden = false
            ste15datelbl.text! = step15_Date!
        }
        if finalReportStatus == 1 {
            finalbtn.setImage(UIImage(named: "follow_up"), for: UIControl.State.normal)
            finalreportlbl.isHidden = false
            finalreportlbl.text! = finalReportDate!
        }
        if mentorPassedStatus == 1 {
            mentorview.backgroundColor = UIColor.systemGreen
            mentorbtn.setImage(UIImage(named: "follow_up"), for: UIControl.State.normal)
            mentordatelbl.text! = "Passed ( " + mentorPassedDate! + " ) "
            mentordatelbl.textColor = UIColor.white
            mentorview.backgroundColor = UIColor.hexStringToUIColor(hex: "#008000")
        }
        if mentorExperience != "" {
            print("csdsdf \(String(describing: mentorExperience))")
            mentorexperiencelbl.text! = mentorExperience!
        }
        if gradeAndYear != "" {
            gradeyearlbl.text! = gradeAndYear!
        }
        if courseStatus == 1 {
            DmDPbtn.setImage(UIImage(named: "follow_up"), for: UIControl.State.normal)
            coursedatelbl.text! = " Course ( " + courseDate! + " ) "
        }
        
        if gradeAndYear == "" && mentorExperience == "" {
            bottomview.isHidden = true
        }
       
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
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
