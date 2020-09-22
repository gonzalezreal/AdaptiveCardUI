#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public struct TextAttributes {
        public let font: Font
        public let weight: Font.Weight
        public let textColor: Color?
        public let wrap: Bool
        public let maxWidth: CGFloat?

        public init(
            font: Font,
            weight: Font.Weight,
            textColor: Color?,
            wrap: Bool,
            maxWidth: CGFloat?
        ) {
            self.font = font
            self.weight = weight
            self.textColor = textColor
            self.wrap = wrap
            self.maxWidth = maxWidth
        }
    }

#endif
