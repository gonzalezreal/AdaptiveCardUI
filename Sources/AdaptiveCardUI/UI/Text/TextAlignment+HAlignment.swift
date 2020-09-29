#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension TextAlignment {
        init(_ horizontalAlignment: HAlignment) {
            switch horizontalAlignment {
            case .center:
                self = .center
            case .right:
                self = .trailing
            default:
                self = .leading
            }
        }
    }

#endif
