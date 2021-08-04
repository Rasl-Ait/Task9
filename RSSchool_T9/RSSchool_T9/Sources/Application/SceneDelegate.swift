//
// 📰 🐸
// Project: RSSchool_T9
//
// Author: Uladzislau Volchyk
// On: 23.07.21
//
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            fatalError("LOL, be careful, drink some water")
        }
      
      if #available(iOS 13.0, *) {
        window = UIWindow(windowScene: windowScene)
      } else {
        window = UIWindow(frame: UIScreen.main.bounds)
      }
      
      UINavigationBar.appearance().tintColor = .red
      
      let tabBarViewController = TabBarController()
      window?.rootViewController = tabBarViewController
      window?.makeKeyAndVisible()
    }
}

