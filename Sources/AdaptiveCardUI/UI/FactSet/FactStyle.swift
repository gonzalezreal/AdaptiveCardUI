#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *)
    public protocol FactStyle {
        var titleValueSpacing: CGFloat { get }

        func titleAttributes(for containerStyle: ContainerStyle) -> TextAttributes
        func valueAttributes(for containerStyle: ContainerStyle) -> TextAttributes
    }

#endif
