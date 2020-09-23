#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *)
    public struct SystemTextStyle: TextStyle {
        public init() {}

        public func font(_ fontType: FontType, size: FontSize) -> Font {
            switch size {
            case .small:
                return .system(.footnote, design: Font.Design(fontType))
            case .medium:
                return .system(.body, design: Font.Design(fontType))
            case .large:
                if #available(macOS 11.0, iOS 14.0, tvOS 14.0, *) {
                    return .system(.title3, design: Font.Design(fontType))
                } else {
                    return .system(.title, design: Font.Design(fontType))
                }
            case .extraLarge:
                if #available(macOS 11.0, iOS 14.0, tvOS 14.0, *) {
                    return .system(.title, design: Font.Design(fontType))
                } else {
                    return .system(.largeTitle, design: Font.Design(fontType))
                }
            default:
                return .system(.callout, design: Font.Design(fontType))
            }
        }
    }

#endif
