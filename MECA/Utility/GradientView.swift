//
//  GradientView.swift
//  MECA
//
//  Created by Macbook  on 23/07/21.
//

import UIKit

class GradientView: UIView {
    override open class var layerClass: AnyClass {
            return CAGradientLayer.classForCoder()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            let gradientLayer = self.layer as! CAGradientLayer
            gradientLayer.colors = [
                UIColor.clear.cgColor,
                UIColor.black.cgColor
            ]
            
            backgroundColor = UIColor.clear
        }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
