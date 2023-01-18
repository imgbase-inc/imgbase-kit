//
//  CGPoint+Addition.swift
//  imgbase-kit
//
//  Created by Dongbin Kim on 18/01/2023.
//  Copyright © 2023 ImgBase, Inc. All rights reserved.
//

import CoreGraphics

enum Orientation {
    case vertical, horizontal, none
}

enum Direction {
    case left, right, up, down, none
}

extension CGPoint {
    var direction: Direction {
        guard !(self.x == 0 && self.y == 0) else { return .none }

        if (abs(self.x) > abs(self.y) && self.x > 0) {
            return .right
        }
        else if (abs(self.x) > abs(self.y) && self.x <= 0) {
            return .left
        }

        else if (abs(self.x) <= abs(self.y) && self.y > 0) {
            return .up
        }

        else if (abs(self.x) <= abs(self.y) && self.y <= 0) {
            return .down
        }

        else {
            return .none
        }
    }

    var orientation: Orientation {
        guard self.direction != .none else { return .none }

        if self.direction == .left || self.direction == .right {
            return .horizontal
        } else {
            return .vertical
        }
    }
}
