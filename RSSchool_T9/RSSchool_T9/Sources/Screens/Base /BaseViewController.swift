//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: rasul
// On: 7/29/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class BaseViewController: UIViewController {
  
  lazy var activityIndicatorView: UIActivityIndicatorView = {
    let activityIndicatorView = UIActivityIndicatorView()
    activityIndicatorView.color = UIColor.red
    activityIndicatorView.sizeToFit()
    return activityIndicatorView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func hideNavigationBar(isHidden: Bool, barStyle: UIBarStyle) {
    navigationController?.navigationBar.isHidden = isHidden
    navigationController?.navigationBar.barStyle = barStyle
  }
  
  func showLoadingView(_ tableView: UITableView) {
    tableView.sectionFooterHeight = 60
    tableView.tableFooterView = activityIndicatorView
    activityIndicatorView.startAnimating()
  }
  
  func hideLoadingView(_ tableView: UITableView) {
    if activityIndicatorView.isDescendant(of: tableView) {
      activityIndicatorView.stopAnimating()
      activityIndicatorView.removeFromSuperview()
      tableView.tableFooterView = nil
    }
  }
}
