
import UIKit.UIView

extension UIView {
	
	var width: CGFloat {
			return frame.size.width
	}

	var height: CGFloat {
			return frame.size.height
	}

	var left: CGFloat {
			return frame.origin.x
	}

	var right: CGFloat {
			return left + width
	}

	var top: CGFloat {
			return frame.origin.y
	}

	var bottom: CGFloat {
			return top + height
	}
	
	func circle() {
		let raduis = self.bounds.width / 2
		self.layer.cornerRadius = raduis
		self.clipsToBounds = true
	}
	
	func centerCrop() {
		contentMode = .scaleAspectFill
		clipsToBounds = true
	}
		
	func shadowView(cornerRadius: CGFloat, shadowRadius: CGFloat, shadowOpacity: Float, height: Int) {
		layer.cornerRadius = cornerRadius
		layer.shadowRadius = shadowRadius
		layer.shadowOpacity = shadowOpacity
		layer.shadowOffset = CGSize(width: 0, height: height)
		layer.shadowColor = UIColor.black.cgColor
	}
	
	func borderColorView(borderWidht: CGFloat, borderColor: UIColor) {
		layer.borderColor = borderColor.cgColor
		layer.borderWidth = borderWidht
	}
	
	func radius() {
		layer.cornerRadius = layer.bounds.height / 2
		//layer.masksToBounds = false
	}
	
	func disableAutoresizingMask() {
		self.translatesAutoresizingMaskIntoConstraints = false
	}
}
