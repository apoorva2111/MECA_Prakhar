//
//  TrainingdetailVC.swift
//  MECA
//
//  Created by Macbook  on 28/05/21.
//

import UIKit

class TrainingdetailVC: UIViewController {
    @IBOutlet weak var trainingdetailtblview:UITableView!
    @IBOutlet weak var lblheader:UILabel!
    var trainingviewModel : TrainingDetailVM!
    var eventData : Data_Event?
    var headername: String? = ""
    var eventID = ""
    var arrEventDocument = [Event_documents]()
    var Trainingview = true
    var isFromPDCA = true
    @IBOutlet weak var viewImgPreview: UIView!
    @IBOutlet weak var imgPreview: UIImageView!
    private var pullControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        trainingdetailtblview.isHidden = true
        trainingviewModel = TrainingDetailVM.init(controller: self)
        
        
        trainingdetailtblview.register(MentorTableCell.nib, forCellReuseIdentifier: MentorTableCell.identifier)
        trainingdetailtblview.register(DescriptionTableCell.nib(), forCellReuseIdentifier: trainingviewModel.descripcell)
        trainingdetailtblview.register(watchvideoTableCell.nib, forCellReuseIdentifier: trainingviewModel.watchvideocell)
        trainingdetailtblview.register(TBPReportTableCell.nib, forCellReuseIdentifier: trainingviewModel.uploadscell)
        trainingdetailtblview.register(PdcaTableCell.nib, forCellReuseIdentifier: trainingviewModel.pdcatablecel)
       
        self.trainingdetailtblview.setNeedsLayout()
            self.trainingdetailtblview.layoutIfNeeded()
        lblheader.text! = headername!
        pullControl.tintColor = UIColor.gray
        pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            trainingdetailtblview.refreshControl = pullControl
        } else {
            trainingdetailtblview.addSubview(pullControl)
        }
        if Trainingview {
            
            if isFromPDCA {
                trainingviewModel.callTrainingPDCAInfoWebservice()
            }else{
                trainingviewModel.callTrainingInfoWebservice()
            }
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
//        {
//            let touch = touches.first
//            if touch?.view != self.imgPreview
//            {
//                self.viewImgPreview.isHidden = true
//            }
//        }
    
    @objc private func refreshListData(_ sender: Any) {
        
        if Trainingview {
            
            if isFromPDCA {
                trainingviewModel.callTrainingPDCAInfoWebservice()
            }else{
                trainingviewModel.callTrainingInfoWebservice()
            }
            
        }
        
        

        self.pullControl.endRefreshing() // You can stop after API Call

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
extension TrainingdetailVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trainingviewModel.getNumbersOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        trainingviewModel.getCellForRowAt(indexPath, tableView: trainingdetailtblview)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        trainingviewModel.getHeightForRowAt(indexPath, tableView: trainingdetailtblview)
    }
    
}
