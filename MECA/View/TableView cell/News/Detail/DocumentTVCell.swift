

import UIKit

class DocumentTVCell: UITableViewCell {

    @IBOutlet weak var tblDocumentHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tblDocument: UITableView!
    @IBOutlet weak var btnSeeMoreOutlet: UIButton!
    @IBOutlet weak var seeMoreHightConstraint: NSLayoutConstraint!
    
    var arrDocument = [Document_News]()
    var viewController : NewsDetailVC?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setNewsVideoData(grData:VideoInfoData){
        print(grData)

        GlobalValue.newsDetailDocument = "News Detail"
        if grData.documents?.count == 0{
            tblDocumentHeightConstraint.constant = 0
        }else{
            if grData.documents!.count > 0 {
                arrDocument.removeAll()
            }
            arrDocument = grData.documents!
            if arrDocument.count > 3{
                seeMoreHightConstraint.constant = 30
                btnSeeMoreOutlet.isHidden = false
               btnSeeMoreOutlet.addTarget(self, action: #selector(self.SeeMoreAction), for: .touchUpInside)
                tblDocumentHeightConstraint.constant = CGFloat(43 * 3)

            }else{
                seeMoreHightConstraint.constant = 0
                btnSeeMoreOutlet.isHidden = true
                tblDocumentHeightConstraint.constant = CGFloat(43 * grData.documents!.count)

            }
           

        tblDocument.register(DocumentContentCell.nib(), forCellReuseIdentifier: "DocumentContentCell")
        tblDocument.delegate = self
        tblDocument.dataSource = self
        tblDocument.reloadData()
        viewController?.tblNewsDetail.beginUpdates()
        viewController?.tblNewsDetail.endUpdates()
        }
    }
    
    func setNewsDocumentData(grData:NewsDetail_Data){
        GlobalValue.newsDetailDocument = "News Detail"
        if grData.documents?.count == 0{
            tblDocumentHeightConstraint.constant = 0
        }else{
            if grData.documents!.count > 0 {
                arrDocument.removeAll()
            }
            arrDocument = grData.documents!
            if arrDocument.count > 3{
                seeMoreHightConstraint.constant = 30
                btnSeeMoreOutlet.isHidden = false
               btnSeeMoreOutlet.addTarget(self, action: #selector(self.SeeMoreAction), for: .touchUpInside)
                tblDocumentHeightConstraint.constant = CGFloat(43 * 3)

            }else{
                seeMoreHightConstraint.constant = 0
                btnSeeMoreOutlet.isHidden = true
                tblDocumentHeightConstraint.constant = CGFloat(43 * grData.documents!.count)

            }
           

        tblDocument.register(DocumentContentCell.nib(), forCellReuseIdentifier: "DocumentContentCell")
        tblDocument.delegate = self
        tblDocument.dataSource = self
        tblDocument.reloadData()
        viewController?.tblNewsDetail.beginUpdates()
        viewController?.tblNewsDetail.endUpdates()
        }
    }
    
    @objc func SeeMoreAction(sender: UIButton){
        if sender.isSelected{
            sender.isSelected = false
            sender.setTitle("See More", for: .normal)
            tblDocumentHeightConstraint.constant = CGFloat(43 * 3)
            tblDocument.reloadData()
            viewController?.tblNewsDetail.beginUpdates()
            viewController?.tblNewsDetail.endUpdates()
        }else {
            sender.isSelected = true
            sender.setTitle("Less", for: .normal)
            tblDocumentHeightConstraint.constant = CGFloat(43 * arrDocument.count)
            tblDocument.reloadData()
            viewController?.tblNewsDetail.beginUpdates()
            viewController?.tblNewsDetail.endUpdates()

        }

    }
}

extension DocumentTVCell : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrDocument.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblDocument.dequeueReusableCell(withIdentifier: "DocumentContentCell", for: indexPath) as! DocumentContentCell
        cell.txtPresentation.isUserInteractionEnabled = false
        cell.txtPresentation.text = arrDocument[indexPath.row].name
        cell.btnDownloadOutlet.tag = indexPath.row
        cell.btnDownloadOutlet.addTarget(self, action: #selector(self.DownloadDocument), for: .touchUpInside)

        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objUrl = arrDocument[indexPath.row].file
        
        let vc = FlowController().instantiateViewController(identifier: "PDFReaderVC", storyBoard: "Category") as! PDFReaderVC
        vc.isFromDetailPage = true
        if objUrl != ""{
            vc.detailPageurl = BaseURL + objUrl!
        }
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43
    }
    
    @objc func DownloadDocument(sender: UIButton){
        
        GlobalObj.displayLoader(true, show: true)
        let objUrl = arrDocument[sender.tag].file
      
        if let url = URL(string: BaseURL + objUrl!){
            GlobalObj.run(after: 1) {
                guard let url = URL(string: BaseURL + objUrl!)else{return}
                
                
                
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
                        self.viewController!.showToast(message: "PDF File downloaded")
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
