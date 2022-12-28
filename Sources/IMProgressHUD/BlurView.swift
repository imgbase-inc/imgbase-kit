//
//  BlurView.swift
//  imgbase-kit
//
//  Created by Dongbin Kim on 28/12/2022.
//  Copyright © 2022 ImgBase, Inc. All rights reserved.
//

import SwiftUI

internal struct BlurView: View {
    private struct BackdropView: UIViewRepresentable {
        func makeUIView(context: Context) -> UIVisualEffectView {
            let view = UIVisualEffectView()
            let blur = UIBlurEffect(style: .extraLight)
            let animator = UIViewPropertyAnimator()
            animator.addAnimations { view.effect = blur }
            animator.fractionComplete = 0
            animator.stopAnimation(true)
            animator.finishAnimation(at: .start)
            return view
        }

        func updateUIView(_ uiView: UIVisualEffectView, context: Context) { }
    }

    var body: some View {
        BackdropView().blur(radius: 2)
    }
}

