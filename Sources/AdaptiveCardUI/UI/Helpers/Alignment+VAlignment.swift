#if canImport(SwiftUI)

    import AdaptiveCard
    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension Alignment {
        init(_ verticalAlignment: VAlignment) {
            switch verticalAlignment {
            case .center:
                self = .center
            case .bottom:
                self = .bottom
            default:
                self = .top
            }
        }
    }

#endif
