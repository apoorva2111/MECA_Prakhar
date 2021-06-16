

import UIKit

class NewsVideoListVC: UIViewController {
    @IBOutlet weak var tblVideoList: UITableView!
   
    var viewModel : NewsVideoListVM!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = NewsVideoListVM.init(controller: self)
        // Do any additional setup after loading the view.
        tblVideoList.register(UINib.init(nibName: "NewsCatTVCell", bundle: nil), forCellReuseIdentifier: "NewsCatTVCell")
        
        viewModel.callWebserviceForVideo(keyword: "")
        
        
    }
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCreateNews(_ sender: UIButton) {
        let vc = FlowController().instantiateViewController(identifier: "AddNewsViewController", storyBoard: "Home")as! AddNewsViewController
        vc.newsHomeCreate = "Video"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension NewsVideoListVC : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.getNumbersOfSections()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumbersOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.getCellForRowAt(indexPath, tableView: tblVideoList)
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        viewModel.getHeightForHeaderAt(section, tableView: tblVideoList)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath, tableView: tblVideoList)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.getHeightForRowAt(indexPath, tableView: tblVideoList)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        viewModel.getBaseTableHeaderViewFor(section, tableView: tblVideoList)
    }

}
