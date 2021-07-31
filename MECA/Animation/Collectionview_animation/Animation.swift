//
//  Animation.swift

//  MECA
//
//  Created by Macbook  on 15/05/21.
//

import UIKit

/// Animation protocol defines the initial transform for a view for it to
/// animate to its identity position.
public protocol Animationcollection {

    /// Defines the starting point for the animations. 
    var initialTransform: CGAffineTransform { get }
}
