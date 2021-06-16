//
//  PdcaTableCell.swift
//  MECA
//
//  Created by Macbook  on 04/06/21.
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
class PdcaTableCell: UITableViewCell {
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    @IBOutlet weak var videotblDocument: UITableView!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnSeeMoreOutlet: UIButton!
    @IBOutlet weak var seeMoreHeightConstraint: NSLayoutConstraint!
    var youtubeurlpass = ""
    var pdca = 0
    var id = 0
    var sessionid = 0
    var imageA2: UIImage!
    var uploadscount = 0
    var arrDoc : Data!
    var actualController:UIViewController?
    var arrpdcaVideoLink = [sessionFilemodel]()
    var separtepdcaVideoLink = [Pdca_VideosModel]()
    var separtepdcaupload = [Pdca_uploadModel]()
    var trainingdetailVC : TrainingdetailVC!
    var trainingvm : TrainingDetailVM!
    var pdcaeventData = [Pdca_VideosModel]()
    override func awakeFromNib() {
        super.awakeFromNib()
        tblHeightConstraint.constant = CGFloat(299 * arrpdcaVideoLink.count)
        // Initialization code
    }
    func setpdcavideoinfoData(dataEvent:PdcaedetailModel) {
        if dataEvent.sessions!.count > 0{

            if arrpdcaVideoLink.count>0{
                arrpdcaVideoLink.removeAll()
            }
            arrpdcaVideoLink = dataEvent.sessions!
            print("arrpdcaVideoLink ... \(arrpdcaVideoLink)")
            for objdata in arrpdcaVideoLink {
                print("sasasda \(objdata.videos)")
                separtepdcaVideoLink = objdata.videos!
            }
            print("separtepdcaVideoLink,., \(separtepdcaVideoLink)")
            
            for objdata in arrpdcaVideoLink {
                print("up up \(objdata.uploads!.count)")
                        if uploadscount == 0  {
                            print("beff separtepdcaupload.count \(separtepdcaupload.count)")
                            self.uploadscount = objdata.uploads!.count
                            print("aff\(self.uploadscount)")
                        }else{
                            print("bef \(separtepdcaupload.count)")
                            print("before\(self.uploadscount)")
                
                            self.uploadscount = self.uploadscount + objdata.uploads!.count
                            print("after \(self.uploadscount)")
                        }
                separtepdcaupload = objdata.uploads!
            }
            
            print("beff separtepdcaupload.count \(self.uploadscount)")

        }
        
        tblHeightConstraint.constant = CGFloat(299 * dataEvent.sessions!.count + 43 * self.uploadscount )
        videotblDocument.register(youtubevideocell.nib(), forCellReuseIdentifier: "youtubevideocell")
        videotblDocument.delegate = self
        videotblDocument.dataSource = self
        videotblDocument.reloadData()
            trainingdetailVC.trainingdetailtblview.beginUpdates()
            trainingdetailVC.trainingdetailtblview.endUpdates()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension PdcaTableCell : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(arrpdcaVideoLink.count)")
            return arrpdcaVideoLink.count
    
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = videotblDocument.dequeueReusableCell(withIdentifier: "youtubevideocell", for: indexPath) as! youtubevideocell
        cell.trainingdetailVC = (actualController as? TrainingdetailVC).self
           // cell.imgyoutube.image = arrVideoLink[indexPath.row].file
        cell.delegates = self
        let urlYoutube = arrpdcaVideoLink[indexPath.row]
        print("ccc \(urlYoutube.uploadDisabled)..... \(urlYoutube.isCompleted)")
      
        if urlYoutube.isCompleted == 0 && urlYoutube.uploadDisabled == 0 {
            cell.uploadbtn.alpha = 0.5
            cell.uploadbtn.isUserInteractionEnabled = false
        }
        
        
        print("urlYoutube... \(urlYoutube.videos)")
        cell.setpdcavideodatainfo(pdcavideodata: urlYoutube)
        cell.namelbl.text! = urlYoutube.sessionName!
        
        cell.downloadbtn.addTarget(self, action: #selector(self.DownloadLinkDocument(sender:)), for: .touchUpInside)
        cell.uploadbtn.addTarget(self, action: #selector(self.UploadLinkDocument(sender:)), for: .touchUpInside)
//
//            let urlID = urlYoutube?.youtubeID
//            let urlStr = "http://img.youtube.com/vi/\(urlID ?? "")/1.jpg"
//            let url = URL(string: urlStr)!
//            cell.videoImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
//            cell.videoImg.sd_setImage(with: url, completed: nil)
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let uploadheight = arrpdcaVideoLink[indexPath.row]
        return CGFloat(299 + 43 * uploadheight.uploads!.count)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select video")
        let cell = videotblDocument.dequeueReusableCell(withIdentifier: "youtubevideocell", for: indexPath) as! youtubevideocell
        
        
        
        
            let obj = arrpdcaVideoLink[indexPath.row]
       
        let obj2 = obj.videos
       
        pdcaeventData = obj2!
        
        print("\(indexPath.row)")
        
        
        for (index, element) in pdcaeventData.enumerated() {
          print("Item \(index): \(element)")
            if index == 0 {
                print("\(element.videoLink)")
                self.youtubeurlpass = element.videoLink!
                self.pdca = element.pdca!
                self.id = element.id!
                
            }
        }
       // let indivdula = pdcaeventData[indexPath.row].videoLink
        print("youtubeurlpass\(self.youtubeurlpass)")
        callTrainingPDCAvideoviewed(pdcaid: String(self.pdca), videoid: String(self.id))

            if  self.youtubeurlpass != ""{
                let objLink =  self.youtubeurlpass

                guard let url = URL(string: objLink) else { return }
                UIApplication.shared.open(url)
            }
        
    }
    func callTrainingPDCAvideoviewed(pdcaid:String,videoid:String) {
        
        let param = [ "pdca" : pdcaid,
                  "video" : videoid
                 // "sortkey" : sortkey,
                  //"sortorder" : sortorder
        ]
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForPDCAvideoviewed(params: param) { [self] (result) in
            
            if let respCode = result.resp_code{
                
                if respCode == 200{
                    
                    if let objDate = result.data {
                        
//                        pdcainfodata = objDate
//
//
//                        userDef.setValue(eventData?.id, forKey: UserDefaultKey.trainingpdcauploadid)
//
//
//                        print("eventData ... all...\(eventData)")
//                        GlobalObj.displayLoader(true, show: false)
//                        (actualController as! TrainingdetailVC).trainingdetailtblview.isHidden = false
//                        (actualController as! TrainingdetailVC).trainingdetailtblview.reloadData()
                    }else{
                       // (actualController as! TrainingdetailVC).trainingdetailtblview.isHidden = false
                        
                        GlobalObj.displayLoader(true, show: false)
                    }
                    
                }
                
                GlobalObj.displayLoader(true, show: false)
                
            }
        }
    }
    
    @objc func DownloadLinkDocument(sender: UIButton){
        GlobalObj.displayLoader(true, show: true)
        let objUrl = arrpdcaVideoLink[sender.tag]
        
        let objsessionfile = objUrl.sessionFile
        
        print("objsessionfile\(objsessionfile!)")
        if let url = URL(string: BaseURL + objsessionfile!){
            GlobalObj.run(after: 1) {
                guard let url = URL(string: BaseURL + objsessionfile!)else{return}



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
                    let pdfNameFromUrl = "YourAppName-\(fileName).xlsx"
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
    @objc func UploadLinkDocument(sender: UIButton){
        
        print("acces upload file btn")
      //  GlobalObj.displayLoader(true, show: true)
        let objUrl = arrpdcaVideoLink[sender.tag]
        
        let objsessionfile = objUrl.videos
        pdcaeventData = objsessionfile!
        
        for (index, element) in pdcaeventData.enumerated() {
          print("Item \(index): \(element)")
            if index == 0 {
                print("\(element.videoLink)")
               
                self.pdca = element.pdca!
                self.sessionid = element.session!
                
            }
        }
        
        let importMenu = UIDocumentPickerViewController(documentTypes: ["com.microsoft.word.doc","org.openxmlformats.wordprocessingml.document", kUTTypePDF as String], in: UIDocumentPickerMode.import)
            importMenu.delegate = self
            importMenu.modalPresentationStyle = .formSheet


        self.trainingdetailVC!.present(importMenu, animated: true, completion: nil)
    }
}
//MARK:- Document picker
extension PdcaTableCell : UIDocumentMenuDelegate,UIDocumentPickerDelegate{
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
                self.calltrainingpdcauploadWebserviceapi(pdca: String(self.pdca), session:String( self.sessionid), image:  self.imageA2)
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
    func calltrainingpdcauploadWebserviceapi(pdca:String,session:String,image:UIImage) {
        GlobalObj.displayLoader(true, show: true)
        let param = ["pdca":pdca,
                     "session":session]
        let accessToken = userDef.string(forKey: UserDefaultKey.token)
        let header :[String: String] = ["Authorization": "Bearer \(accessToken ?? "")",
                                        "Content-Type": "application/json",
                                        "Accept": "application/json"]
        APIClient.webServicesToTrainingpdcaupload(params: param, header: header,file: self.arrDoc) { (response) in
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
    
extension PdcaTableCell:pdfVCDelegate{
    func pdfValue(pdfStr:String){
        print("\(pdfStr)")
        let vc = FlowController().instantiateViewController(identifier: "PDFReaderVC", storyBoard: "Category") as! PDFReaderVC
        vc.isFromDetailPage = true
        if pdfStr != ""{
            vc.detailPageurl = BaseURL + pdfStr
        }
        trainingdetailVC?.navigationController?.pushViewController(vc, animated: true)
    }
}
