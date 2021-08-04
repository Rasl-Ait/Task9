//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: rasul
// On: 7/31/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class GalleryViewController: UIViewController {
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return cv
  }()
  
  var gallery: Gallery?
  var story: Story?
  var colorText = ""
  
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
}

//MARK: - private GalleryDetailViewController
private extension GalleryViewController {
  func setupView() {
    setupCollectionView()
  }
  
  func setupCollectionView() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .black
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.register(ItemsCollectionCell.self)
    collectionView.register(GalleryHeaderView.self)
    collectionView.register(StoryCollectionCell.self)
    view.addSubview(collectionView)
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

// MARK: UICollectionViewDataSource
extension GalleryViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let headerView: GalleryHeaderView = collectionView.dequeueReusableHeaderView(for: indexPath)
    
    if gallery != nil {
      headerView.configure(gallery)
    } else {
      
      headerView.configure(story, color: colorText, isDraw: UserDefaults.standard.bool(forKey: "isDraw"))
    }
    
    headerView.didCloseTapped = { [weak self] in
      guard let self = self else { return }
      self.dismiss(animated: true, completion: nil)
    }
    
    return headerView
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
      let height: CGFloat = story != nil ? 811 : 675
      return CGSize(width: collectionView.frame.width, height: height)
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    if gallery != nil {
      return gallery?.images.count ?? 0
    }

    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if gallery != nil {
      let cell: ItemsCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
      let model = gallery?.images[indexPath.item]
      cell.configure(model)
      return cell
    } else {
      let cell: StoryCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
      cell.configure(story)
      return cell
    }
  }
}

// MARK: UICollectionViewDelegate
extension GalleryViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: false)
    guard let cell = collectionView.cellForItem(at: indexPath) as? ItemsCollectionCell else {return}
    selectedImage = cell.imageView
    if gallery != nil {
      let image = gallery?.images[indexPath.item]
    let vc = ImageViewerViewController()
      vc.image = image
      //vc.indexPath = indexPath
      vc.transitioningDelegate = self
      transition.presentType = .gallery
      vc.modalPresentationStyle = .overFullScreen
      present(vc, animated: true, completion: nil)
      
    }
  }
}

// MARK: UICollectionViewDelegateFlowLayout
extension GalleryViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    

    let width = collectionView.frame.width
    if gallery != nil {
      
      if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
        let width = (collectionView.frame.width - 280) / 3
        return CGSize(width: width, height: width + 40)
      }
      return CGSize(width: width - 20, height: 511)
    } else {
      guard let heigtht = story?.text.height(withConstrainedWidth: width, font: .rockwell(27))
      else { return .zero}
      return CGSize(width: width - 20, height: heigtht)
    }

  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 25
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    if UIDevice.current.orientation == .landscapeLeft ||  UIDevice.current.orientation == .landscapeRight {
       return UIEdgeInsets(top: 80, left: 80, bottom: 80, right: 80)
    }
    
    return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
  }
}
extension UILabel {
    func getSize(constrainedWidth: CGFloat) -> CGSize {
        return systemLayoutSizeFitting(CGSize(width: constrainedWidth, height: UIView.layoutFittingCompressedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
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
