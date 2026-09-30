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
  // 이전 dismiss의 안전장치가 이후 dismiss를 앞당겨 완료시키지 않도록 구분한다.
  private var dismissGeneration = 0

  /// dismiss 애니메이션이 끝나기를 기다리는 중인지
  var isDismissing: Bool {
    dismissCompletionHandler != nil
  }

  func showWithAnimation() {
    withAnimation(.easeInOut(duration: animationTime)) {
      self.isPresenting = true
    }
  }

  func dismissWithAnimation(completion: @escaping () -> Void) {
    dismissGeneration += 1
    let generation = dismissGeneration
    dismissCompletionHandler = completion

    // withAnimation 내에서 상태 변경하여 transition 애니메이션 적용
    withAnimation(.easeInOut(duration: animationTime)) {
      self.isPresenting = false
    }

    // 안전장치: 애니메이션 시간 + 여유시간 후 강제 실행
    DispatchQueue.main.asyncAfter(deadline: .now() + animationTime + 0.1) { [weak self] in
      guard let self, self.dismissGeneration == generation else { return }
      self.notifyDismissComplete()
    }
  }

  /// 진행 중인 dismiss의 완료 처리를 취소한다.
  func cancelDismiss() {
    dismissGeneration += 1
    dismissCompletionHandler = nil
  }

  func notifyDismissComplete() {
    dismissCompletionHandler?()
    dismissCompletionHandler = nil
  }
}
