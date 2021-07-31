//
//  GRSupportvc.swift
//  MECA
//
//  Created by Macbook  on 21/07/21.
//

import UIKit

class GRSupportvc: UIViewController {
    
    
    
    @IBOutlet weak var headerView: RCustomView!
    @IBOutlet weak var supporttblview:UITableView!
    
    var supportarrList = [GRSupportdatas]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        supporttblview.estimatedRowHeight = 125
        self.supporttblview.rowHeight = UITableView.automaticDimension
        supporttblview?.register(GrSupportLInkTblCell.nib, forCellReuseIdentifier: GrSupportLInkTblCell.identifier)
        supporttblview?.dataSource = self
        supporttblview?.delegate = self
        callwedservicesupportdata()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnBackAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }

    
    func callwedservicesupportdata()
    {
        GlobalObj.displayLoader(true, show: true)
        
        APIClient.webserviceForGRSupportApi{ (result) in
            print("result\(result)")
            if let respCode = result.resp_code{
                
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)

                    if let arrDate = result.data{
                        if self.supportarrList.count>0{
                            self.supportarrList.removeAll()
                        }
                        if arrDate.count>0{
                            self.supportarrList = arrDate
                        }
                    }
                    self.supporttblview.reloadData()
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
extension GRSupportvc: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("self.supportarrList.count...\(self.supportarrList.count)")
        return supportarrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GrSupportLInkTblCell.identifier, for: indexPath) as! GrSupportLInkTblCell
        let objFeed = supportarrList[indexPath.row]
        cell.setCellsupportdetails(feed: objFeed)
         return cell
    }
}
//MARK: - TableView Delegate Methods
extension GRSupportvc: UITableViewDelegate {
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
        return 125
    }
}
