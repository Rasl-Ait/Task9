//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: rasul
// On: 7/31/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

enum ImageType {
  case gallery
  case items
}

class CustomImageViewGradient: UIImageView {
  
  private let gradient = CAGradientLayer()
  private var imageType = ImageType.items
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupGradient(imageType)
  }
  
  init(_ type: ImageType) {
    super.init(frame: .zero)
    imageType = type
    setupGradient(type)
  }
 
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupGradient(_ type: ImageType) {
    gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
    layer.cornerRadius = 18
    
    if type != .gallery {
      gradient.locations = [0.7, 1.1]
    } else {
      gradient.locations = [0.5, 1.1]
    }
    
    clipsToBounds = true
    layer.addSublayer(gradient)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    gradient.frame = layer.bounds
  }
}
