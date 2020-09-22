#if canImport(SwiftUI)

    import SwiftUI

    extension PixelDimension {
        var cgFloatValue: CGFloat {
            CGFloat(value)
        }
    }

#endif
