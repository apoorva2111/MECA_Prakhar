//
//  oneandonlydetailVC.swift
//  MECA
//
//  Created by Macbook  on 05/07/21.
//

import UIKit

class oneandonlydetailVC: UIViewController {
    var viewModel : oneandonlydetailVM!
    @IBOutlet weak var tblDetailView: UITableView!
    var eventID = ""
    @IBOutlet weak var nodatalbl:UILabel!
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var viewImgPreview: UIView!
    @IBOutlet weak var imgPreview: UIImageView!
    private var pullControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("one and only eventID\(eventID)")
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        // Do any additional setup after loading the view.
        tblDetailView.isHidden = true

        viewModel = oneandonlydetailVM.init(controller: self)
        
        tblDetailView.register(detailcoverimgcell.nib(), forCellReuseIdentifier: viewModel.identifierCoverImgCell)
        tblDetailView.register(UINib.init(nibName: "oneandonlyContentTVCell", bundle: nil), forCellReuseIdentifier: "oneandonlyContentTVCell")
        tblDetailView.register(UINib.init(nibName: "OneandonlyDocumentcell", bundle: nil), forCellReuseIdentifier: "OneandonlyDocumentcell")
        tblDetailView.register(UINib.init(nibName: "oneandonlylikeCell", bundle: nil), forCellReuseIdentifier: "oneandonlylikeCell")
        
        
        viewImgPreview.isHidden = true
       
        pullControl.tintColor = UIColor.gray
        pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tblDetailView.refreshControl = pullControl
        } else {
            tblDetailView.addSubview(pullControl)
        }
        
        viewModel.callONEANDONLYInfoWebservice { (result) in
            if result{
                //self.tblDetailView.reloadData()
            }
        }
    }
    
    @objc private func refreshListData(_ sender: Any) {
        
       
            viewModel.callONEANDONLYInfoWebservice { (result) in
                if result{
                    //self.tblDetailView.reloadData()
                }
            }
        
        self.pullControl.endRefreshing() // You can stop after API Call

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
        {
            let touch = touches.first
            if touch?.view != self.imgPreview
            {
                self.viewImgPreview.isHidden = true
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
extension oneandonlydetailVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumbersOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.getCellForRowAt(indexPath, tableView: tblDetailView)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.getHeightForRowAt(indexPath, tableView: tblDetailView)
    }
    
}
