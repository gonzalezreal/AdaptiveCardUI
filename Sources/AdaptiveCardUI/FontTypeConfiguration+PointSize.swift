#if canImport(CoreGraphics) && !os(watchOS)

    import AdaptiveCards
    import CoreGraphics

    internal extension FontTypeConfiguration {
        func pointSize(for fontSize: FontSize) -> CGFloat {
            fontSizes[fontSize].map(CGFloat.init) ?? fontSize.defaultPointSize
        }
    }

    internal extension FontSize {
        var defaultPointSize: CGFloat {
            switch self {
            case .small:
                return 12
            case .medium:
                return 17
            case .large:
                return 21
            case .extraLarge:
                return 26
            default:
                return 14
            }
        }
    }

#endif
