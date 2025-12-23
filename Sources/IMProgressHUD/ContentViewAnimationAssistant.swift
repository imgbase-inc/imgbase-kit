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
    // 1. 먼저 상태 변경 (guard 조건을 위해)
    self.isPresenting = true

    // 2. withAnimation으로 뷰 업데이트 트리거하여 transition 애니메이션 적용
    withAnimation(.easeInOut(duration: animationTime)) {
      // 이미 isPresenting은 true이므로 guard는 정상 작동
      self.objectWillChange.send()
    }
  }

  func dismissWithAnimation(completion: @escaping () -> Void) {
    dismissCompletionHandler = completion

    // withAnimation 내에서 상태 변경하여 transition 애니메이션 적용
    withAnimation(.easeInOut(duration: animationTime)) {
      self.isPresenting = false
    }

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
