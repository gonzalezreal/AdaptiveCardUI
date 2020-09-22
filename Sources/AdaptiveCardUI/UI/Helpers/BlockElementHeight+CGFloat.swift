#if canImport(SwiftUI)

    import SwiftUI

    extension BlockElementHeight {
        var cgFloatValue: CGFloat? {
            switch self {
            case .auto, .stretch:
                return nil
            case let .pixels(value):
                return CGFloat(value)
            }
        }
    }

#endif
