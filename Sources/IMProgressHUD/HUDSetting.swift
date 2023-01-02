//
//  HUDSetting.swift
//  imgbase-kit
//
//  Created by Dongbin Kim on 28/12/2022.
//  Copyright © 2022 ImgBase, Inc. All rights reserved.
//

import SwiftUI

public enum ContentType {
    case infiniteRing
    case image(_ custom: Image)
    case success
    case fail
}

public enum BackgroundType {
    case black
    case none
    case blur
}

internal class HUDSetting: ObservableObject {
    @Published var contentType: ContentType = .infiniteRing
    @Published var backgroundType: BackgroundType = .none
    @Published var textString: String?
    @Published var textColor: Color = .black.opacity(0.8)
    @Published var textFont: Font = .body
    @Published var foregroundColor: Color = .blue
    @Published var backgroundColor: Color = .white
    @Published var minimumSize: CGSize = .zero
    @Published var cornerRadius: CGFloat = 10
    @Published var imageViewSize: CGSize = CGSize(width: 40, height: 40)
    @Published var ringThickness: CGFloat = 3
    @Published var contentsVerticalSpacing: CGFloat = 15
    @Published var isUserInteractionEnabled: Bool = true
    @Published var successImage: Image = Image(systemName: "checkmark")
    @Published var errorImage: Image = Image(systemName: "xmark.circle")
    @Published var maximumDismissTimeInterval: TimeInterval = 3.0
    @Published var minimumDismissTimeInterval: TimeInterval = 2.0

    var displayDurationForString: TimeInterval {
        get {
            let max = Double(textString?.count ?? 0) * 0.06 + minimumDismissTimeInterval
            return min(max, maximumDismissTimeInterval)
        }
    }
}

