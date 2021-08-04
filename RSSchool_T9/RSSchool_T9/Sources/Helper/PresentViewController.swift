

import UIKit

enum PresentScreenType {
  case items
  case gallery
}

class PresentViewController: NSObject, UIViewControllerAnimatedTransitioning {
  
  private let duration = 0.5
  var presenting = true
  var originFrame = CGRect.zero
  var presentType = PresentScreenType.items
  
  var dismissCompletion: (() -> Void)?
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    let containerView = transitionContext.containerView
    let herbView = presenting ? transitionContext.view(forKey: .to)! : transitionContext.view(forKey: .from)!
    containerView.addSubview(herbView)
    
    let initialFrame = presenting ? originFrame : herbView.frame
    let finalFrame = presenting ? herbView.frame : originFrame
    let xScaleFactor = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
    let yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
    let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
    
    if presenting {
      herbView.transform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
      herbView.center = CGPoint(
        x: initialFrame.midX,
        y: initialFrame.midY)
      herbView.clipsToBounds = true
    }
    
    if let toView = transitionContext.view(forKey: .to) {
      containerView.addSubview(toView)
    }
    containerView.bringSubviewToFront(herbView)
    
    UIView.animate(withDuration: duration, delay: 0.0,
                   usingSpringWithDamping: 0.8,
                   initialSpringVelocity: 0.8,
                   options: [.curveEaseInOut],
                   animations: {
                    
                    herbView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
                    herbView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
                    
                    // containerView.alpha = self.presenting ? 1.0 : 0.0
                    
                   }) { _ in
      
      if !self.presenting {
        self.dismissCompletion?()
      }
      transitionContext.completeTransition(true)
    }
    
    let radius: CGFloat = presentType != .gallery ? 18.0 : 8.0
    
    let round = CABasicAnimation(keyPath: "cornerRadius")
    round.fromValue = !presenting ? 0.0 : radius / xScaleFactor
    round.toValue = presenting ? 0.0 : radius / xScaleFactor
    round.duration = duration / 2
    herbView.layer.add(round, forKey: nil)
    herbView.layer.cornerRadius = presenting ? 0.0 : radius / xScaleFactor
    
  }
}
