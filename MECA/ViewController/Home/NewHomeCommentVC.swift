//
//  NewHomeCommentVC.swift
//  MECA

import UIKit

class NewHomeCommentVC: UIViewController {
  
    @IBOutlet weak var tbllComment: customTblView!
    @IBOutlet weak var txtComment: UITextView!
    var viewModel : NewHomeCommentVM!
    var feedDetail : NewHomeData!
    var currentPage : Int = 1
    var checkPagination = ""
    
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
        if txtComment.text != ""{
            viewModel.addComment(feedId: String(feedDetail.id!), comment: txtComment.text!, parent: "0", is_reply: "0", isfile: "0")
        }
    }
    @IBAction func btnBackAction(_ sender: UIButton) {
        userDef.setValue("hideTable", forKey: UserDefaultKey.replyView)
        userDef.synchronize()

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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
         return 100
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if BoolValue.isClickOnCategory{
            
            if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
                if indexPath == lastVisibleIndexPath {
                    if indexPath.row == viewModel.arrCommentList.count-1{
                        self.checkPagination = "pagination"
                        currentPage += 1
                        GlobalObj.run(after: 2) {
                            GlobalObj.displayLoader(true, show: true)
                            self.viewModel.callWebserviceForCommentList(feed: String(self.feedDetail.id!), limit: "10", page: String(self.currentPage))
                        }
                    }
                }
            }
        }
    }
    
}
