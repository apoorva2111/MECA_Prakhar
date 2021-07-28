
import UIKit

class NewsDetailVC: UIViewController {

    @IBOutlet weak var tblNewsDetail: UITableView!
    var viewModel : NewsDetailVM!
    var newsID = ""
    var isFromVideoList = false
    var isClickedRelatedNews = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = NewsDetailVM.init(controller: self)
        registerXib()
        if isFromVideoList{
            viewModel.callWebserviceFroVideoInfo(videoId: newsID)
        }else{
            viewModel.callWebserviceFroNewInfo(newsId: newsID)
        }
    }
    
    func registerXib() {
        tblNewsDetail.register(UINib.init(nibName: "NewsImageTVCell", bundle: nil), forCellReuseIdentifier: "NewsImageTVCell")
        tblNewsDetail.register(UINib.init(nibName: "NewContentTVCell", bundle: nil), forCellReuseIdentifier: "NewContentTVCell")
        tblNewsDetail.register(UINib.init(nibName: "DocumentTVCell", bundle: nil), forCellReuseIdentifier: "DocumentTVCell")

        tblNewsDetail.register(UINib.init(nibName: "RelatedNewsTVCell", bundle: nil), forCellReuseIdentifier: "RelatedNewsTVCell")
        tblNewsDetail.reloadData()
    }

    @IBAction func btnBackAction(_ sender: UIButton) {
        if isClickedRelatedNews{
            isClickedRelatedNews = false
            if isFromVideoList{
                viewModel.callWebserviceFroVideoInfo(videoId: newsID)
            }else{
                viewModel.callWebserviceFroNewInfo(newsId: newsID)
            }
        }else{
            self.navigationController?.popViewController(animated: true)
        }
        
    }
}

//Tableview Delegate
extension NewsDetailVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumbersOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.getCellForRowAt(indexPath, tableView: tblNewsDetail)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.getHeightForRowAt(indexPath, tableView: tblNewsDetail)
    }
    
}
