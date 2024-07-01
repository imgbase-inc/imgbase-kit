//
//  UIViewRepresented.swift
//  imgbase-kit
//
//  Created by Jeon Hyuncheol on 1/7/24.
//  Copyright © 2024 ImgBase, Inc. All rights reserved.
//

import SwiftUI

public struct UIViewRepresented<UIViewType: UIView>: UIViewRepresentable {
  let makeUIView: (Context) -> UIViewType
  let updateUIView: (UIViewType, Context) -> Void = { _, _ in }

  public func makeUIView(context: Context) -> UIViewType {
    self.makeUIView(context)
  }

  public func updateUIView(_ uiView: UIViewType, context: Context) {
    self.updateUIView(uiView, context)
  }
}
