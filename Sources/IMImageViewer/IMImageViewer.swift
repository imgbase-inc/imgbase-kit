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
    static var headerViewHeight: CGFloat = 44
    static var footerViewHeight: CGFloat = 44
}

open class IMImageViewer: UIPageViewController {
    open var headerView: UIView? = BasicHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: LayoutConstants.headerViewHeight))
    open var footerView: UIView? = BasicFooterView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: LayoutConstants.footerViewHeight))

    open var assetViewer = AssetBaseViewer()
    private let pagingDataSource = PagingDataSource()
    private var isDismissing = false

    open override func viewDidLoad() {
        super.viewDidLoad()

        setViewHierarchy()
        setLayout()
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
        }

        if let footerView {
            footerView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
            footerView.bounds.size.width = self.view.bounds.width
            footerView.sizeToFit()
            footerView.frame.origin = CGPoint(x: 0, y: self.view.bounds.height - footerView.bounds.height - view.safeAreaInsets.bottom)
        }
    }

    private func setPagingViewController() {
        assetViewer.delegate = self
        pagingDataSource.assetControllerDelegate = self
        dataSource = pagingDataSource

        self.setViewControllers([assetViewer], direction: .forward, animated: true)
    }
}

extension IMImageViewer: AssetControllerDelegate {
    public func itemControllerChangeDismissStatus(_ isDismissing: Bool) {
        self.isDismissing = isDismissing
    }

    public func itemController(_ controller: AssetController, didSwipeToDismissWithDistanceToEdge distance: CGFloat) {
        if isDismissing {
            let alpha = 1 - distance * 6
            headerView?.alpha = alpha
            footerView?.alpha = alpha
        }
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
