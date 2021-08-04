//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: rasul
// On: 7/31/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class TabBarController: UITabBarController {

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tabBar.tintColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
    let vc = ItemsViewController()
    let vc1Item = UITabBarItem(title: "Items", image: UIImage(systemName: "square.grid.2x2"), tag: 0)
    vc.tabBarItem = vc1Item
    
    let vc2 = RSSettingsViewController()
    let vc2Item = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)
    vc2.title = "Settings"
    vc2.colorText = vc.colorText
    vc2.tabBarItem = vc2Item
    
    viewControllers = [vc, vc2].map { UINavigationController(rootViewController: $0) }
  }
}
