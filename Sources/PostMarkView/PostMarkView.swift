// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

/// Post Mark View
public struct PostMarkView<BGS: ShapeStyle, V: View>: View {
    public let background: BGS
    public let content: () -> V
    let dotPattern: DottedPath
    let edges: [Edge]

    /// Initialize a view
    /// - Parameters:
    ///   - background: Background style
    ///   - dotSize: Dot Size
    ///   - dotSpacing: Dot Spacing
    ///   - edges: Edges with pattern
    ///   - content: Content View
    public init(background: BGS = Color.white, dotSize: CGFloat = 4.0, dotSpacing: CGFloat = 2, edges: [Edge] = Edge.allCases, content: @escaping () -> V) {
        self.background = background
        self.dotPattern = .init(dotSize: dotSize, spacing: dotSpacing)
        self.edges = edges
        self.content = content
    }

    public var body: some View {
        content()
            .background(background)
            .mask {
                GeometryReader { geometry in
                    StampMask(dotPattern: dotPattern, edges: edges).path(in: geometry.size)
                        .fill(.black)
                }
            }
    }
}

struct PostMaskView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hue: 0.57, saturation: 0.4, brightness: 0.6)
                .ignoresSafeArea()

            PostMarkView(dotSize: 4.0, dotSpacing: 2.0) {
                Text("Hello World")
                    .padding()
                    .background(.red)
                    .padding()
            }
            .shadow(radius: 10)
            .rotationEffect(.degrees(25))
        }
    }
}
