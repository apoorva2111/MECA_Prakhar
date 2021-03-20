//
//  FooterTabView.swift
//  MECA
//
//  Created by Apoorva Gangrade on 18/03/21.
//

import UIKit

protocol FooterTabViewDelegate{

    func footerBarAction(strType : String)
}

class FooterTabView: UIView {

    let nibName = "FooterTabView"
    var contentView: UIView?
    var footerTabViewDelegate : FooterTabViewDelegate!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        view.frame = self.bounds

    }
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    @IBAction func btnTabAction(_ sender: UIButton) {
        if sender.tag == 10{
            footerTabViewDelegate.footerBarAction(strType: "Home")
        }else if sender.tag == 20 {
            footerTabViewDelegate.footerBarAction(strType: "Calendar")
        }else if sender.tag == 30 {
            footerTabViewDelegate.footerBarAction(strType: "Categories")
        }else if sender.tag == 40 {
            footerTabViewDelegate.footerBarAction(strType: "Notification")
        }else if sender.tag == 50 {
            footerTabViewDelegate.footerBarAction(strType: "More")
        }
    }
}
