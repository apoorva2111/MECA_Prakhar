//
//  Animator.swift
//  UITableViewCellAnimation-Article
//  MECA
//
//  Created by Macbook  on 13/05/21.
//

import UIKit

final class Animator {
	private var hasAnimatedAllCells = false
	private let animation: TableCellAnimation

	init(animation: @escaping TableCellAnimation) {
		self.animation = animation
	}

	func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
		guard !hasAnimatedAllCells else {
			return
		}

		animation(cell, indexPath, tableView)

		hasAnimatedAllCells = tableView.isLastVisibleCell(at: indexPath)
	}
}
