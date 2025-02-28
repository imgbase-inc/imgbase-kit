//
//  IMProgressView.swift
//  imgbase-kit
//
//  Created by Dongbin Kim on 28/12/2022.
//  Copyright © 2022 ImgBase, Inc. All rights reserved.
//

import SwiftUI

extension IMProgressView {
  private enum LayoutConstant {
    static let contentViewPadding: CGFloat = 20
  }
}

internal struct IMProgressView: View {
  @EnvironmentObject private var hudSetting: HUDSetting
  @EnvironmentObject private var contentViewAnimationAssistant: ContentViewAnimationAssistant

  @State private var animationTime: Double = 0.25

  var body: some View {
    ZStack {
      background()
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

      if contentViewAnimationAssistant.isPresenting {
        VStack(spacing: hudSetting.contentsVerticalSpacing) {
          contentImage()
            .frame(width: hudSetting.imageViewSize.width, height: hudSetting.imageViewSize.height)

          if let text = hudSetting.textString {
            Text(text)
              .foregroundColor(hudSetting.textColor)
              .font(hudSetting.textFont)
          }
        }
        .frame(
          minWidth: hudSetting.minimumSize.width - LayoutConstant.contentViewPadding * 2,
          minHeight: hudSetting.minimumSize.height - LayoutConstant.contentViewPadding * 2
        )
        .padding(LayoutConstant.contentViewPadding)
        .background(
          hudSetting.backgroundColor
            .clipShape(RoundedRectangle(cornerRadius: hudSetting.cornerRadius))
        )
        .transition(.scale(scale: 0.4).combined(with: .opacity))
        .zIndex(1)
        .onDisappear {
          contentViewAnimationAssistant.postDisappearNotification()
          contentViewAnimationAssistant.removeDisappearObserver()
        }
      }
    }
  }

  private func contentImage() -> AnyView {
    switch hudSetting.contentType {
    case .infiniteRing: return AnyView(InfinityRingView())
    case .image(let img): return AnyView(img.resizable())
    case .success: return AnyView(hudSetting.successImage.resizable())
    case .fail: return AnyView(hudSetting.errorImage.resizable())
    }
  }

  private func background() -> AnyView {
    switch hudSetting.backgroundType {
    case .none: return AnyView(ClearBackgroundView())
    case .black: return AnyView(BlackBackgroundView())
    case .blur: return AnyView(BlurBackgroundView())
    }
  }
}
