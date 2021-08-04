
import UIKit

class ImageViewerCell: BaseUICollectionViewCell {
	
	private let imageView = UIImageView()
	private let scrollView = UIScrollView()
	
  override func addSubViews() {
    setupViews()
  }
	
  func configure(_ image: UIImage?, isLanscape: Bool) {
			imageView.image = image
    imageView.contentMode = .scaleAspectFit
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		imageView.image = nil
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		//centerImage()
	}
}

private extension ImageViewerCell {
	func setupViews() {
		setupImage()
		setupScrollView()
	}
	
	func setupScrollView() {
    scrollView.disableAutoresizingMask()
		scrollView.minimumZoomScale = 1.0
		scrollView.maximumZoomScale = 3.0
		scrollView.showsVerticalScrollIndicator = false
		scrollView.showsHorizontalScrollIndicator = false
		scrollView.decelerationRate = .fast
		scrollView.delegate = self
		contentView.addSubview(scrollView)
    
    NSLayoutConstraint.activate([
//      scrollView.topAnchor .constraint(equalTo: contentView.topAnchor),
//      scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//      scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//      scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
      scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
      scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
      scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
      scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
      
      scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
      scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor),
      scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
      scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
    ])
	}
	
	func setupImage() {
    imageView.disableAutoresizingMask()
		imageView.contentMode = .scaleToFill
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
	
	func centerImage() {
		let boundsSize = bounds.size
		var frameToCenter = imageView.frame
		
		if frameToCenter.size.width < boundsSize.width {
			frameToCenter.origin.x = ( boundsSize.width - frameToCenter.size.width) / 2
		} else {
			frameToCenter.origin.x = 0
		}
		
		if frameToCenter.size.height < boundsSize.height {
			frameToCenter.origin.y = ( boundsSize.width - frameToCenter.size.height) / 2
		} else {
			frameToCenter.origin.y = 0
		}
		
		imageView.frame = frameToCenter
	}
}

// MARK: - UIScrollViewDelegate
extension ImageViewerCell: UIScrollViewDelegate {
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return imageView
	}
	
	func scrollViewDidZoom(_ scrollView: UIScrollView) {
		//centerImage()
	}
}
