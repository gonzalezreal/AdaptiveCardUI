#if canImport(SwiftUI)
    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension Color {
        /// Creates a color from an RGB or an ARGB hexadecimal string.
        init?(argbHex: String?) {
            guard let argbHex = argbHex else {
                return nil
            }

            let scanner = Scanner(string: argbHex)
            var value: UInt64 = 0

            guard scanner.scanString("#") != nil else { return nil }
            guard scanner.scanHexInt64(&value) else { return nil }

            let a, r, g, b: Double

            switch argbHex.count {
            case 7: a = 1
            case 9: a = Double((value & 0xFF00_0000) >> 24) / 255.0
            default: return nil
            }

            r = Double((value & 0x00FF_0000) >> 16) / 255.0
            g = Double((value & 0x0000_FF00) >> 8) / 255.0
            b = Double(value & 0x0000_00FF) / 255.0

            self.init(red: r, green: g, blue: b, opacity: a)
        }
    }
#endif
