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

  // 애니메이션 완료 콜백
  private var dismissCompletionHandler: (() -> Void)?

  func showWithAnimation() {
    // withAnimation 제거: 상태를 즉시 변경
    // 애니메이션은 IMProgressView의 .animation() modifier가 처리
    self.isPresenting = true
  }

  func dismissWithAnimation(completion: @escaping () -> Void) {
    dismissCompletionHandler = completion

    // withAnimation 제거: 상태를 즉시 변경
    self.isPresenting = false

    // 안전장치: 애니메이션 시간 + 여유시간 후 강제 실행
    DispatchQueue.main.asyncAfter(deadline: .now() + animationTime + 0.1) { [weak self] in
      self?.notifyDismissComplete()
    }
  }

  func notifyDismissComplete() {
    dismissCompletionHandler?()
    dismissCompletionHandler = nil
  }
}
