#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public struct TextColorPair: Equatable {
        /// Color to use when displaying default text.
        public let `default`: Color

        /// Color to use when displaying subtle text.
        public let subtle: Color

        public init(default: Color, subtle: Color) {
            self.default = `default`
            self.subtle = subtle
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension TextColorPair {
        static let `default` = TextColorPair(default: .primary, subtle: .secondary)

        static var dark: TextColorPair {
            #if os(macOS) || os(tvOS) || os(watchOS)
                return TextColorPair(default: .black, subtle: Color.black.subtle)
            #else
                return TextColorPair(default: Color(.darkText), subtle: Color(.darkText).subtle)
            #endif
        }

        static let light = TextColorPair(default: .white, subtle: Color.white.subtle)

        static let accent = TextColorPair(default: .accentColor, subtle: Color.accentColor.subtle)

        static let good = TextColorPair(default: .green, subtle: Color.green.subtle)

        static let warning = TextColorPair(default: .yellow, subtle: Color.yellow.subtle)

        static let attention = TextColorPair(default: .red, subtle: Color.red.subtle)
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension TextColorPair: Decodable {
        private enum CodingKeys: String, CodingKey {
            case `default`, subtle
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            `default` = (try Color(argbHex: container.decodeIfPresent(String.self, forKey: .default))) ?? .primary
            subtle = (try Color(argbHex: container.decodeIfPresent(String.self, forKey: .subtle))) ?? .secondary
        }
    }

#endif
