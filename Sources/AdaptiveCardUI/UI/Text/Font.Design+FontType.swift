#if canImport(SwiftUI)

    import AdaptiveCard
    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *)
    extension Font.Design {
        init(_ fontType: FontType) {
            switch fontType {
            case .monospace:
                self = .monospaced
            default:
                self = .default
            }
        }
    }

#endif
