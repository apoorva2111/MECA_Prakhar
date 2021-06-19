//
//  HomeNewsFeedVC.swift
//  MECA
//


import UIKit

class HomeNewsFeedVC: UIViewController {

   
    @IBOutlet weak var viewFooter: FooterTabView!
    @IBOutlet weak var tblFeed: UITableView!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var viewLike: UIView!
    @IBOutlet weak var viewMoreOption: UIView!
    @IBOutlet weak var tblLikeList: UITableView!
    @IBOutlet weak var lblLikeCount: UILabel!
    var currentPage : Int = 1
    var checkPagination = ""
    @IBOutlet weak var viewDownload: UIView!
    @IBOutlet weak var viewEditPost: UIView!
    @IBOutlet weak var viewDeletePost: UIView!

 
  
    
    var viewModel : HomeNewsFeedVM!
    private var pullControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()

        viewBackground.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setView()
    }
    
    func setView() {
        viewModel = HomeNewsFeedVM.init(controller: self)
        
        tblFeed.register(UINib.init(nibName: "HomeNewsFeedTVCell", bundle: nil), forCellReuseIdentifier: "HomeNewsFeedTVCell")
            //
        tblLikeList.register(UINib.init(nibName: "HomeNewsLikeTVCell", bundle: nil), forCellReuseIdentifier: "HomeNewsLikeTVCell")

        tblFeed.delegate = self
        tblFeed.dataSource = self
        tblLikeList.delegate = self
        tblLikeList.dataSource = self
        viewFooter.footerTabViewDelegate = self
        viewFooter.imgHome.image = UIImage.init(named: "Home_active")
        viewFooter.lblHome.font = UIFont.init(name: "SFPro-Bold", size: 12)
        viewFooter.lblCalender.font = UIFont.init(name: "SFPro-Regular", size: 12)
        viewFooter.lblCategory.font = UIFont.init(name: "SFPro-Regular", size: 12)
        viewFooter.lblNotification.font = UIFont.init(name: "SFPro-Regular", size: 12)
        viewFooter.lblMore.font = UIFont.init(name: "SFPro-Regular", size: 12)

        pullControl.tintColor = UIColor.gray
        pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tblFeed.refreshControl = pullControl
        } else {
            tblFeed.addSubview(pullControl)
        }
    }
    @objc private func refreshListData(_ sender: Any) {
        currentPage = 1
        self.checkPagination = "get"
        viewModel.callWebserviceForFeed(page: String(currentPage))
        self.pullControl.endRefreshing() // You can stop after API Call
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
           let touch = touches.first
           if touch?.view == self.viewBackground
           {
            self.viewBackground.isHidden = true
           }
       }
    @IBAction func btnEditPost(_ sender: UIButton) {
        let vc = FlowController().instantiateViewController(identifier: "MECAPostVC", storyBoard: "Home")as! MECAPostVC
        vc.feedId = viewModel.feedId
        self.navigationController?.pushViewController(vc, animated: true)

    }
    @IBAction func btnDeletePostAction(_ sender: UIButton) {
        viewModel.callWebserviceFroDeleteComment(feedId: viewModel.feedId)
    }
    @IBAction func btnPlusAction(_ sender: UIButton) {
        let vc = FlowController().instantiateViewController(identifier: "PlusSelectCategoryVC", storyBoard: "Home")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnDounloadAction(_ sender: UIButton) {
        GlobalObj.displayLoader(true, show: true)
      
        if let url = URL(string: BaseURL + viewModel.documentLink){
            print(url)
            GlobalObj.run(after: 1) {
                guard let url = URL(string: BaseURL + self.viewModel.documentLink)else{return}
                
                
                
                FileDownloader.loadFileAsync(url: url) { (path, error) in
                    print("PDF File downloaded to : \(path!)")
                    let pdfData = NSMutableData()
                            UIGraphicsBeginPDFContextToData(pdfData, CGRect(x: 0, y: 0, width: 0, height: 0), nil)



                            UIGraphicsEndPDFContext();
                            // 5. Save PDF file

                            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

                            pdfData.write(toFile: path!, atomically: true)
                    

                    OperationQueue.main.addOperation {

                    GlobalObj.displayLoader(true, show: false)
                    self.showToast(message: "PDF File downloaded")
                    }

                }
            }
        }
    }
    
    func savePdf(urlString:String, fileName:String) {
            DispatchQueue.main.async {
                let url = URL(string: urlString)
                let pdfData = try? Data.init(contentsOf: url!)
                let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
                let pdfNameFromUrl = "YourAppName-\(fileName).pdf"
                let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
                do {
                    try pdfData?.write(to: actualPath, options: .atomic)
                    print("pdf successfully saved!")
                } catch {
                    print("Pdf could not be saved")
                }
            }
        }

        func showSavedPdf(url:String, fileName:String) {
            if #available(iOS 10.0, *) {
                do {
                    let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                    let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
                    for url in contents {
                        if url.description.contains("\(fileName).pdf") {
                           // its your file! do what you want with it!

                    }
                }
            } catch {
                print("could not locate pdf file !!!!!!!")
            }
        }
    }

    // check to avoid saving a file multiple times
    func pdfFileAlreadySaved(url:String, fileName:String)-> Bool {
        var status = false
        if #available(iOS 10.0, *) {
            do {
                let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
                for url in contents {
                    if url.description.contains("YourAppName-\(fileName).pdf") {
                        status = true
                    }
                }
            } catch {
                print("could not locate pdf file !!!!!!!")
            }
        }
        return status
    }

}

//MARK:- Footerview Delegate
extension HomeNewsFeedVC: FooterTabViewDelegate{
    func footerBarAction(strType: String) {
        if strType == "Home"{

        }else if strType == "Calendar"{
            
            let vc = FlowController().instantiateViewController(identifier: "HomeVC", storyBoard: "Home")
            self.navigationController?.pushViewController(vc, animated:false)
            
        }else if strType == "Categories"{

            let mainVC = FlowController().instantiateViewController(identifier: "NavCategory", storyBoard: "Category")
            let appDel = UIApplication.shared.delegate as! AppDelegate
            appDel.window?.rootViewController = mainVC
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            let duration: TimeInterval = 0.3

            UIView.transition(with: appDel.window!, duration: duration, options: options, animations: {}, completion:
            { completed in
                // maybe do something on completion here
            })
            appDel.window?.makeKeyAndVisible()

       
        }else if strType == "Notification"{
            
            let vc = FlowController().instantiateViewController(identifier: "NotificationVC", storyBoard: "Home")
            self.navigationController?.pushViewController(vc, animated:false)
         
        }else{
            let vc = FlowController().instantiateViewController(identifier: "MoreVC", storyBoard: "Home")
            self.navigationController?.pushViewController(vc, animated:false)
        }
    }
}

//MARK:- UITableview Delegate
extension HomeNewsFeedVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumbersOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.getCellForRowAt(indexPath, tableView: tableView)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.getHeightForRowAt(indexPath, tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                if indexPath.row == viewModel.arrFeed.count-1{
                    self.checkPagination = "pagination"
                    currentPage += 1
                    GlobalObj.run(after: 2) {
                        GlobalObj.displayLoader(true, show: true)
                        self.viewModel.callWebserviceForFeed(page: String(self.currentPage))
                        
                    }
                }
            }
        }
    }
    
}
