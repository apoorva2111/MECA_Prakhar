//
//  UITableView+Ext.swift
//  UITableViewCellAnimation-Article
//  MECA
//
//  Created by Macbook  on 15/05/21.
//

import UIKit

extension UITableView {
	func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
		guard let lastIndexPath = indexPathsForVisibleRows?.last else {
			return false
		}

		return lastIndexPath == indexPath
	}
}
