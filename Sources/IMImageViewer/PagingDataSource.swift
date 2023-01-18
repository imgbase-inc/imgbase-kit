//
//  PagingDataSource.swift
//  imgbase-kit
//
//  Created by Dongbin Kim on 17/01/2023.
//  Copyright © 2023 ImgBase, Inc. All rights reserved.
//

import UIKit

final class PagingDataSource: NSObject, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        print("<<<<")

        let vc = UIViewController()
        vc.view.backgroundColor = .purple

        return vc
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        print(">>>>")
        let vc = UIViewController()
        vc.view.backgroundColor = .darkGray

        return vc
    }
}
