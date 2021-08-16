//
// 📰 🐸
// Project: RSSchool_T9
// 
// Author: rasul
// On: 7/29/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class ItemsViewController: BaseViewController {
  
  private let transition = PresentViewController()
  private var selectedImage: UIImageView?
  
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return cv
  }()
  
  var colorText = "#f3af22"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    
    transition.dismissCompletion = {
      self.selectedImage?.isHidden = false
    }
    
    NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: Notification.Name("kUpdateColor"), object: nil)
    
    UserDefaults.standard.set(true, forKey: "isDraw")
    
  }
  
  @objc func onDidReceiveData(_ notification: Notification) {
    if let dict = notification.userInfo as NSDictionary? {
      if let color = dict["color"] as? String {
        colorText = color
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    super.hideNavigationBar(isHidden: true, barStyle: .default)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(true)
  //  NotificationCenter.default.removeObserver(self)
  }
  
  override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
    collectionView.collectionViewLayout.invalidateLayout()
  }
}

//MARK: - private GalleryViewController
private extension ItemsViewController {
  func setupView() {
    view.backgroundColor = .white
    setupCollectionView()
  }
  
  func setupCollectionView() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .white
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.register(ItemsCollectionCell.self)
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
extension ItemsViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return FillingData.data.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: ItemsCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
    let model = FillingData.data[indexPath.item]
    cell.configure(model)
    return cell
  }
}

// MARK: UICollectionViewDelegate
extension ItemsViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: false)
    guard let cell = collectionView.cellForItem(at: indexPath) as? ItemsCollectionCell else {return}
    selectedImage = cell.imageView
    
    let model = FillingData.data[indexPath.item]
  
    
    switch model {
    case .gallery(let gallery):
      let vc = GalleryViewController(gallery: gallery)
      vc.transitioningDelegate = self
      vc.modalPresentationStyle = .overFullScreen
      present(vc, animated: true, completion: nil)
    case .story(let story):
      let vc = StoryViewController(story: story, color: colorText)
      vc.transitioningDelegate = self
      vc.modalPresentationStyle = .overFullScreen
      present(vc, animated: true, completion: nil)
    }
  }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ItemsViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
      let width = (collectionView.frame.width - 180) / 2
      return CGSize(width: width, height: width + 40)
    }
    
    let width = (collectionView.frame.width - 40) / 2
    return CGSize(width: width, height: width + 40)
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 30
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    if UIDevice.current.orientation == .landscapeLeft ||  UIDevice.current.orientation == .landscapeRight {
       return UIEdgeInsets(top: 80, left: 80, bottom: 80, right: 80)
    }
    
    return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
  }
}
  

// MARK: - UIViewControllerTransitioningDelegate
extension ItemsViewController: UIViewControllerTransitioningDelegate {
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
