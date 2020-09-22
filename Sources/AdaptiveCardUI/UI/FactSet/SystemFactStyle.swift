#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public struct SystemFactStyle: FactStyle {
        public enum Defaults {
            public static let maxTitleWidth: CGFloat = 132
            public static let titleValueSpacing: CGFloat = 8
        }

        public let maxTitleWidth: CGFloat
        public let titleValueSpacing: CGFloat

        public init(
            maxTitleWidth: CGFloat = Defaults.maxTitleWidth,
            titleValueSpacing: CGFloat = Defaults.titleValueSpacing
        ) {
            self.maxTitleWidth = maxTitleWidth
            self.titleValueSpacing = titleValueSpacing
        }

        public func titleAttributes(for _: ContainerStyle) -> TextAttributes {
            TextAttributes(
                font: .system(.callout),
                weight: .bold,
                textColor: .primary,
                wrap: true,
                maxWidth: maxTitleWidth
            )
        }

        public func valueAttributes(for _: ContainerStyle) -> TextAttributes {
            TextAttributes(
                font: .system(.callout),
                weight: .regular,
                textColor: .primary,
                wrap: true,
                maxWidth: nil
            )
        }
    }

#endif
