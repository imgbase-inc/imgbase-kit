//
//  File.swift
//  
//
//  Created by odong on 2023/01/19.
//

import UIKit

public protocol AssetController: AnyObject {
    var index: Int { get }
    var isInitialController: Bool { get set }
    var delegate:                 AssetControllerDelegate? { get set }
//    var displacedViewsDataSource: GalleryDisplacedViewsDataSource? { get set }

    func fetchImage()

    func presentItem(alongsideAnimation: () -> Void, completion: @escaping () -> Void)
    func dismissItem(alongsideAnimation: () -> Void, completion: @escaping () -> Void)

    func closeDecorationViews(_ duration: TimeInterval)
}
