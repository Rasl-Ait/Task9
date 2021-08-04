
import UIKit

extension UIViewController {

	func showAlert(title: String, message: String, dismissAction: ((UIAlertAction) -> Void)? = nil) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .cancel, handler: dismissAction)
		alert.view.tintColor = .blue
		alert.addAction(action)

		DispatchQueue.main.async {
			self.present(alert, animated: true, completion: nil)
		}
	}
	
	func showAlertAction(
		title: String,
		message: String = "",
		primaryTitle: String = "Да",
		secondTitle: String = "Нет",
		preferredStyle: UIAlertController.Style = .alert,
		primaryAction: ((UIAlertAction) -> Void)? = nil,
		secondAction: ((UIAlertAction) -> Void)? = nil) {
		
		let alert = UIAlertController(
			title: title,
			message: message,
			preferredStyle: preferredStyle)
		let action = UIAlertAction(title: primaryTitle, style: .default, handler: primaryAction)
		
		if primaryTitle == "Перейти" {
			action.setValue(UIColor.green, forKey: "titleTextColor")
		}
		
		let actionCancel = UIAlertAction(title: secondTitle, style: .default, handler: secondAction)
		alert.view.tintColor = .blue
	//	action.setValue(UIColor.red, forKey: "titleTextColor")
		alert.addAction(actionCancel)
		alert.addAction(action)
		DispatchQueue.main.async {
			self.present(alert, animated: true, completion: nil)
		}
	}
	
//	func add(childVC: UIViewController, to containerView: UIView) -> UIViewController {
//		addChild(childVC)
//		containerView.addSubview(childVC.view)
//		childVC.didMove(toParent: self)
//		childVC.view.snp.makeConstraints {
//			$0.edges.equalToSuperview()
//		}
//		return childVC
//	}
	
//	func add(childVC: UIViewController, containerView: UIView) {
//		addChild(childVC)
//		containerView.addSubview(childVC.view)
//		childVC.didMove(toParent: self)
//		childVC.view.snp.makeConstraints {
//			$0.edges.equalToSuperview()
//		}
//	}
	
	
}
