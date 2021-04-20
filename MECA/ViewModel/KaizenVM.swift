


import Foundation
import UIKit
import SDWebImage
import AVFoundation

class KaizenVM: BaseTableViewVM {
    var arrKaizenInfo:[KaizenInfoDataModel] = []
    var strdescription = ""
    var arrEventImg = [Event_videos]()
    var arrEventVideos = [Event_videos]()
var arrVideoLink = [KaizenVideoLinkModel]()
    var arrDocumentLink = [Document_links]()

    let identifierItemCell = "VideoLinkTableViewCell"

        override init(controller: UIViewController?) {
            super.init(controller: controller)
            
        (actualController as! DetailViewController).viewVideoCollection.isHidden = true
        (actualController as! DetailViewController).viewViideoHeightConstraint.constant = 0
        (actualController as! DetailViewController).viewVideoTopCOnstrint.constant = 0
            (actualController as! DetailViewController).viewVideoLinkHeightConstraint.constant = 0

        (actualController as! DetailViewController).viewImagCollection.isHidden = true
        (actualController as! DetailViewController).viewImgCollectHeightConstraint.constant = 0
        (actualController as! DetailViewController).viewImgTopConstrint.constant = 0
      
        (actualController as! DetailViewController).viewSurvayLinkHeightConstraint.constant = 0
        (actualController as! DetailViewController).surveyLinkRefBtn.isHidden = true
        (actualController as! DetailViewController).surveyLinkLabel.isHidden = true
        (actualController as! DetailViewController).viewLinkTopContraint.constant = 0

        (actualController as! DetailViewController).locationviewHeightConstraint.constant = 0
        (actualController as! DetailViewController).locationView.isHidden = true
        
        
        (actualController as! DetailViewController).viewEventContent.isHidden = true
        (actualController as! DetailViewController).viewEventContentHeightConstraint.constant = 0
        (actualController as! DetailViewController).viewEventTopConstraint.constant = 0
        
        (actualController as! DetailViewController).viewVideoLinkHeightConstraint.constant = 0

    }
   
    func callKaizenInfoWebservice(completion:@escaping(Bool) -> Void) {
        GlobalObj.displayLoader(true, show: true)
        print((actualController as! DetailViewController).eventID)
		APIClient.webserviceForKaizenInfo(eventId: (actualController as! DetailViewController).eventID) { (result) in
            if let respCode = result.resp_code{
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)

                    if let objDate = result.data {
                        print(objDate)
                        let imgURL = BaseURL + objDate.cover_image!
                        
                        (self.actualController as! DetailViewController).mainImageView.sd_setImage(with: URL(string:imgURL), completed: nil)
                        (self.actualController as! DetailViewController).toyota2021TitleLabel.text = objDate.title
                        self.strdescription = objDate.description ?? ""
                        (self.actualController as! DetailViewController).eventSubTitleLabel.text = objDate.description

                        (self.actualController as! DetailViewController).aboutEventLabel.text = "About Event"
                        let likes = String(objDate.likes ?? 0) + " Likes"
                        (self.actualController as! DetailViewController).likeLabel.text = likes

                        if objDate.start_date != ""{
                            
                            let startDate = NSString.convertFormatOfDate(date: objDate.start_date ?? "", originalFormat: "yyyy-mm-dd", destinationFormat: "dd MMMM yyyy")
                            (self.actualController as! DetailViewController).eventStartDateLabel.text = startDate
                            
                            
                            if let weekday = self.getDayOfWeek(startDate!) {
                                print(weekday)
                                switch weekday {
                                case 1:
                                    (self.actualController as! DetailViewController).eventStartDayLabel.text = "Sunday"
                                case 2:
                                    (self.actualController as! DetailViewController).eventStartDayLabel.text = "Monday"
                                case 3:
                                    (self.actualController as! DetailViewController).eventStartDayLabel.text = "Tuesday"
                                case 4:
                                    (self.actualController as! DetailViewController).eventStartDayLabel.text = "Wednesday"
                                    
                                case 5:
                                    (self.actualController as! DetailViewController).eventStartDayLabel.text = "Thursday"
                                case 6:
                                    (self.actualController as! DetailViewController).eventStartDayLabel.text = "Friday"
                                case 7:
                                    (self.actualController as! DetailViewController).eventStartDayLabel.text = "Saturday"
                                default:
                                    print("Error fetching days")
                                ///  return "Day"
                                }
                            } else {
                                print("bad input")
                            }
                        }
                        if objDate.end_date != ""{
                            let endDate = NSString.convertFormatOfDate(date: objDate.end_date ?? "", originalFormat: "yyyy-mm-dd", destinationFormat: "dd MMMM yyyy")
                            (self.actualController as! DetailViewController).eventEndDateLabel.text = endDate
                            
                            if let weekday = self.getDayOfWeek(endDate!) {
                                print(weekday)
                                switch weekday {
                                case 1:
                                    (self.actualController as! DetailViewController).eventEndDaylabel.text = "Sunday"
                                case 2:
                                    (self.actualController as! DetailViewController).eventEndDaylabel.text = "Monday"
                                case 3:
                                    (self.actualController as! DetailViewController).eventEndDaylabel.text = "Tuesday"
                                case 4:
                                    (self.actualController as! DetailViewController).eventEndDaylabel.text = "Wednesday"
                                    
                                case 5:
                                    (self.actualController as! DetailViewController).eventEndDaylabel.text = "Thursday"
                                case 6:
                                    (self.actualController as! DetailViewController).eventEndDaylabel.text = "Friday"
                                case 7:
                                    (self.actualController as! DetailViewController).eventEndDaylabel.text = "Saturday"
                                default:
                                    print("Error fetching days")
                                ///  return "Day"
                                }
                            } else {
                                print("bad input")
                            }
                        }
                        
                        if objDate.event_videos?.count == 0{
                            (self.actualController as! DetailViewController).viewVideoCollection.isHidden = true
                            (self.actualController as! DetailViewController).viewViideoHeightConstraint.constant = 0
                            (self.actualController as! DetailViewController).viewVideoTopCOnstrint.constant = 0

                        }else{
                            (self.actualController as! DetailViewController).viewVideoCollection.isHidden = false
                            (self.actualController as! DetailViewController).viewViideoHeightConstraint.constant = 159
                            (self.actualController as! DetailViewController).viewVideoTopCOnstrint.constant = 20
                            self.arrEventVideos = objDate.event_videos!
                            (self.actualController as! DetailViewController).videoCollectionView.delegate = (self.actualController as! DetailViewController).self
                            (self.actualController as! DetailViewController).videoCollectionView.dataSource = (self.actualController as! DetailViewController).self
                            (self.actualController as! DetailViewController).videoCollectionView.reloadData()


                        }
                        if objDate.event_images?.count == 0{
                            (self.actualController as! DetailViewController).viewImagCollection.isHidden = true
                            (self.actualController as! DetailViewController).viewImgCollectHeightConstraint.constant = 0
                            (self.actualController as! DetailViewController).viewImgTopConstrint.constant = 0
                        }else{

                            (self.actualController as! DetailViewController).viewImagCollection.isHidden = false
                            (self.actualController as! DetailViewController).viewImgCollectHeightConstraint.constant = 159
                            (self.actualController as! DetailViewController).imageCollectionView.isHidden = false
                            (self.actualController as! DetailViewController).viewImgTopConstrint.constant = 20
                            self.arrEventImg = objDate.event_images!

                            (self.actualController as! DetailViewController).imageCollectionView.delegate = (self.actualController as! DetailViewController).self
                            (self.actualController as! DetailViewController).imageCollectionView.dataSource = (self.actualController as! DetailViewController).self
                            (self.actualController as! DetailViewController).imageCollectionView.reloadData()

                        }
                        
                        if objDate.document_links?.count == 0{
                            (self.actualController as! DetailViewController).viewDocumentLink.isHidden = true
                            (self.actualController as! DetailViewController).viewDocumentLinkTOpConstrainrt.constant = 0
                            (self.actualController as! DetailViewController).viewDocumentLinkHeightConstraint.constant = 0
                        }else{
                            for i in 0..<objDate.document_links!.count {
                                let obj = objDate.document_links![i]
                                self.arrDocumentLink.append(obj)

                            }

                            DispatchQueue.main.async {
                                (self.actualController as! DetailViewController).tblDocumentLink.reloadData()
                                (self.actualController as! DetailViewController).view.layoutIfNeeded()
                                
                                (self.actualController as! DetailViewController).tblDocumentLinkHeightConstraint.constant = CGFloat(50 * self.arrDocumentLink.count)
                                (self.actualController as! DetailViewController).viewDocumentLinkHeightConstraint.constant = CGFloat(50 * self.arrDocumentLink.count)
                                                                
                                (self.actualController as! DetailViewController).view.layoutIfNeeded()
                             }
                            
                    }
                        
                        if objDate.video_links?.count == 0{
                            (self.actualController as! DetailViewController).viewVideoLink.isHidden = true
                            (self.actualController as! DetailViewController).viewVideoLinkTopConstraint.constant = 0
                            (self.actualController as! DetailViewController).tblVideoLinkHeightConstraint.constant = 0
                            (self.actualController as! DetailViewController).viewVideoLinkHeightConstraint.constant = 0
                                                        
                        }else{
                            for i in 0..<objDate.video_links!.count {
                                let objVideoLink = objDate.video_links![i]
                                print(objVideoLink)
                                self.arrVideoLink.append(objVideoLink)
                                
                            }
                            (self.actualController as! DetailViewController).tblVideoLink.reloadData()

                            DispatchQueue.main.async {
                                (self.actualController as! DetailViewController).tblVideoLink.reloadData()
                                (self.actualController as! DetailViewController).view.layoutIfNeeded()
                                
                                (self.actualController as! DetailViewController).tblVideoLinkHeightConstraint.constant = CGFloat(154 * self.arrVideoLink.count) //(self.actualController as! DetailViewController).tblVideoLink.contentSize.height
                                (self.actualController as! DetailViewController).viewVideoLinkHeightConstraint.constant = CGFloat(154 * self.arrVideoLink.count) + 30
                                                                
                                (self.actualController as! DetailViewController).view.layoutIfNeeded()
                             }
                        }

                        completion(true)
                    }
                }

            }
        }
    }
    func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)

        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }

        return nil
    }
    
   
   
    
}



