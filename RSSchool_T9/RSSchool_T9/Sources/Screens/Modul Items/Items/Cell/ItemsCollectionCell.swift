//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: rasul
// On: 7/30/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import Foundation

import UIKit

class ItemsCollectionCell: UICollectionViewCell {
  
  let imageView = CustomImageViewGradient(frame: .zero)
  private let titleLabel = UILabel()
  private let textLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  
  func configure(_ model: ContentType) {
    switch model {
    case .gallery(let gallery):
      imageView.image = gallery.coverImage
      titleLabel.text = gallery.title
      textLabel.text = gallery.type
    case .story(let story):
      imageView.image = story.coverImage
      titleLabel.text = story.title
      textLabel.text = story.type
    }
    
    contentView.layer.cornerRadius = 18
    contentView.borderColorView(borderWidht: 1, borderColor: .black)
  }
  
  func configure(_ image: UIImage?) {
    imageView.image = image
    contentView.borderColorView(borderWidht: 1, borderColor: .white)
    contentView.layer.cornerRadius = 8
    imageView.layer.cornerRadius = 4
  }
}

private extension ItemsCollectionCell {
  func setupViews() {
    setupImageView()
    setupLabel()
  }
  
  func setupLabel() {
    titleLabel.setLabel(title: "", alignment: .left, color: .white, fontName: .rockwell(16))
    textLabel.setLabel(title: "", alignment: .left, color: UIColor.white.withAlphaComponent(0.6), fontName: .rockwell(12))
    
    titleLabel.adjustsFontSizeToFitWidth = true
    
    let stack = CustomStackView(axis: .vertical, spacing: 3)
    stack.addArrangedSubview(titleLabel)
    stack.addArrangedSubview(textLabel)
    contentView.addSubview(stack)
    NSLayoutConstraint.activate([
      stack.leadingAnchor .constraint(equalTo: contentView.leadingAnchor, constant: 18),
      stack.trailingAnchor .constraint(equalTo: contentView.trailingAnchor, constant: -18),
      stack.bottomAnchor .constraint(equalTo: contentView.bottomAnchor, constant: -18)
    ])
    
    
  }
  
  func setupImageView() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "code-0")
    imageView.centerCrop()
    imageView.backgroundColor = .black
    imageView.layer.cornerRadius = 10
    contentView.addSubview(imageView)
    NSLayoutConstraint.activate([
      imageView.topAnchor .constraint(equalTo: contentView.topAnchor, constant: 8),
      imageView.leadingAnchor .constraint(equalTo: contentView.leadingAnchor, constant: 8),
      imageView.trailingAnchor .constraint(equalTo: contentView.trailingAnchor, constant: -8),
      imageView.bottomAnchor .constraint(equalTo: contentView.bottomAnchor, constant: -8)
    ])
  }
}
