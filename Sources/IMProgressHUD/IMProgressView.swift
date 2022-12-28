//
//  IMProgressView.swift
//  imgbase-kit
//
//  Created by Dongbin Kim on 28/12/2022.
//  Copyright © 2022 ImgBase, Inc. All rights reserved.
//

import SwiftUI

internal struct IMProgressView: View {
    @EnvironmentObject var hudSetting: HUDSetting

    var body: some View {
        ZStack {
            background()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

            VStack(spacing: 15) {
                contentImage()
                    .resizable()
                    .frame(width: hudSetting.imageViewSize.width, height: hudSetting.imageViewSize.height)

                if let text = hudSetting.textString {
                    Text(text)
                        .foregroundColor(hudSetting.textColor)
                        .font(hudSetting.textFont)
                }
            }
            .frame(minWidth: hudSetting.minimumSize.width, minHeight: hudSetting.minimumSize.height)
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background(
                hudSetting.backgroundColor
                    .clipShape(RoundedRectangle(cornerRadius: hudSetting.cornerRadius))
            )
        }
    }

    private func contentImage() -> Image {
        switch hudSetting.contentType {
        case .infiniteRing: return Image(systemName: "circle") // TODO: InfiniteRingView
        case .image(let img): return img
        case .success: return hudSetting.successImage
        case .fail: return hudSetting.errorImage
        }
    }

    private func background() -> AnyView {
        switch hudSetting.backgroundType {
        case .none: return AnyView(Color.clear)
        case .black: return AnyView(Color.black.opacity(0.2))
        case .blur: return AnyView(BlurView())
        }
    }
}
