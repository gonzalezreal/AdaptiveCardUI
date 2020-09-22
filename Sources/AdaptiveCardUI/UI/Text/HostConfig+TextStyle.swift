#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *)
    extension HostConfig: TextStyle {
        public func font(_ fontType: FontType, size: FontSize) -> Font {
            let fontTypeConfig = fontTypes[fontType]
            let pointSize = CGFloat(fontTypeConfig.fontSizes[size])

            guard let name = fontTypeConfig.firstFontFamilyName(in: availableFontFamilies()) else {
                return .system(size: pointSize, design: Font.Design(fontType))
            }

            return Font.custom(name, size: pointSize)
        }
    }

    private func availableFontFamilies() -> Set<String> {
        #if canImport(UIKit)
            return Set(UIFont.familyNames)
        #elseif os(macOS)
            return Set(NSFontManager.shared.availableFontFamilies)
        #endif
    }

#endif
