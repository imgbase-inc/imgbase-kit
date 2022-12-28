//
//  BlackBackgroundView.swift
//  imgbase-kit
//
//  Created by Dongbin Kim on 28/12/2022.
//  Copyright © 2022 ImgBase, Inc. All rights reserved.
//

import SwiftUI

internal struct BlackBackgroundView: View {
    @State private var opacity: Double = 0.2

    var body: some View {
        Color.black
            .opacity(opacity)
    }
}
