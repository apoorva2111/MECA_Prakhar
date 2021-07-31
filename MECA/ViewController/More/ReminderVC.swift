//
//  ReminderVC.swift
//  MECA
//
//  Created by Macbook  on 11/05/21.
//

import UIKit

class ReminderVC: UIViewController {

    @IBOutlet weak var headerView: RCustomView!
    @IBOutlet weak var remindertblview:UITableView!
    var reminderarrList = [Reminderdata]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        remindertblview.estimatedRowHeight = 70
        self.remindertblview.rowHeight = UITableView.automaticDimension
        remindertblview?.register(ReminderTableCell.nib, forCellReuseIdentifier: ReminderTableCell.identifier)
        remindertblview?.dataSource = self
        remindertblview?.delegate = self
        callwedservicereminderdata()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnBackAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    func callwedservicereminderdata()
    {
        GlobalObj.displayLoader(true, show: true)
        
        APIClient.webserviceForReminder{ (result) in
            print("result\(result)")
            if let respCode = result.resp_code{
                
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)

                    if let arrDate = result.data{
                        if self.reminderarrList.count>0{
                            self.reminderarrList.removeAll()
                        }
                        if arrDate.count>0{
                            self.reminderarrList = arrDate
                        }
                    }
                    self.remindertblview.reloadData()
                }else{
                    GlobalObj.displayLoader(true, show: false)

                }
            }
            
            GlobalObj.displayLoader(true, show: false)

        }
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
//Mark: - Tableview Datasource Methods
extension ReminderVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminderarrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReminderTableCell.identifier, for: indexPath) as! ReminderTableCell
        let objFeed = reminderarrList[indexPath.row]
        cell.setCellreminderdetails(feed: objFeed)
         return cell
    }
}
//MARK: - TableView Delegate Methods
extension ReminderVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: SDGSListTableCell.identifier, for: indexPath) as? SDGSListTableCell
//        cell!.backgroundColor = UIColor.white
//
//        let obj = arrList[indexPath.row]
//
//
//        let story = UIStoryboard(name: "Category", bundle:nil)
//      //  let obj = arrList[indexPath.row]
//        let vc = story.instantiateViewController(withIdentifier: "SDGSListVC") as! SDGSListvc
//        vc.idvalue = String(obj.id ?? "0")
//        vc.headerImageValue = String(obj.lable ?? "0")
//
//        self.navigationController?.pushViewController(vc, animated: true)
//        self.SDGSCategoryTableView.reloadData()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
