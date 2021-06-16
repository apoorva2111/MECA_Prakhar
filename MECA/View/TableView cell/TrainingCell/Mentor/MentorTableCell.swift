//
//  MentorTableCell.swift
//  MECA
//
//  Created by Macbook  on 28/05/21.
//

import UIKit

class MentorTableCell: UITableViewCell {
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    @IBOutlet weak var tblDocument: UITableView!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnSeeMoreOutlet: UIButton!
    @IBOutlet weak var seeMoreHeightConstraint: NSLayoutConstraint!
    var arrTrainingDocument = [Invitationsdata]()
    var trainingdetailVC : TrainingdetailVC!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        btnSeeMoreOutlet.isHidden = true
        seeMoreHeightConstraint.constant = 0
        btnSeeMoreOutlet.isHidden = true
        //tblHeightConstraint.constant = CGFloat(43 * arrEventDocument.count)
        // Initialization code
    }

    func setEventData(dataEvent:Detailsinfo) {
        
        if dataEvent.invitations?.count == 0{
            tblHeightConstraint.constant = 0
        }else{
            if dataEvent.invitations!.count > 0 {
                arrTrainingDocument.removeAll()
            }
            arrTrainingDocument = dataEvent.invitations!
            if arrTrainingDocument.count > 0{
                
                btnSeeMoreOutlet.isHidden = true
                seeMoreHeightConstraint.constant = 0
                btnSeeMoreOutlet.isHidden = true
                tblHeightConstraint.constant = CGFloat(43 * dataEvent.invitations!.count)
               // tblHeightConstraint.constant = CGFloat(43 * 3)

            }
           

        tblDocument.register(InvitatioTableCell.nib(), forCellReuseIdentifier: "InvitatioTableCell")
        tblDocument.delegate = self
        tblDocument.dataSource = self
        tblDocument.reloadData()
            trainingdetailVC.trainingdetailtblview.beginUpdates()
            trainingdetailVC.trainingdetailtblview.endUpdates()
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension MentorTableCell:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return arrTrainingDocument.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblDocument.dequeueReusableCell(withIdentifier: "InvitatioTableCell", for: indexPath) as! InvitatioTableCell
        cell.txtPresentation.isUserInteractionEnabled = false
        cell.txtPresentation.text = arrTrainingDocument[indexPath.row].name
        cell.btnDownloadOutlet.tag = indexPath.row
        cell.btnDownloadOutlet.addTarget(self, action: #selector(self.DownloadDocument), for: .touchUpInside)

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
        let objUrl = arrTrainingDocument[sender.tag].file

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
                    self.trainingdetailVC!.showToast(message: "PDF File downloaded")
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
