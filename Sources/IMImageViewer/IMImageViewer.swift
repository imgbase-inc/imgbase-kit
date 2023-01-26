//
//  IMIageViewer.swift
//  imgbase-kit
//
//  Created by Dongbin Kim on 16/01/2023.
//  Copyright © 2023 ImgBase, Inc. All rights reserved.
//

import UIKit

enum LayoutConstants {
    static let defaultTopMargin: CGFloat = 20
    static var headerViewHeight: CGFloat?
    static var footerViewHeight: CGFloat?
}

open class IMImageViewer: UIPageViewController {
    open var headerView: UIView?
    open var footerView: UIView?

    open var assetViewer = AssetBaseViewer()
    private let pagingDataSource = PagingDataSource()

    open override func viewDidLoad() {
        super.viewDidLoad()

        setViewHierarchy()
        setLayout()
        initHeaderFooterViewHeight()
        setPagingViewController()
    }

    override open func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        setLayout()
    }

    private func setViewHierarchy() {
        if let headerView {
            self.view.addSubview(headerView)
        }

        if let footerView {
            self.view.addSubview(footerView)
        }
    }

    private func setLayout() {
        if let headerView {
            headerView.autoresizingMask = [.flexibleBottomMargin, .flexibleWidth]
            headerView.bounds.size.width = self.view.bounds.width
            headerView.sizeToFit()
            headerView.frame.origin = CGPoint(x: 0, y: view.safeAreaInsets.top + LayoutConstants.defaultTopMargin)

            // tmp
            headerView.backgroundColor = .green
        }

        if let footerView {
            footerView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
            footerView.bounds.size.width = self.view.bounds.width
            footerView.sizeToFit()
            footerView.frame.origin = CGPoint(x: 0, y: self.view.bounds.height - footerView.bounds.height - view.safeAreaInsets.bottom)

            // tmp
            footerView.backgroundColor = .blue
        }
    }

    private func initHeaderFooterViewHeight() {
        LayoutConstants.headerViewHeight = headerView?.frame.height
        LayoutConstants.footerViewHeight = footerView?.frame.height
    }

    private func setPagingViewController() {
        assetViewer.delegate = self
        pagingDataSource.assetControllerDelegate = self
        dataSource = pagingDataSource

        self.setViewControllers([assetViewer], direction: .forward, animated: true)
    }
}

extension IMImageViewer: AssetControllerDelegate {
    public func itemController(_ controller: AssetController, didSwipeToDismissWithDistanceToEdge distance: CGFloat) {

//        if decorationViewsHidden == false {

            let alpha = 1 - distance * 6
            headerView?.alpha = alpha
            footerView?.alpha = alpha

//            if controller is VideoViewController {
//                scrubber.alpha = alpha
//            }
//        }

//        self.overlayView.blurringView.alpha = 1 - distance
//        self.overlayView.colorView.alpha = 1 - distance
    }

    public func itemControllerDidFinishSwipeToDismissSuccessfully() {
//        self.overlayView.removeFromSuperview()
        self.dismiss(animated: false, completion: nil)
    }

    public func itemControllerWillAppear(_ controller: AssetController) {

    }

    public func itemControllerWillDisappear(_ controller: AssetController) {

    }

    public func itemControllerDidAppear(_ controller: AssetController) {

    }
}
