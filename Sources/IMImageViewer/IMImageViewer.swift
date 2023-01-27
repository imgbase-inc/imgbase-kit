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
    open var headerView: UIView? = BasicHeaderView()
    open var footerView: UIView? = BasicFooterView()

    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
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

        self.view.addSubview(overlayView)
        self.view.sendSubviewToBack(overlayView)
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

        overlayView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
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
            overlayView.alpha = 1 - distance
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
