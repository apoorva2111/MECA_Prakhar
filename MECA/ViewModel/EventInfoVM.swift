//
//  EventInfoVM.swift
//  MECA
//
//  Created by Mohammed Sulaiman on 28/03/21.
//

import Foundation
import UIKit
import SDWebImage

class EventInfoVM: NSObject {
    var actualController:UIViewController?

    
    
    init(controller:UIViewController?) {
        self.actualController = controller
    }
   
    func callEventInfoWebservice() {
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForEventInfo { [self] (result) in

            if let respCode = result.resp_code{

                if respCode == 200{

                    if let objDate = result.data {
                        if objDate.cover_image != ""{
                            let imgURl = BaseURL + objDate.cover_image!
                            (actualController as! DetailViewController).mainImageView.sd_setImage(with: URL.init(string: imgURl), completed: nil)
                        }
                        (actualController as! DetailViewController).toyota2021TitleLabel.text = objDate.title
                        (actualController as! DetailViewController).eventStartDateLabel.text = objDate.start_date
                        (actualController as! DetailViewController).eventStartTimeLabel.text = objDate.start_time
                        (actualController as! DetailViewController).eventEndDateLabel.text = objDate.end_date
                        (actualController as! DetailViewController).eventEndTimeLabel.text = objDate.end_time
                               //  vc.videoLinklabel.text = EventVideoLinksModel.
                        (actualController as! DetailViewController).likeLabel.text = String((objDate.likes)!)
                        
                        (actualController as! DetailViewController).surveyLinkRefBtn.setTitle(objDate.survey_link, for: .normal)
                                                
                        (actualController as! DetailViewController).aboutEventLabel.text = "About Event"
                        //   (actualController as! DetailViewController).eventSubTitleLabel.text = objDate.description

                        
                    }else{
                        GlobalObj.displayLoader(true, show: false)
                    }
                }else{
                    GlobalObj.displayLoader(true, show: false)
                }
            }

            GlobalObj.displayLoader(true, show: false)

        }
    }
//    func setupApi(){
//        let vc = DetailViewController()
//        if eventInfoData.cover_image != "" {
//            let imgUrl = BaseURL + (eventInfoData.cover_image)!
//            vc.mainImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
//           vc.mainImageView.sd_setImage(with: URL(string: imgUrl), completed: nil)
//        }
//
//           
//          
//        }
    
    
}


