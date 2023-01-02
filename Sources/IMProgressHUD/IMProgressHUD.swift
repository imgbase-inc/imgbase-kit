//
//  IMProgressHUD.swift
//  imgbase-kit
//
//  Created by Dongbin Kim on 28/12/2022.
//  Copyright © 2022 ImgBase, Inc. All rights reserved.
//

import SwiftUI

public class IMProgressHUD {
    @ObservedObject static var hudSetting = HUDSetting()
    @ObservedObject private static var contentViewPresenter = ContentViewAnimationAssistant()

    private static let progressView: UIView = {
        guard let view = UIHostingController(rootView: IMProgressView()
            .environmentObject(hudSetting)
            .environmentObject(contentViewPresenter)
        ).view else {
            fatalError("ProgressView를 생성할 수 없습니다.")
        }

        view.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)

        return view
    }()

    private static func show() {
        guard !contentViewPresenter.isPresenting else { return }

        let mainWindow = UIApplication.shared.windows.first ?? UIWindow()
        mainWindow.addSubview(progressView)
        mainWindow.isUserInteractionEnabled = hudSetting.isUserInteractionEnabled
    }

    public static func show(text: String? = nil, isUserInteractionEnabled: Bool = true, backgroundType: BackgroundType = .none) {
        setContentType(.infiniteRing)
        setTextString(text)
        setIsUserInteractionEnabled(isUserInteractionEnabled)
        setBackgroundType(backgroundType)

        show()
    }

    public static func show(with image: Image, text: String? = nil, isUserInteractionEnabled: Bool = true, backgroundType: BackgroundType = .none) {
        setContentType(.image(image))
        setTextString(text)
        setIsUserInteractionEnabled(isUserInteractionEnabled)
        setBackgroundType(backgroundType)

        show()
        timeOutDismiss()
    }

    public static func show(with image: UIImage, text: String? = nil, isUserInteractionEnabled: Bool = true, backgroundType: BackgroundType = .none) {
        let img = Image(uiImage: image)
        setContentType(.image(img))
        setTextString(text)
        setIsUserInteractionEnabled(isUserInteractionEnabled)
        setBackgroundType(backgroundType)

        show()
        timeOutDismiss()
    }

    public static func showSuccess(text: String? = nil) {
        setContentType(.success)
        setTextString(text)

        show()
        timeOutDismiss()
    }

    public static func showFail(text: String? = nil) {
        setContentType(.fail)
        setTextString(text)

        show()
        timeOutDismiss()
    }

    public static func dismiss() {
        guard contentViewPresenter.isPresenting else { return }

        contentViewPresenter.addDisappearObserver(self, selector: #selector(dismissProgressView))
        contentViewPresenter.dismissWithAnimation()
    }

    private static func timeOutDismiss() {
        let displayDuration = hudSetting.displayDurationForString
        var progress: Double = 0.0
        let timer = Timer(timeInterval: 0.01, repeats: true) { timer in
            guard contentViewPresenter.isPresenting else {
                timer.invalidate()
                
                return
            }

            progress += 0.01
            progress = min(displayDuration, progress)

            if progress == displayDuration {
                timer.invalidate()
                dismiss()
            }
        }

        RunLoop.main.add(timer, forMode: .common)
    }

    @objc private static func dismissProgressView() {
        progressView.removeFromSuperview()
    }
}

// MARK: Setting Method
extension IMProgressHUD {
    public static func setTextString(_ text: String?) {
        self.hudSetting.textString = text
    }

    public static func setTextColor(_ color: Color) {
        self.hudSetting.textColor = color
    }

    public static func setTextColor(_ color: UIColor) {
        self.hudSetting.textColor = color.suColor
    }

    public static func setTextFont(_ font: Font) {
        self.hudSetting.textFont = font
    }

    public static func setForegroundColor(_ color: Color) {
        self.hudSetting.foregroundColor = color
    }

    public static func setForegroundColor(_ color: UIColor) {
        self.hudSetting.foregroundColor = color.suColor
    }

    public static func setBackgroundColor(_ color: Color) {
        self.hudSetting.backgroundColor = color
    }

    public static func setBackgroundColor(_ color: UIColor) {
        self.hudSetting.backgroundColor = color.suColor
    }

    public static func setMinimumSize(_ size: CGSize) {
        self.hudSetting.minimumSize = size
    }

    public static func setImageViewSize(_ size: CGSize) {
        self.hudSetting.imageViewSize = size
    }

    public static func setCornerRadius(_ radius: CGFloat) {
        self.hudSetting.cornerRadius = radius
    }

    public static func setRingThickness(_ thickness: CGFloat) {
        self.hudSetting.ringThickness = thickness
    }

    public static func setSuccessImage(_ image: Image) {
        self.hudSetting.successImage = image
    }

    public static func setSuccessImage(_ image: UIImage) {
        self.hudSetting.successImage = Image(uiImage: image)
    }

    public static func setErrorImage(_ image: Image) {
        self.hudSetting.errorImage = image
    }

    public static func setErrorImage(_ image: UIImage) {
        self.hudSetting.errorImage = Image(uiImage: image)
    }

    public static func setMaximumDismissTimeInterval(_ timeInterval: TimeInterval) {
        self.hudSetting.maximumDismissTimeInterval = timeInterval
    }

    public static func setMinimumDismissTimeInterval(_ timeInterval: TimeInterval) {
        self.hudSetting.minimumDismissTimeInterval = timeInterval
    }

    public static func setIsUserInteractionEnabled(_ enabled: Bool) {
        self.hudSetting.isUserInteractionEnabled = enabled
    }

    public static func setBackgroundType(_ type: BackgroundType) {
        self.hudSetting.backgroundType = type
    }

    public static func setContentType(_ type: ContentType) {
        self.hudSetting.contentType = type
    }

    public static func setContentsVerticalSpacing(_ spacing: CGFloat) {
        self.hudSetting.contentsVerticalSpacing = spacing
    }
}
