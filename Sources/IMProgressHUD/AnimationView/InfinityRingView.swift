//
//  InfinityRingView.swift
//  imgbase-kit
//
//  Created by Dongbin Kim on 28/12/2022.
//  Copyright © 2022 ImgBase, Inc. All rights reserved.
//

import SwiftUI

internal struct InfinityRingView: View {
    @EnvironmentObject var hudSetting: HUDSetting

    @State private var isRotating = 0.0
    @State private var rotationSpeed = 0.9

    private var gradient: AngularGradient {
        AngularGradient(gradient: Gradient(colors: [hudSetting.foregroundColor, .clear]),
                                            center: .center,
                                            startAngle: .degrees(0),
                                            endAngle: .degrees(360))
    }

    var body: some View {
        Circle()
            .trim(from: 0, to: 1)
            .stroke(gradient, style: StrokeStyle(lineWidth: hudSetting.ringThickness, lineCap: .round))
            .rotationEffect(.degrees(isRotating))
            .onAppear() {
                withAnimation(.linear(duration: 1).speed(rotationSpeed).repeatForever(autoreverses: false)) {
                    isRotating = 360.0
                }
            }
    }
}
