#if canImport(SwiftUI)

    import AdaptiveCard
    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension Font.Weight {
        init(_ fontWeight: FontWeight) {
            switch fontWeight {
            case .light:
                self = .light
            case .bold:
                self = .bold
            default:
                self = .regular
            }
        }
    }

#endif
