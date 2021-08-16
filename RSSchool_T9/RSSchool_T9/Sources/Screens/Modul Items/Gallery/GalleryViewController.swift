//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: rasul
// On: 7/31/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class GalleryViewController: ItemsDetailViewController {
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return cv
  }()
  
  var gallery: Gallery
  
  private var collectionViewHeightConstraint: NSLayoutConstraint!
  
  init(gallery: Gallery) {
    self.gallery = gallery
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private let transition = PresentViewController()
  private var selectedImage: UIImageView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    view.backgroundColor = .black
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    collectionView.collectionViewLayout.invalidateLayout()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
      collectionViewHeightConstraint.constant = CGFloat(gallery.images.count) + (collectionView.frame.width * 1.1)
      
    } else {
      collectionViewHeightConstraint.constant = CGFloat(gallery.images.count) * (collectionView.frame.width + 100) * 1.06
    }
  }
}

//MARK: - private GalleryDetailViewController
private extension GalleryViewController {
  func setupView() {
    setupCollectionView()
    
    setup(image: gallery.coverImage, title: gallery.title, type: gallery.type)
  }
  
  func setupCollectionView() {
    collectionView.disableAutoresizingMask()
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .black
    collectionView.isScrollEnabled = false
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.register(ItemsCollectionCell.self)
    contentView.addSubview(collectionView)
    
    collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 0)
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor .constraint(equalTo: contentView.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      collectionViewHeightConstraint
    ])
  }
}

// MARK: UICollectionViewDataSource
extension GalleryViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return gallery.images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: ItemsCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
    let model = gallery.images[indexPath.item]
    cell.configure(model)
    return cell
  }
}

// MARK: UICollectionViewDelegate
extension GalleryViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: false)
    guard let cell = collectionView.cellForItem(at: indexPath) as? ItemsCollectionCell else {return}
    selectedImage = cell.imageView
    let image = gallery.images[indexPath.item]
    let vc = ImageViewerViewController()
    vc.image = image
    //vc.indexPath = indexPath
    vc.transitioningDelegate = self
    transition.presentType = .gallery
    vc.modalPresentationStyle = .overFullScreen
    present(vc, animated: true, completion: nil)
  }
}

// MARK: UICollectionViewDelegateFlowLayout
extension GalleryViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.frame.width
    if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
      let width = (collectionView.frame.width) / 3
      return CGSize(width: width - 20, height: width + 40)
    }
    return CGSize(width: width, height: width + 100)
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 25
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .zero
  }
}

// MARK: - UIViewControllerTransitioningDelegate
extension GalleryViewController: UIViewControllerTransitioningDelegate {
  func animationController(forPresented presented: UIViewController,
                           presenting: UIViewController,
                           source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    transition.originFrame = selectedImage!.superview!.convert(selectedImage!.frame, to: nil)
    transition.presenting = true
    return transition
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    transition.presenting = false
    return transition
  }
}
