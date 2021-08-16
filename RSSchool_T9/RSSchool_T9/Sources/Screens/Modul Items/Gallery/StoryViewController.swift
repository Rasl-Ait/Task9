//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: rasul
// On: 8/15/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import Foundation

class StoryViewController: ItemsDetailViewController {
  
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return cv
  }()
  
  private lazy var textView: UITextView = {
      let view = UITextView()
      view.disableAutoresizingMask()
      view.font = .rockwell(24)
      view.backgroundColor = .black
      view.layer.borderColor = UIColor.white.cgColor
      view.layer.borderWidth = 1.0
      view.layer.cornerRadius = 8.0
      view.textContainerInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 40)
      view.isEditable = false
      view.textColor = .white
      view.isScrollEnabled = false
      return view
  }()
  
  var story: Story
  var color: String
  private var views: [CAShapeLayer] = []
  private var duration: TimeInterval?
  
  init(story: Story, color: String) {
    self.story = story
    self.color = color
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
}

// MARK: - private StoryViewController
private extension StoryViewController {
  func setupView() {
    textView.text = story.text
    contentView.addSubview(textView)
    setupCollectionView()
    configureConstraint()
    
    duration = TimeInterval(UserDefaults.standard.bool(forKey: "isDraw") ? 3 : 0)
    
    for i in story.paths.indices {
      let shape = CAShapeLayer()
      shape.path = story.paths[i]
      shape.strokeColor = UIColor(hexString: color).cgColor
      shape.fillColor = nil
      shape.lineWidth = 1
      shape.strokeEnd = 0
      views.append(shape)
    }
    
    setup(image: story.coverImage, title: story.title, type: story.type)
  }
  
  func setupCollectionView() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.bounces = false
    collectionView.backgroundColor = .black
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.register(UICollectionViewCell.self)
    contentView.addSubview(collectionView)
}
  
  func basicAnimation(_ duration: TimeInterval) -> CABasicAnimation {
    let basic = CABasicAnimation(keyPath: "strokeEnd")
    basic.duration = duration
    basic.toValue = 1.0
    basic.fillMode = .both
    basic.isRemovedOnCompletion = false;
    return basic
  }
  
  func configureConstraint() {
    NSLayoutConstraint.activate([
      
      collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
      collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      collectionView.heightAnchor.constraint(equalToConstant: 100),
      
      textView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40),
        textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
}

// MARK: UICollectionViewDataSource
extension StoryViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return views.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: UICollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
    return cell
  }
}

// MARK: UICollectionViewDelegate
extension StoryViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    let model = views[indexPath.item]
    model.add(basicAnimation(duration ?? 0), forKey: "basic")
    cell.contentView.layer.addSublayer(model)
  }
  
  func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    views[indexPath.item].removeFromSuperlayer()
  }
}

// MARK: UICollectionViewDelegateFlowLayout
extension StoryViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 75, height: 75)
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return .zero
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 100.0
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
  }
}
