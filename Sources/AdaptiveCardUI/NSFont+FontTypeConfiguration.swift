#if os(macOS)

    import AdaptiveCards
    import AppKit

    internal extension NSFont {
        static func preferredFont(
            forFontTypeConfiguration configuration: FontTypeConfiguration,
            size: FontSize,
            weight: FontWeight
        ) -> NSFont {
            let fontFamilyNames = configuration.fontFamily
                .split(separator: ",")
                .map { value in
                    value.trimmingCharacters(
                        in: CharacterSet.whitespaces.union(
                            .punctuationCharacters
                        )
                    )
                }
            let availableFontFamilyNames = Set(NSFontManager.shared.availableFontFamilies)
            let family = fontFamilyNames.first { name in
                availableFontFamilyNames.contains { availableName in
                    availableName.caseInsensitiveCompare(name) == .orderedSame
                }
            }

            return family.flatMap { family in
                NSFont(
                    descriptor: NSFontDescriptor(
                        fontAttributes: [
                            .family: family,
                            .traits: [
                                NSFontDescriptor.TraitKey.weight: Weight(weight),
                            ],
                        ]
                    ),
                    size: configuration.pointSize(for: size)
                )
            } ?? .systemFont(
                ofSize: configuration.pointSize(for: size),
                weight: Weight(weight)
            )
        }

        @available(macOS 10.15, *)
        static func preferredFont(
            forFontType fontType: FontType,
            size: FontSize,
            weight: FontWeight
        ) -> NSFont {
            switch fontType {
            case .monospace:
                return .monospacedSystemFont(ofSize: size.defaultPointSize, weight: Weight(weight))
            default:
                return .systemFont(ofSize: size.defaultPointSize, weight: Weight(weight))
            }
        }
    }

    private extension NSFont.Weight {
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
