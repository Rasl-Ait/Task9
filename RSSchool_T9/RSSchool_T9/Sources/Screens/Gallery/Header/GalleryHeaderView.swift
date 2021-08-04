
import UIKit

final class GalleryHeaderView: UICollectionReusableView {
	// MARK: Properties
  
  private let closeButton = UIButton()
  private let titleLabel = CustomTitleLabel()
  private let typeLabel = CustomTitleLabel()
  private let imageView = CustomImageViewGradient(.gallery)
  private let lineView = UIView()
  private var views: [CAShapeLayer] = []

  var didCloseTapped: VoidClosure?
  var collectionViewHeightConstraint: NSLayoutConstraint!
  private var duration: TimeInterval?

  
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return cv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
  func configure(_ model: Gallery?) {
    guard let model = model else { return }
    imageView.image = model.coverImage
    titleLabel.text = model.title
    typeLabel.text = model.type
    collectionViewHeightConstraint.constant = 0
	}
  
  func basicAnimation(_ duration: TimeInterval) -> CABasicAnimation {
    let basic = CABasicAnimation(keyPath: "strokeEnd")
    basic.duration = duration
    basic.toValue = 1.0
    basic.fillMode = .both
    basic.isRemovedOnCompletion = false;
    return basic
  }
  
  func configure(_ model: Story?, color: String, isDraw: Bool) {
    guard let model = model else { return }
    imageView.image = model.coverImage
    titleLabel.text = model.title
    typeLabel.text = model.type
   
    duration = TimeInterval(isDraw ? 3 : 0)
    
    for i in model.paths.indices {
      let shape = CAShapeLayer()
      shape.path = model.paths[i]
      shape.strokeColor = UIColor(hexString: color).cgColor
      shape.fillColor = nil
      shape.lineWidth = 1
      shape.strokeEnd = 0
      views.append(shape)
    }
  

    collectionViewHeightConstraint.constant = 100
    
  }
}

private extension GalleryHeaderView {
	func setupViews() {
    setupButton()
		setupImage()
    setupLabel()
    setupLineView()
    setupCollectionView()
  }
  
  func setupButton() {
    closeButton.disableAutoresizingMask()
    closeButton.setBackgroundImage(UIImage(named: "close"), for: .normal)
    closeButton.addTarget(self, action: #selector(dissmissButtonTapped), for: .touchUpInside)
    addSubview(closeButton)
    
    NSLayoutConstraint.activate([
      closeButton.topAnchor .constraint(equalTo: topAnchor, constant: 20),
      closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
      closeButton.heightAnchor.constraint(equalToConstant: 40),
      closeButton.widthAnchor.constraint(equalToConstant: 40),
    ])
  }
	
	func setupLabel() {
    titleLabel.setLabel(title: "Story", alignment: .left, color: .white, fontName: .rockwell(48))
    typeLabel.setLabel(title: "Gallery", alignment: .center, color: .white, fontName: .rockwell(24))
   
    titleLabel.numberOfLines = 0
    
    typeLabel.layer.cornerRadius = 8
    typeLabel.backgroundColor = .black
    typeLabel.clipsToBounds = true
    typeLabel.borderColorView(borderWidht: 1, borderColor: .white)

    addSubview(typeLabel)
    addSubview(titleLabel)
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 25),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -58),
      titleLabel.bottomAnchor.constraint(equalTo:  imageView.bottomAnchor, constant: -40)
    ])
    
    NSLayoutConstraint.activate([
      typeLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
      typeLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
      //typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
      typeLabel.widthAnchor.constraint(equalToConstant: typeLabel.bounds.width + 60),
      typeLabel.heightAnchor.constraint(equalToConstant: 40),
    ])
    
	}
	
	func setupImage() {
    imageView.disableAutoresizingMask()
    imageView.image = UIImage(named: "story-1")
    imageView.layer.cornerRadius = 8
    imageView.centerCrop()
    imageView.borderColorView(borderWidht: 1, borderColor: .white)
    addSubview(imageView)
    
    NSLayoutConstraint.activate([
      imageView.topAnchor .constraint(equalTo: closeButton.bottomAnchor, constant: 30),
      imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      imageView.heightAnchor.constraint(equalToConstant: 500),
    ])
	}
  
  func setupLineView() {
    lineView.disableAutoresizingMask()
    lineView.backgroundColor = .white
    lineView.layer.cornerRadius = 0.5
    addSubview(lineView)
    NSLayoutConstraint.activate([
      lineView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
      lineView.topAnchor .constraint(equalTo: typeLabel.bottomAnchor, constant: 39),
      lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
      lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
      lineView.heightAnchor.constraint(equalToConstant: 1),
    ])
  }
  
  func setupCollectionView() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.bounces = false
    collectionView.backgroundColor = .black
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.register(UICollectionViewCell.self)
    addSubview(collectionView)
    
    collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 0)
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 40),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionViewHeightConstraint
    ])
}
  // MARK: Action
  @objc func dissmissButtonTapped() {
    didCloseTapped?()
  }
}

// MARK: UICollectionViewDataSource
extension GalleryHeaderView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return views.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: UICollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
    return cell
  }
}

// MARK: UICollectionViewDelegate
extension GalleryHeaderView: UICollectionViewDelegate {
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
extension GalleryHeaderView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 75, height: 75)
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return .zero
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 100
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
  }
}

class CustomTitleLabel: UILabel {

 let topInset = CGFloat(4.0), bottomInset = CGFloat(-4.0), leftInset = CGFloat(0.0), rightInset = CGFloat(0.0)

  override func drawText(in rect: CGRect) {

  let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    super.drawText(in: rect.inset(by: insets))

 }
}
