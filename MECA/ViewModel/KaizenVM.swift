//
//  KaizenVM.swift
//  MECA
//
//  Created by Mohammed Sulaiman on 28/03/21.
//


import Foundation
import UIKit
import SDWebImage

class KaizenVM: NSObject {
    var actualController:UIViewController?
    var arrKaizenInfo:[KaizenInfoDataModel] = []
   
    init(controller:UIViewController?) {
        self.actualController = controller
    }
   
    func callKaizenInfoWebservice() {
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForKaizenInfo { (result) in
            
            if let respCode = result.resp_code{
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)

                    if let objDate = result.data {
                        let imgURL = BaseURL + objDate.cover_image!
                        
                        (self.actualController as! DetailViewController).mainImageView.sd_setImage(with: URL(string:imgURL), completed: nil)
                        (self.actualController as! DetailViewController).toyota2021TitleLabel.text = objDate.title
                        (self.actualController as! DetailViewController).startDateLabel.text = objDate.start_date
                        (self.actualController as! DetailViewController).endDateLabel.text = objDate.end_date

                        
                    }
                }

            }
        }
    }
    
}


