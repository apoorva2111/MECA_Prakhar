//
//  NewHomeCommentVC.swift
//  MECA

import UIKit

class NewHomeCommentVC: UIViewController {
  
    @IBOutlet weak var tbllComment: UITableView!
    @IBOutlet weak var txtComment: UITextView!
    var viewModel : NewHomeCommentVM!
    var feedDetail : NewHomeData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = NewHomeCommentVM.init(controller: self)
        // Do any additional setup after loading the view.
        setView()
    }
    func setView() {
        
        tbllComment.register(UINib.init(nibName: "HomeNewsFeedTVCell", bundle: nil), forCellReuseIdentifier: "HomeNewsFeedTVCell")
            //
        tbllComment.register(UINib.init(nibName: "NewHomeCommentTVCell", bundle: nil), forCellReuseIdentifier: "NewHomeCommentTVCell")

        tbllComment.delegate = self
        tbllComment.dataSource = self
        
        
    }
    @IBAction func btnSendCommentAction(_ sender: UIButton) {
    }
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension NewHomeCommentVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumbersOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.getCellForRowAt(indexPath, tableView: tbllComment)
    }
    
    
}
