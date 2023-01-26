//
//  File.swift
//  
//
//  Created by odong on 2023/01/19.
//

import UIKit

final class SwipeDismissTransition {
    private weak var scrollView: UIScrollView?

    init(scrollView: UIScrollView? = nil) {
        self.scrollView = scrollView
    }

    func updateInteractiveTransition(horizontalOffset hOffset: CGFloat = 0, verticalOffset vOffset: CGFloat = 0) {
        scrollView?.setContentOffset(CGPoint(x:  hOffset, y: vOffset), animated: false)
    }

    func finishInteractiveTransition(touchPoint: CGFloat,  targetOffset: CGFloat, escapeVelocity: CGFloat, completion: (() -> Void)?) {
        let springVelocity = abs(escapeVelocity / (targetOffset - touchPoint))
        let expectedDuration = TimeInterval( abs(targetOffset - touchPoint) / abs(escapeVelocity)) * 0.65

        UIView.animate(withDuration: expectedDuration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: springVelocity, options: UIView.AnimationOptions.curveLinear, animations: { [weak self] () -> Void in
            self?.scrollView?.setContentOffset(CGPoint(x: 0, y: targetOffset), animated: false)
        }, completion: { (finished) -> Void in
                completion?()
        })
    }

    func cancelTransition() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) { [weak self] () -> Void in
            self?.scrollView?.setContentOffset(CGPoint.zero, animated: false)
        }
    }
}
