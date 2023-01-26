//
//  AssetBaseViewer.swift
//  imgbase-kit
//
//  Created by Dongbin Kim on 16/01/2023.
//  Copyright © 2023 ImgBase, Inc. All rights reserved.
//

import UIKit
import AVFoundation

public protocol AssetViewer { }

open class AssetBaseViewer: UIViewController, UIGestureRecognizerDelegate {
    private let scrollView = UIScrollView()
    private let activityIndicatorView = UIActivityIndicatorView(style: .medium)

    weak public var delegate: AssetControllerDelegate?

    private let doubleTapRecognizer = UITapGestureRecognizer()
    private let swipeDismissRecognizer = UIPanGestureRecognizer()

    private var swipeDismissTransition: SwipeDismissTransition?
    
    // tmp
    let assetView: UIImageView = UIImageView(image: UIImage(data: try! Data(contentsOf: URL(string: "https://picsum.photos/300/700")!))!)

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewHierarchy()
        setScrollView()
        setScrollViewLayout()
        setGestureRecognizer()
    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        setAssetViewSize()
    }

    deinit {
        self.scrollView.removeObserver(self, forKeyPath: "contentOffset")
    }

    private func setViewHierarchy() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(assetView)
    }

    private func setScrollView() {
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.decelerationRate = UIScrollView.DecelerationRate.fast
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.contentOffset = CGPoint.zero
        scrollView.maximumZoomScale = max(8, aspectFillZoomScale(forBoundingSize: self.view.bounds.size, contentSize: assetView.bounds.size))
        scrollView.minimumZoomScale = 1

        scrollView.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.new, context: nil)
    }

    private func setGestureRecognizer() {
        doubleTapRecognizer.addTarget(self, action: #selector(scrollViewDidDoubleTap))
        doubleTapRecognizer.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapRecognizer)

        swipeDismissRecognizer.addTarget(self, action: #selector(scrollViewDidSwipeToDismiss))
        swipeDismissRecognizer.delegate = self
        swipeDismissRecognizer.require(toFail: doubleTapRecognizer)
        view.addGestureRecognizer(swipeDismissRecognizer)
    }

    private func setScrollViewLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutConstants.headerViewHeight + LayoutConstants.defaultTopMargin),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -LayoutConstants.footerViewHeight)
        ])
    }

    private func setAssetViewSize() {
        if let size = assetView.image?.size , size != CGSize.zero {
            let aspectFitItemSize = aspectFitSize(forContentOfSize: size, inBounds: self.scrollView.bounds.size)

            assetView.bounds.size = aspectFitItemSize
            scrollView.contentSize = assetView.bounds.size
            assetView.center = scrollView.boundsCenter
        }
    }

    private func aspectFitSize(forContentOfSize contentSize: CGSize, inBounds bounds: CGSize) -> CGSize {

        return AVMakeRect(aspectRatio: contentSize, insideRect: CGRect(origin: CGPoint.zero, size: bounds)).size
    }
}

// MARK: Zoom Control
extension AssetBaseViewer: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return assetView
    }

    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        assetView.center = contentCenter(forBoundingSize: scrollView.bounds.size, contentSize: scrollView.contentSize)
    }

    @objc func scrollViewDidDoubleTap(_ recognizer: UITapGestureRecognizer) {

        let touchPoint = recognizer.location(ofTouch: 0, in: assetView)
        let aspectFillScale = aspectFillZoomScale(forBoundingSize: scrollView.bounds.size, contentSize: assetView.bounds.size)

        if scrollView.zoomScale == 1.0 || scrollView.zoomScale > aspectFillScale {
            let zoomRectangle = zoomRect(ForScrollView: scrollView, scale: aspectFillScale, center: touchPoint)

            UIView.animate(withDuration: 0.15) { [weak self] in
                self?.scrollView.zoom(to: zoomRectangle, animated: false)
            }
        } else {
            UIView.animate(withDuration: 0.15) { [weak self] in
                self?.scrollView.setZoomScale(1.0, animated: false)
            }
        }
    }

    private func aspectFillZoomScale(forBoundingSize boundingSize: CGSize, contentSize: CGSize) -> CGFloat {
        let aspectFitSize = AVMakeRect(aspectRatio: contentSize, insideRect: CGRect(origin: CGPoint.zero, size: boundingSize)).size

        return floor(boundingSize.width) == floor(aspectFitSize.width) ? boundingSize.width / aspectFitSize.width :
        (boundingSize.width / aspectFitSize.width)
    }

    private func zoomRect(ForScrollView scrollView: UIScrollView, scale: CGFloat, center: CGPoint) -> CGRect {
        let width = scrollView.frame.size.width  / scale
        let height = scrollView.frame.size.height / scale
        let originX = center.x - (width / 2.0)
        let originY = center.y - (height / 2.0)

        return CGRect(x: originX, y: originY, width: width, height: height)
    }

    private func contentCenter(forBoundingSize boundingSize: CGSize, contentSize: CGSize) -> CGPoint {
        let horizontalOffset = (boundingSize.width > contentSize.width) ? ((boundingSize.width - contentSize.width) * 0.5): 0.0
        let verticalOffset   = (boundingSize.height > contentSize.height) ? ((boundingSize.height - contentSize.height) * 0.5): 0.0

        return CGPoint(x: contentSize.width * 0.5 + horizontalOffset, y: contentSize.height * 0.5 + verticalOffset)
    }
}

// MARK: Swipe Dismiss
extension AssetBaseViewer {
    @objc func scrollViewDidSwipeToDismiss(_ recognizer: UIPanGestureRecognizer) {
        guard scrollView.zoomScale == scrollView.minimumZoomScale else { return }

        let currentVelocity = recognizer.velocity(in: self.view)
        let currentTouchPoint = recognizer.translation(in: view)

        switch recognizer.state {
        case .began:
            swipeDismissTransition = SwipeDismissTransition(scrollView: self.scrollView)

            delegate?.itemControllerChangeDismissStatus(true)
        case .changed:
            self.handleSwipeToDismissInProgress(forTouchPoint: currentTouchPoint)

            delegate?.itemControllerChangeDismissStatus(true)
        case .ended:
            self.handleSwipeToDismissEnded(finalVelocity: currentVelocity, finalTouchPoint: currentTouchPoint)

            delegate?.itemControllerChangeDismissStatus(false)
        default:
            break
        }
    }

    func handleSwipeToDismissInProgress(forTouchPoint touchPoint: CGPoint) {
        swipeDismissTransition?.updateInteractiveTransition(verticalOffset: -touchPoint.y)
    }

    func handleSwipeToDismissEnded(finalVelocity velocity: CGPoint, finalTouchPoint touchPoint: CGPoint) {
        let thresholdVelocity: CGFloat = 500

        let swipeToDismissCompletionBlock = { [weak self] in
            let applicationWindow = UIApplication.shared.delegate?.window?.flatMap { $0 }
            applicationWindow?.windowLevel = UIWindow.Level.normal

            self?.delegate?.itemControllerDidFinishSwipeToDismissSuccessfully()
        }

        if velocity.y < -thresholdVelocity {
            swipeDismissTransition?.finishInteractiveTransition(touchPoint: touchPoint.y,
                                                                  targetOffset: (view.bounds.height / 2) + (assetView.bounds.height / 2),
                                                                  escapeVelocity: velocity.y,
                                                                  completion: swipeToDismissCompletionBlock)
        } else if thresholdVelocity < velocity.y {
            swipeDismissTransition?.finishInteractiveTransition(                                                                  touchPoint: touchPoint.y,
                                                                                                                                    targetOffset: -(view.bounds.height / 2) - (assetView.bounds.height / 2),
                                                                                                                                    escapeVelocity: velocity.y,
                                                                                                                                    completion: swipeToDismissCompletionBlock)
        } else {
            swipeDismissTransition?.cancelTransition()
        }
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == swipeDismissRecognizer else { return false }

        let velocity = swipeDismissRecognizer.velocity(in: swipeDismissRecognizer.view)

        guard velocity.orientation != .none else { return false }
        guard velocity.orientation == .horizontal else { return true }

        return false
    }

    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {

        guard keyPath == "contentOffset" else { return }

        let distanceToEdge: CGFloat
        let percentDistance: CGFloat

        distanceToEdge = (scrollView.bounds.height / 2) + (assetView.bounds.height / 2)
        percentDistance = abs(scrollView.contentOffset.y / distanceToEdge)

        if let delegate = self.delegate {
            delegate.itemController(self, didSwipeToDismissWithDistanceToEdge: percentDistance)
        }
    }
}

// MARK: AssetController
extension AssetBaseViewer: AssetController {
    public var index: Int {
        10
    }

    public var isInitialController: Bool {
        get {
            return self.isInitialController
        }
        set {
            self.isInitialController = newValue
        }
    }

    public func fetchImage() {

    }

    public func presentItem(alongsideAnimation: () -> Void, completion: @escaping () -> Void) {

    }

    public func dismissItem(alongsideAnimation: () -> Void, completion: @escaping () -> Void) {

    }

    public func closeDecorationViews(_ duration: TimeInterval) {

    }


}
