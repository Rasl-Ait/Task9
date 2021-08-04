
import UIKit

extension UIButton {
	func setButton(title: String, titleColor: UIColor, font: UIFont?) {
		setTitle(title, for: .normal)
		//layer.cornerRadius = 10
		setTitleColor(titleColor, for: .normal)
		titleLabel?.font = font
	}
}
