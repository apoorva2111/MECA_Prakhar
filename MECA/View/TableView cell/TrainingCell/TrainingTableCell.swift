//
//  TrainingTableCell.swift
//  MECA
//
//  Created by Macbook  on 28/05/21.
//

import UIKit

class TrainingTableCell: UITableViewCell {
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    @IBOutlet weak var titlelbl:UILabel!
    @IBOutlet weak var backView: RCustomView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    func setCelltrianinglist(feed:Trainingdatalist) {
            print(feed)
        titlelbl.text = feed.title!
            
     
            
        }
    func setCelltrianingpdcalist(feed:PDCAindexlist) {
            print(feed)
        titlelbl.text = feed.title!
            
     
            
        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
