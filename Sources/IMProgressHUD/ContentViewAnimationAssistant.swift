//
//  ContentViewAnimationAssistant.swift
//  imgbase-kit
//
//  Created by Dongbin Kim on 28/12/2022.
//  Copyright © 2022 ImgBase, Inc. All rights reserved.
//

import SwiftUI

internal class ContentViewAnimationAssistant: ObservableObject {
    @Published var isPresenting = false
    private let animationTime: Double = 0.25

    func showWithAnimation() {
        withAnimation(.easeInOut(duration: animationTime)) {
            self.isPresenting = true
        }
    }

//    func showWithAnimation(selector: Selector) {
//        withAnimation(.easeInOut(duration: animationTime)) {
//            self.isPresenting = true
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + animationTime + 0.05) {
//
//            self.addDisappearObserver(self, selector: selector)
//            self.dismissWithAnimation()
//        }
//    }

    func dismissWithAnimation() {
        withAnimation(.easeInOut(duration: animationTime)) {
            self.isPresenting = false
        }
    }

    func postDisappearNotification() {
        NotificationCenter.default.post(name: Notification.Name.disappearContentView, object: nil)
    }

    func addDisappearObserver(_ observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: Notification.Name.disappearContentView, object: nil)
    }

    func removeDisappearObserver() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.disappearContentView, object: nil)
    }
}
