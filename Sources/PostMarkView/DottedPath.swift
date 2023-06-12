//
//  DottedPath.swift
//  
//
//  Created by Alex Antonyuk on 12.06.2023.
//

import SwiftUI
import CoreFoundation

/// Allows to generate a Path with a sequence of dots of predefined size and a spacing among them
struct DottedPath {
    /// Directions of dots
    enum Direction {
        case vertical
        case horizontal
    }
    
    /// Placement of dots
    enum Position {
        case leading
        case trailing
    }
    let dotSize: CGFloat
    let spacing: CGFloat

    init(dotSize: CGFloat, spacing: CGFloat) {
        self.dotSize = max(dotSize, 1.0)
        self.spacing = spacing
    }

    private var ds: CGSize {
        .init(width: dotSize, height: dotSize)
    }
    private var dhs: CGFloat {
        dotSize / 2.0
    }

    func path(direction: Direction, position: Position, in size: CGSize) -> Path {
        Path { path in
            let height = direction == .vertical ? size.height : size.width
            var offset: CGFloat = .zero
            while offset < height {
                let origin: CGPoint = direction == .vertical
                ? .init(x: position == .leading ? -dhs : size.width - dhs, y: offset)
                : .init(x: offset, y: position == .leading ? -dhs : size.height - dhs)
                path.addEllipse(in: .init(origin: origin, size: ds))
                offset += dotSize + spacing
            }
        }
    }
}
