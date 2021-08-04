//
//  BaseUICollectionViewCell.swift
//  Autopole
//
//  Created by rasul on 3/9/21.
//

import UIKit

class BaseUICollectionViewCell: UICollectionViewCell {
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func addSubViews() {
		fatalError("Should override " + #function + " in " + String(describing: type(of: self)))
	}
}
