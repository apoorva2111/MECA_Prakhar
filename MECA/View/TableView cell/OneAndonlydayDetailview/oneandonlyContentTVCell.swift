//
//  oneandonlyContentTVCell.swift
//  MECA
//
//  Created by Macbook  on 05/07/21.
//

import UIKit

class oneandonlyContentTVCell: UITableViewCell {
    @IBOutlet weak var btnReadMoreOutlet: UIButton!
    @IBOutlet weak var lblContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setNewsContentData(grData:NewsDetail_Data){
        lblContent.text = grData.plain_description?.html2String
        
    }
    
    func setoneandonlyData(dataoneandonly:KaizenInfoDataModel){
        print("description...sdcs  \(dataoneandonly)")
        lblContent.text = dataoneandonly.description?.html2String

        
    }
}
