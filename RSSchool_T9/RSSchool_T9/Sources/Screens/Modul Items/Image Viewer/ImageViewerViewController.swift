//
// 📰 🐸
// Project: RSSchool_T9
//
// Author: rasul
// On: 7/31/21
//
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

final class ImageViewerViewController: BaseViewController {
  
  private let scrollView = UIScrollView()
  private let closeButton = UIButton()
  private let imageView = UIImageView()
  
  var image: UIImage?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    scrollView.zoomScale = 1.0
  }
}

// MARK: ImageViewerViewController
private extension ImageViewerViewController {
  func setupViews() {
    setupScrollView()
    setupButton()
    setupImageView()
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(handler))
    tap.numberOfTouchesRequired = 1
    view.addGestureRecognizer(tap)
    
    view.backgroundColor = .black
  }
  
  func setupButton() {
    closeButton.disableAutoresizingMask()
    closeButton.setBackgroundImage(UIImage(named: "close"), for: .normal)
    closeButton.tintColor = .white
    closeButton.addTarget(self, action: #selector(dissmissButtonTapped), for: .touchUpInside)
    view.addSubview(closeButton)
    
    NSLayoutConstraint.activate([
      closeButton.topAnchor .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
      closeButton.heightAnchor.constraint(equalToConstant: 40),
      closeButton.widthAnchor.constraint(equalToConstant: 40),
    ])
  }
  
  func setupScrollView() {
    scrollView.bounces = false
    scrollView.disableAutoresizingMask()
    scrollView.minimumZoomScale = 1.0
    scrollView.maximumZoomScale = 3.0
    scrollView.showsVerticalScrollIndicator = false
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.decelerationRate = .fast
    scrollView.delegate = self
    view.addSubview(scrollView)
    NSLayoutConstraint.activate([
      scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
    ])
  }
  
  func setupImageView() {
    imageView.disableAutoresizingMask()
    imageView.image = image
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    scrollView.addSubview(imageView)
    
    NSLayoutConstraint.activate([
      imageView.topAnchor .constraint(equalTo: scrollView.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
    ])
  }
  
  // MARK: Action
  @objc func dissmissButtonTapped() {
    dismiss(animated: true, completion: nil)
  }
  
  @objc func handler(_ sender: UITapGestureRecognizer) {
    closeButton.isHidden.toggle()
  }
}

// MARK: - UIScrollViewDelegate
extension ImageViewerViewController: UIScrollViewDelegate {
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return imageView
  }
  
  func scrollViewDidZoom(_ scrollView: UIScrollView) {
  }
}
