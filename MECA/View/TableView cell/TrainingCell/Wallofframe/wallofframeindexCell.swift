//
//  wallofframeindexCell.swift
//  MECA
//
//  Created by Macbook  on 03/06/21.
//

import UIKit

class wallofframeindexCell: UITableViewCell {
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    @IBOutlet weak var titlelbl:UILabel!
    @IBOutlet weak var companylbl:UILabel!
    @IBOutlet weak var professionlbl:UILabel!
    @IBOutlet weak var nameboardimg:UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.isOpaque = false 
        // Initialization code 1- gold, 2 - silver, 3 - bronze, 4 -white
    }
    func setCellwallfamedetails(feed:walloffame_datas) {
        titlelbl.text! = feed.displayName!
        companylbl.text! = feed.companyName!
        professionlbl.text! = feed.profession!
        if  feed.frame == 1 {
            nameboardimg.image = UIImage.init(named: "members_plate_gold")
        }else if feed.frame == 2{
            nameboardimg.image = UIImage.init(named: "members_plate_silver")
        }else if feed.frame == 3{
            nameboardimg.image = UIImage.init(named: "members_plate_bronze")
        }else if feed.frame == 4{
            nameboardimg.image = UIImage.init(named: "members_plate_white")
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
