
import UIKit

extension UILabel {
	func setLabel(title: String = "", alignment: NSTextAlignment, color: UIColor, fontName: UIFont?) {
    translatesAutoresizingMaskIntoConstraints = false
		text = title
		font = fontName
		textAlignment = alignment
		textColor = color
		//minimumScaleFactor = 0.8
		sizeToFit()
		//adjustsFontSizeToFitWidth = true
		lineBreakMode = .byTruncatingTail
	}
}
