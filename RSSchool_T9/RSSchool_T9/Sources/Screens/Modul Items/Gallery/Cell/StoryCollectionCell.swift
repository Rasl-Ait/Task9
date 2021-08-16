//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: rasul
// On: 8/1/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class StoryCollectionCell: BaseUICollectionViewCell {
  private let textLabel = UILabel()
  
  override func addSubViews() {
    setupViews()
  }
  
  func configure(_ model: Story?) {
    guard let model = model else { return }
    textLabel.text = model.text
  }
}

private extension StoryCollectionCell {
  func setupViews() {
    setupLabel()
    contentView.layer.cornerRadius = 8
    contentView.backgroundColor = .black
    contentView.clipsToBounds = true
    contentView.borderColorView(borderWidht: 1, borderColor: .white)
  }
  
  func setupLabel() {
    textLabel.disableAutoresizingMask()
    textLabel.setLabel(title: "Story", alignment: .left, color: .white, fontName: .rockwell(24))
    textLabel.numberOfLines = 0
    textLabel.sizeToFit()

    contentView.addSubview(textLabel)
    NSLayoutConstraint.activate([
      textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:20),
      textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      textLabel.bottomAnchor.constraint(equalTo:  contentView.bottomAnchor, constant: -20)
    ])
  }
}

