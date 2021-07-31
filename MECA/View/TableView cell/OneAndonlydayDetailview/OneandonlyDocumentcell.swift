//
//  OneandonlyDocumentcell.swift
//  MECA
//
//  Created by Macbook  on 06/07/21.
//

import UIKit

class OneandonlyDocumentcell: UITableViewCell {
    @IBOutlet weak var tblDocument: UITableView!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnSeeMoreOutlet: UIButton!
    @IBOutlet weak var seeMoreHeightConstraint: NSLayoutConstraint!
    var arrEventDocument = [Event_documents]()
    
    var oneandonlyDetailVC : oneandonlydetailVC!
    override func awakeFromNib() {
        super.awakeFromNib()
        btnSeeMoreOutlet.isHidden = true
        seeMoreHeightConstraint.constant = 0
        btnSeeMoreOutlet.isHidden = true
        // Initialization code
    }
    static func nib() -> UINib {
        return UINib(nibName: "OneandonlyDocumentcell", bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setEventData(dataEvent:KaizenInfoDataModel) {
        
        print("dataevent one and only \(dataEvent)")
        if dataEvent.oneandonly_documents?.count == 0 {
            seeMoreHeightConstraint.constant = 0
        }else{
            if dataEvent.oneandonly_documents!.count > 0 {
                arrEventDocument.removeAll()
            }
            arrEventDocument = dataEvent.oneandonly_documents!
            if arrEventDocument.count > 0{
                
                btnSeeMoreOutlet.isHidden = true
                seeMoreHeightConstraint.constant = 0
                btnSeeMoreOutlet.isHidden = true
                tblHeightConstraint.constant = CGFloat(43 * dataEvent.oneandonly_documents!.count)
               // tblHeightConstraint.constant = CGFloat(43 * 3)

            }
            tblDocument.register(OneandonlyDocumentcontentCell.nib(), forCellReuseIdentifier: "OneandonlyDocumentcontentCell")
            tblDocument.delegate = self
            tblDocument.dataSource = self
            tblDocument.reloadData()
            oneandonlyDetailVC.tblDetailView.beginUpdates()
            oneandonlyDetailVC.tblDetailView.endUpdates()
        }
        
    }
    
}
extension OneandonlyDocumentcell:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return arrEventDocument.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblDocument.dequeueReusableCell(withIdentifier: "OneandonlyDocumentcontentCell", for: indexPath) as! OneandonlyDocumentcontentCell
        cell.txtPresentation.isUserInteractionEnabled = false
        cell.txtPresentation.text = arrEventDocument[indexPath.row].name
        cell.btnDownloadOutlet.tag = indexPath.row
        cell.btnDownloadOutlet.addTarget(self, action: #selector(self.DownloadDocument), for: .touchUpInside)
       // cell.btnDownloadOutlet.addTarget(self, action: #selector(self.DownloadDocument), for: .touchUpInside)

        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let objUrl = arrowArray[indexPath.row]
//
//        let vc = FlowController().instantiateViewController(identifier: "PDFReaderVC", storyBoard: "Category") as! PDFReaderVC
//        vc.isFromDetailPage = true
//        if objUrl != ""{
//            vc.detailPageurl = BaseURL + objUrl!
//        }
//        detailVC.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43
    }
    @objc func DownloadDocument(sender: UIButton){
        GlobalObj.displayLoader(true, show: true)
        let objUrl = arrEventDocument[sender.tag].file

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
                    self.oneandonlyDetailVC!.showToast(message: "PDF File downloaded")
                    }

                }
            }
        }
    }
//
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
//
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
//
//    // check to avoid saving a file multiple times
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
