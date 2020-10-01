#if canImport(SwiftUI)

    import SwiftUI

    /// A font configuration specifies a font for each different font size.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public struct FontConfiguration: Equatable {
        /// Default font.
        public let `default`: Font

        /// Small font.
        public let small: Font

        /// Medium font.
        public let medium: Font

        /// Large font.
        public let large: Font

        /// Extra large font.
        public let extraLarge: Font

        public init(
            default: Font,
            small: Font,
            medium: Font,
            large: Font,
            extraLarge: Font
        ) {
            self.default = `default`
            self.small = small
            self.medium = medium
            self.large = large
            self.extraLarge = extraLarge
        }

        public subscript(size: FontSize) -> Font {
            switch size {
            case .small:
                return small
            case .medium:
                return medium
            case .large:
                return large
            case .extraLarge:
                return extraLarge
            default:
                return `default`
            }
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension FontConfiguration {
        static var `default`: FontConfiguration {
            if #available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *) {
                return .default2
            } else {
                return .default1
            }
        }

        static var monospace: FontConfiguration {
            if #available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *) {
                return .monospace2
            } else if #available(watchOS 7.0, *) {
                return .monospace1
            } else {
                return .default1
            }
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private extension FontConfiguration {
        static let default1 = FontConfiguration(
            default: .callout,
            small: .footnote,
            medium: .body,
            large: .title,
            extraLarge: .largeTitle
        )

        @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
        static let default2 = FontConfiguration(
            default: .callout,
            small: .footnote,
            medium: .body,
            large: .title3,
            extraLarge: .title
        )

        @available(watchOS 7.0, *)
        static let monospace1 = FontConfiguration(
            default: .system(.callout, design: .monospaced),
            small: .system(.footnote, design: .monospaced),
            medium: .system(.body, design: .monospaced),
            large: .system(.title, design: .monospaced),
            extraLarge: .system(.largeTitle, design: .monospaced)
        )

        @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
        static let monospace2 = FontConfiguration(
            default: .system(.callout, design: .monospaced),
            small: .system(.footnote, design: .monospaced),
            medium: .system(.body, design: .monospaced),
            large: .system(.title3, design: .monospaced),
            extraLarge: .system(.title, design: .monospaced)
        )
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension FontConfiguration: Decodable {
        public init(from decoder: Decoder) throws {
            try self.init(PrimitiveFontConfiguration(from: decoder))
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private extension FontConfiguration {
        init(_ primitiveValue: PrimitiveFontConfiguration) {
            func availableFontFamilies() -> Set<String> {
                #if canImport(UIKit)
                    return Set(UIFont.familyNames)
                #elseif os(macOS)
                    return Set(NSFontManager.shared.availableFontFamilies)
                #endif
            }

            func font(_ name: String?, _ size: CGFloat) -> Font {
                guard let name = name else {
                    return .system(size: size)
                }
                return .custom(name, size: size)
            }

            let fontFamilyNames = primitiveValue.fontFamily
                .split(separator: ",")
                .map { $0.trimmingCharacters(in: CharacterSet.whitespaces.union(.punctuationCharacters)) }
            let availableFontFamilyNames = availableFontFamilies()
            let name = fontFamilyNames.first { name in
                availableFontFamilyNames.contains { availableName in
                    availableName.caseInsensitiveCompare(name) == .orderedSame
                }
            }

            `default` = font(name, primitiveValue.fontSizes.default)
            small = font(name, primitiveValue.fontSizes.small)
            medium = font(name, primitiveValue.fontSizes.medium)
            large = font(name, primitiveValue.fontSizes.large)
            extraLarge = font(name, primitiveValue.fontSizes.extraLarge)
        }
    }

    private struct PrimitiveFontConfiguration: Decodable {
        struct Sizes: Decodable {
            let `default`: CGFloat
            let small: CGFloat
            let medium: CGFloat
            let large: CGFloat
            let extraLarge: CGFloat

            static let `default` = Sizes(
                default: 14,
                small: 12,
                medium: 17,
                large: 21,
                extraLarge: 26
            )

            init(
                default: CGFloat,
                small: CGFloat,
                medium: CGFloat,
                large: CGFloat,
                extraLarge: CGFloat
            ) {
                self.default = `default`
                self.small = small
                self.medium = medium
                self.large = large
                self.extraLarge = extraLarge
            }

            enum CodingKeys: String, CodingKey {
                case `default`, small, medium, large, extraLarge
            }

            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)

                `default` = try container.decodeIfPresent(CGFloat.self, forKey: .default) ?? Self.default.default
                small = try container.decodeIfPresent(CGFloat.self, forKey: .small) ?? Self.default.small
                medium = try container.decodeIfPresent(CGFloat.self, forKey: .medium) ?? Self.default.medium
                large = try container.decodeIfPresent(CGFloat.self, forKey: .large) ?? Self.default.large
                extraLarge = try container.decodeIfPresent(CGFloat.self, forKey: .extraLarge) ?? Self.default.extraLarge
            }
        }

        let fontFamily: String
        let fontSizes: Sizes

        enum CodingKeys: String, CodingKey {
            case fontFamily, fontSizes
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            fontFamily = try container.decodeIfPresent(String.self, forKey: .fontFamily) ?? ""
            fontSizes = try container.decodeIfPresent(Sizes.self, forKey: .fontSizes) ?? .default
        }
    }

#endif
