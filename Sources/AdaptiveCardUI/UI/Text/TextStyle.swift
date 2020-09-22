#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *)
    public protocol TextStyle {
        func font(_ fontType: FontType, size: FontSize) -> Font
    }

#endif
