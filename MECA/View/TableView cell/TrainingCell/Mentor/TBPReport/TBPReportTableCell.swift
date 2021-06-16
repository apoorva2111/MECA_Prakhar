//
//  TBPReportTableCell.swift
//  MECA
//
//  Created by Macbook  on 01/06/21.
//

import UIKit
import SDWebImage
import AVFoundation
import AVKit
import Photos
import BSImagePicker
import MobileCoreServices
import Alamofire
import PDFKit
import UniformTypeIdentifiers

class TBPReportTableCell: UITableViewCell {
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    @IBOutlet weak var videotblDocument: UITableView!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnSeeMoreOutlet: UIButton!
    @IBOutlet weak var seeMoreHeightConstraint: NSLayoutConstraint!
    var arrTBPVideoLink = [Traininguploadsmodel]()
    var trainingdetailVC : TrainingdetailVC!
    var trainingvm : TrainingDetailVM!
    
    var imageA2: UIImage!
    var arrDoc : Data!
    var eventData : Detailsinfo?
    var tbpid = ""
    var typetitle = ""
     var checklink = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //tblHeightConstraint.constant = CGFloat(154 * arrTBPVideoLink.count)
        // Initialization code
    }
    func settraininguploadData(dataEvent:Detailsinfo) {
        print("arrVideoLink111... \(dataEvent)")
        if dataEvent.triaingvideo!.count > 0{
            
            if arrTBPVideoLink.count>0{
                arrTBPVideoLink.removeAll()
            }
            arrTBPVideoLink = dataEvent.triainguploads!
            print("arrVideoLink2222 ... \(arrTBPVideoLink)")
//            if arrVideoLink.count > 3{
//                seeMoreHeightConstraint.constant = 30
//
//
//                tblHeightConstraint.constant = CGFloat(154 * 3)
//
//            }else{
              //  seeMoreHeightConstraint.constant = 0
                
                tblHeightConstraint.constant = CGFloat(90 * dataEvent.triainguploads!.count)

           // }
            videotblDocument.register(TBPIndexCell.nib(), forCellReuseIdentifier: "TBPIndexCell")
            videotblDocument.delegate = self
            videotblDocument.dataSource = self
           // tblHeightConstraint.constant = CGFloat(154*arrVideoLink.count)
            videotblDocument.reloadData()
          //  trainingdetailVC.trainingdetailtblview.beginUpdates()
          //  trainingdetailVC.trainingdetailtblview.endUpdates()
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension TBPReportTableCell : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(arrTBPVideoLink.count)")
            return arrTBPVideoLink.count
    
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = videotblDocument.dequeueReusableCell(withIdentifier: "TBPIndexCell", for: indexPath) as! TBPIndexCell
        cell.titlelbl.text! = arrTBPVideoLink[indexPath.row].type_lable!
        cell.filenamelbl.text! =  arrTBPVideoLink[indexPath.row].display_text!
        cell.filenamelbl.textColor = UIColor.hexStringToUIColor(hex: arrTBPVideoLink[indexPath.row].text_color!)
      //  cell.titlelbl.text! = arrTBPVideoLink[indexPath.row].type_lable!
        let uploadstatus = arrTBPVideoLink[indexPath.row].upload_status
        let downloadstatus = arrTBPVideoLink[indexPath.row].download_status
        let revisedlink = arrTBPVideoLink[indexPath.row].revised_link
        let downloadlinks = arrTBPVideoLink[indexPath.row].download_link
        let displayuser = arrTBPVideoLink[indexPath.row].display_text
        if uploadstatus == 1  {
            cell.uploadbtn.isHidden = false
            
            cell.revisedlinkbtn.isHidden = true
            cell.downloadlinkbtn.isHidden = false
           
            
        }else{
            cell.uploadbtn.alpha = 0.5
            cell.uploadbtn.isUserInteractionEnabled = false
           // cell.titlelbl.text! = arrTBPVideoLink[indexPath.row].type!  + "        " + arrTBPVideoLink[indexPath.row].display_text!
           
            
        }
        
        if downloadstatus == 1 {
            cell.downloadlinkbtn.isUserInteractionEnabled = true
            checklink = "Download"
            cell.downloadlinkbtn.addTarget(self, action: #selector(self.DownloadLinkDocument(sender:)), for: .touchUpInside)
          //  cell.filenamelbl.isHidden = false
            
            //cell.filenamelbl.text! = arrTBPVideoLink[indexPath.row].display_text!
        }else{
            cell.downloadlinkbtn.isUserInteractionEnabled = false
            cell.downloadlinkbtn.setImage(UIImage(named: "download Documents"), for: UIControl.State.normal)
            
        }
//        if displayuser == ""
//        {
//            cell.filenamelbl.isHidden = true
//        }
//        else{
//            cell.filenamelbl.text! = arrTBPVideoLink[indexPath.row].display_text!
//        }
        if revisedlink == "" {
            cell.revisedlinkbtn.isHidden = true
            cell.revisedlinkbtn.setImage(UIImage(named: "download Documents"), for: UIControl.State.normal)
            cell.revisedlinkbtn.isUserInteractionEnabled = false
        }else{
            cell.revisedlinkbtn.isHidden = false
            checklink = "Revised"
            cell.revisedlinkbtn.addTarget(self, action: #selector(self.DownloadLinkDocument(sender:)), for: .touchUpInside)
        }
//        if downloadlinks == "" {
//            //cell.downloadlinkbtn.isHidden = true
//            cell.downloadlinkbtn.setImage(UIImage(named: "download Documents"), for: UIControl.State.normal)
//            cell.downloadlinkbtn.isUserInteractionEnabled = false
//            cell.uploadbtn.isHidden = false
//        }else{
//            cell.downloadlinkbtn.isHidden = false
//
//        }
        cell.uploadbtn.tag = indexPath.row
        cell.downloadlinkbtn.tag = indexPath.row
        cell.revisedlinkbtn.tag = indexPath.row
        
        cell.uploadbtn.addTarget(self, action: #selector(self.UploadDocument), for: .touchUpInside)
           // cell.imgyoutube.image = arrVideoLink[indexPath.row].file
           
//            let urlYoutube = arrTBPVideoLink[indexPath.row].link
//            let urlID = urlYoutube?.youtubeID
//            let urlStr = "http://img.youtube.com/vi/\(urlID ?? "")/1.jpg"
//            let url = URL(string: urlStr)!
//            cell.videoImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
//            cell.videoImg.sd_setImage(with: url, completed: nil)
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//            let obj = arrVideoLink[indexPath.row]
//            if obj.link != ""{
//                let objLink = (obj.link)!
//
//                guard let url = URL(string: objLink) else { return }
//                UIApplication.shared.open(url)
//            }
        
    }
    
    @objc func UploadDocument(sender: UIButton){
        
        let trianingid =  userDef.string(forKey: UserDefaultKey.traininguploadid)!
       
        let objtitle = arrTBPVideoLink[sender.tag].type
        
        tbpid = trianingid
        typetitle = objtitle!
        print("upload click\(tbpid)....\(typetitle)")
        let importMenu = UIDocumentPickerViewController(documentTypes: ["com.microsoft.word.doc","org.openxmlformats.wordprocessingml.document", kUTTypePDF as String], in: UIDocumentPickerMode.import)
            importMenu.delegate = self
            importMenu.modalPresentationStyle = .formSheet


        self.trainingdetailVC!.present(importMenu, animated: true, completion: nil)
        
    }
    
    @objc func DownloadLinkDocument(sender: UIButton){
        GlobalObj.displayLoader(true, show: true)
        var objurl = ""
        
        if checklink == "Download" {
            objurl = arrTBPVideoLink[sender.tag].download_link!
        }else{
            objurl = arrTBPVideoLink[sender.tag].revised_link!
        }
        

        if let url = URL(string: BaseURL + objurl){
            GlobalObj.run(after: 1) {
                guard let url = URL(string: BaseURL + objurl)else{return}



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
//MARK:- Document picker
extension TBPReportTableCell : UIDocumentMenuDelegate,UIDocumentPickerDelegate{
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        self.trainingdetailVC!.present(documentPicker, animated: true, completion: nil)

    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
     print("import result : \(myURL)")
        do {
            let docData = try Data(contentsOf: myURL as URL)
            print("doc data\(docData)")
            //arrDoc.append(docData)
            arrDoc = docData
            print("doc arrDoc\(arrDoc)")
            
        } catch {
            print("Unable to load data: \(error)")
        }
        
        drawPDFfromURL(url: myURL) { (img) in
            if img != nil{
                self.imageA2 = img!
            print("img ...\(img)")
                
            }
            

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
              //  self.documentCollectionView.reloadData()
                self.calltraininguploadWebserviceapi(type:self.typetitle , tbptitle: self.tbpid, image: self.imageA2)
            }
        }
    }
          


    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        self.trainingdetailVC!.dismiss(animated: true, completion: nil)
    }
    
    func drawPDFfromURL(url: URL,completion: @escaping (UIImage?) -> Void) -> UIImage? {
        guard let document = CGPDFDocument(url as CFURL) else { return nil }
        guard let page = document.page(at: 1) else { return nil }
        
        let pageRect = page.getBoxRect(.cropBox)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            UIColor.white.set()
            //ctx.fill(pageRect)
            ctx.fill(CGRect.init(x: 0, y: 0, width: 70, height: 70))
            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
            
            ctx.cgContext.drawPDFPage(page)
            
        }
        completion(img)
        return img
    }
    // webServicesToTrainingupload
    func calltraininguploadWebserviceapi(type:String,tbptitle:String,image:UIImage) {
        GlobalObj.displayLoader(true, show: true)
        let param = ["type":type,
                     "tbp":tbptitle]
        let accessToken = userDef.string(forKey: UserDefaultKey.token)
        let header :[String: String] = ["Authorization": "Bearer \(accessToken ?? "")",
                                        "Content-Type": "application/json",
                                        "Accept": "application/json"]
        APIClient.webServicesToTrainingupload(params: param, header: header,file: self.arrDoc) { (response) in
            print("trainig upload response\( response)")
            self.trainingdetailVC!.showToast(message: "PDF File downloaded")
            if let respCode = response.resp_code{

                
                if respCode == 200{
                    if let objDate = response.data {
                        //self.eventData = objDate
                        
                        
                        self.trainingdetailVC.trainingviewModel.eventData = response.data
                        
                        
                        GlobalObj.displayLoader(true, show: false)
                    self.trainingdetailVC!.showToast(message: response.message!)
                        self.videotblDocument.reloadData()
                        self.trainingdetailVC.trainingdetailtblview.reloadData()
                    }

                
            }
           // GlobalObj.showAlertVC(title: "Message", message: , controller: self)

            }
        }
    }
    
    
    
}
