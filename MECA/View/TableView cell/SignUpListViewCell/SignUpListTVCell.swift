

import UIKit

class SignUpListTVCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static func nib() -> UINib {
        return UINib(nibName: "SignUpListTVCell", bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCell(dict:NotificationList_Data)  {
        lblTitle.text = dict.message
        if dict.status == 1{
           contentView.backgroundColor = .white
        }else{
            contentView.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.8941176471, blue: 0.9607843137, alpha: 1)
        }
    }
    
}
