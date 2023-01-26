//
//  File.swift
//  
//
//  Created by odong on 2023/01/19.
//

import UIKit

public protocol AssetControllerDelegate: AnyObject {
    func itemControllerChangeDismissStatus(_ isDismissing: Bool)
    func itemController(_ controller: AssetController, didSwipeToDismissWithDistanceToEdge distance: CGFloat)
    func itemControllerDidFinishSwipeToDismissSuccessfully()
    func itemControllerWillAppear(_ controller: AssetController)
    func itemControllerWillDisappear(_ controller: AssetController)
    func itemControllerDidAppear(_ controller: AssetController)
}
