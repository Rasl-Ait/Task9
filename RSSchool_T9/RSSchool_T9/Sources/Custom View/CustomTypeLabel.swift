//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: rasul
// On: 8/15/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class CustomTypeLabel: UILabel {

 let topInset = CGFloat(4.0), bottomInset = CGFloat(-4.0), leftInset = CGFloat(0.0), rightInset = CGFloat(0.0)

  override func drawText(in rect: CGRect) {

  let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    super.drawText(in: rect.inset(by: insets))
 }
}
