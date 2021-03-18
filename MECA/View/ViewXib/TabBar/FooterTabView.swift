//
//  FooterTabView.swift
//  MECA
//
//  Created by Apoorva Gangrade on 18/03/21.
//

import UIKit

class FooterTabView: UIView {

    let nibName = "FooterTabView"
    var contentView: UIView?
    
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

}
