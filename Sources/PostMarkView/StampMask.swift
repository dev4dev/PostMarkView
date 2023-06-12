//
//  StampMask.swift
//  
//
//  Created by Alex Antonyuk on 12.06.2023.
//

import SwiftUI
import CoreFoundation

/// Generates a post mark mask path
public struct StampMask {
    let dotPattern: DottedPath
    let edges: [Edge]

    init(dotPattern: DottedPath, edges: [Edge]) {
        self.dotPattern = dotPattern
        self.edges = edges
    }

    /// Generate a path for a provided size
    /// - Parameter size: View size
    /// - Returns: Path
    func path(in size: CGSize) -> Path {
        var dots = Path()

        for edge in edges {
            switch edge {
            case .top:
                dots.addPath(dotPattern.path(direction: .horizontal, position: .leading, in: size))
            case .leading:
                dots.addPath(dotPattern.path(direction: .vertical, position: .leading, in: size))
            case .bottom:
                dots.addPath(dotPattern.path(direction: .horizontal, position: .trailing, in: size))
            case .trailing:
                dots.addPath(dotPattern.path(direction: .vertical, position: .trailing, in: size))
            }
        }

        let rect = Path(roundedRect: .init(origin: .zero, size: size), cornerSize: .zero)

        let cgDots = dots.cgPath
        let cgRect = rect.cgPath
        let sub = cgRect.subtracting(cgDots)

        return Path(sub)
    }
}
