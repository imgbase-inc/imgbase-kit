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
  @ObservedObject private static var contentViewAnimationAssistant = ContentViewAnimationAssistant()

  // 이전 표시의 자동 닫기 타이머가 이후 표시를 닫지 않도록 하나만 유지한다.
  private static var timeoutTimer: Timer?

  private static let progressView: UIView = {
    guard
      let view = UIHostingController(
        rootView: IMProgressView()
          .environmentObject(hudSetting)
          .environmentObject(contentViewAnimationAssistant)
      ).view
    else {
      fatalError("ProgressView를 생성할 수 없습니다.")
    }

    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .clear

    return view
  }()

  /// UIKit·SwiftUI 상태를 다루므로 백그라운드 스레드에서 호출돼도 메인 스레드에서 실행한다.
  /// 백그라운드 호출은 메인 큐에 비동기로 예약되므로, 그사이 메인 스레드에서 호출한 show/dismiss보다 늦게 실행될 수 있다.
  private static func performOnMain(_ work: @escaping () -> Void) {
    if Thread.isMainThread {
      work()
    } else {
      DispatchQueue.main.async(execute: work)
    }
  }

  private static func show() {
    // 사라지는 중에 다시 표시하면 대기 중인 제거를 취소한다.
    // 취소하지 않으면 이전 dismiss의 완료 처리가 새로 표시한 뷰를 제거해 isPresenting만 true로 남는다.
    if contentViewAnimationAssistant.isDismissing {
      contentViewAnimationAssistant.cancelDismiss()
    }
    guard !contentViewAnimationAssistant.isPresenting else { return }

    let mainWindow = UIApplication.shared.windows.first ?? UIWindow()
    if progressView.superview !== mainWindow {
      mainWindow.addSubview(progressView)

      NSLayoutConstraint.activate([
        progressView.centerXAnchor.constraint(equalTo: mainWindow.centerXAnchor),
        progressView.centerYAnchor.constraint(equalTo: mainWindow.centerYAnchor),
      ])
    } else {
      mainWindow.bringSubviewToFront(progressView)
    }

    contentViewAnimationAssistant.showWithAnimation()
  }

  public static func show(
    text: String? = nil,
    isUserInteractionEnabled: Bool = true,
    backgroundType: BackgroundType = .none
  ) {
    performOnMain {
      setContentType(.infiniteRing)
      setTextString(text)
      setIsUserInteractionEnabled(isUserInteractionEnabled)
      setBackgroundType(backgroundType)

      show()
    }
  }

  public static func show(
    with image: Image,
    text: String? = nil,
    isUserInteractionEnabled: Bool = true,
    backgroundType: BackgroundType = .none
  ) {
    performOnMain {
      setContentType(.image(image))
      setTextString(text)
      setIsUserInteractionEnabled(isUserInteractionEnabled)
      setBackgroundType(backgroundType)

      show()
      timeOutDismiss()
    }
  }

  public static func show(
    with image: UIImage,
    text: String? = nil,
    isUserInteractionEnabled: Bool = true,
    backgroundType: BackgroundType = .none
  ) {
    performOnMain {
      let img = Image(uiImage: image)
      setContentType(.image(img))
      setTextString(text)
      setIsUserInteractionEnabled(isUserInteractionEnabled)
      setBackgroundType(backgroundType)

      show()
      timeOutDismiss()
    }
  }

  public static func showSuccess(text: String? = nil) {
    performOnMain {
      setContentType(.success)
      setTextString(text)

      show()
      timeOutDismiss()
    }
  }

  public static func showFail(text: String? = nil) {
    performOnMain {
      setContentType(.fail)
      setTextString(text)

      show()
      timeOutDismiss()
    }
  }

  public static func dismiss() {
    performOnMain {
      guard contentViewAnimationAssistant.isPresenting else { return }
      guard !contentViewAnimationAssistant.isDismissing else { return }

      invalidateTimeoutTimer()

      contentViewAnimationAssistant.dismissWithAnimation { [weak progressView] in
        progressView?.removeFromSuperview()
        setIsUserInteractionEnabled(true)
      }
    }
  }

  private static func timeOutDismiss() {
    invalidateTimeoutTimer()
    let timer = Timer(timeInterval: hudSetting.displayDurationForString, repeats: false) { _ in
      dismiss()
    }

    timeoutTimer = timer
    RunLoop.main.add(timer, forMode: .common)
  }

  private static func invalidateTimeoutTimer() {
    timeoutTimer?.invalidate()
    timeoutTimer = nil
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

  public static func setTextFont(_ font: UIFont) {
    self.hudSetting.textFont = Font(font as CTFont)
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

    let mainWindow = UIApplication.shared.windows.first ?? UIWindow()
    mainWindow.isUserInteractionEnabled = hudSetting.isUserInteractionEnabled
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
