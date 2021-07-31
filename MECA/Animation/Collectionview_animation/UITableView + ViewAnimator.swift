//
//  UITableView + ViewAnimator.swift
//  MECA
//
//  Created by Macbook  on 15/05/21.
//

import Foundation
import UIKit

public extension UITableView {

    /// Gets the currently visibleCells of a section.
    ///
    /// - Parameter section: The section to filter the cells.
    /// - Returns: Array of visible UITableViewCell in the argument section.
    func visibleCells(in section: Int) -> [UITableViewCell] {
        return visibleCells.filter { indexPath(for: $0)?.section == section }
    }
}
