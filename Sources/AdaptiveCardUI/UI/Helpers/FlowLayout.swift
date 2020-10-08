#if canImport(SwiftUI)

    import SwiftUI

    // Adapted from https://gist.github.com/chriseidhof/3c6ea3fb2102052d1898d8ea27fbee07
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    struct FlowLayout {
        private let proposedSize: CGSize
        private let horizontalSpacing: CGFloat
        private let verticalSpacing: CGFloat

        private var position = CGPoint.zero
        private var lineHeight: CGFloat = 0

        var size: CGSize {
            CGSize(width: proposedSize.width, height: position.y + lineHeight)
        }

        init(proposedSize: CGSize, horizontalSpacing: CGFloat, verticalSpacing: CGFloat) {
            self.proposedSize = proposedSize
            self.horizontalSpacing = horizontalSpacing
            self.verticalSpacing = verticalSpacing
        }

        mutating func addElementWithSize(_ size: CGSize) -> CGRect {
            if position.x + size.width > proposedSize.width {
                position.x = 0
                position.y += lineHeight + verticalSpacing
                lineHeight = 0
            }

            let result = CGRect(origin: position, size: size)

            lineHeight = max(lineHeight, size.height)
            position.x += size.width + horizontalSpacing

            return result
        }
    }

#endif
