//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: rasul
// On: 8/15/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class ItemsDetailViewController: BaseViewController {
  
  private lazy var dissmissButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "close"), for: .normal)
    button.imageView?.tintColor = .white
    button.disableAutoresizingMask()
    button.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
    button.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
    button.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
    return button
  }()
  
  private lazy var scrollView: UIScrollView = {
      let view = UIScrollView()
      view.disableAutoresizingMask()
      return view
  }()
  
  private lazy var imageView: CustomImageViewGradient = {
    let view = CustomImageViewGradient(.gallery)
      view.disableAutoresizingMask()
      view.contentMode = .scaleAspectFill
      view.image = UIImage(named: "story-1")
      view.layer.cornerRadius = 8.0
      view.layer.borderColor = UIColor.white.cgColor
      view.layer.borderWidth = 1.0
      view.layer.masksToBounds = true
      return view
  }()
  
  private lazy var typeLabel: CustomTypeLabel = {
    let view = CustomTypeLabel()
    view.setLabel(title: "Gallery",
                  alignment: .center,
                  color: .white,
                  fontName: .rockwell(24))
    view.layer.cornerRadius = 8
    view.backgroundColor = .black
    view.clipsToBounds = true
    view.borderColorView(borderWidht: 1, borderColor: .white)
    return view
  }()
  
  private let lineView: UIView = {
      let view = UIView()
      view.disableAutoresizingMask()
      view.backgroundColor = .white
      return view
  }()
  
  private lazy var containerView: UIView = {
      let view = UIView()
      view.disableAutoresizingMask()
      return view
  }()
  
  let contentView: UIView = {
      let view = UIView()
      view.disableAutoresizingMask()
      return view
  }()

  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    configureConstraint()
  }
  
  func setup(image: UIImage, title: String, type: String) {
      imageView.image = image
      typeLabel.text = type
      view.layoutIfNeeded()
  }
}

// MARK: - private ItemsDetailViewController
private extension ItemsDetailViewController {
  func setupView() {
    view.backgroundColor = .black
    [dissmissButton, imageView,
     typeLabel, lineView,
     contentView].forEach { view.addSubview($0) }
    
    containerView.addSubview(dissmissButton)
    containerView.addSubview(imageView)
    containerView.addSubview(typeLabel)
    containerView.addSubview(lineView)
    containerView.addSubview(contentView)
    scrollView.addSubview(containerView)
    view.addSubview(scrollView)
    configureConstraint()
  }
  
  func configureConstraint() {
    scrollView.bind(to: view)
    containerView.bind(to: scrollView)
    
    NSLayoutConstraint.activate([
      containerView.widthAnchor.constraint(equalTo: view.widthAnchor),
      dissmissButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30.0),
      dissmissButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25.0),
      
      imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30.0),
      imageView.topAnchor.constraint(equalTo: dissmissButton.bottomAnchor, constant: 30.0),
      imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30.0),
      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.337),
      
      typeLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      typeLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20),
      typeLabel.heightAnchor.constraint(equalToConstant: 45),
      typeLabel.widthAnchor.constraint(equalToConstant: typeLabel.bounds.width + 60),
      
      lineView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.517),
      lineView.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 40.0),
      lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      lineView.heightAnchor.constraint(equalToConstant: 1.0),
      
      contentView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
      contentView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 40.0),
      contentView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20.0)
    ])
  }
  
  // MARK: Action
  @objc func dismissAction() {
    dismiss(animated: true)
  }
}

