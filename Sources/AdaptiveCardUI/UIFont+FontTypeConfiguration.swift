#if canImport(UIKit) && !os(watchOS)

    import AdaptiveCards
    import UIKit

    internal extension UIFont {
        static func preferredFont(
            forFontTypeConfiguration configuration: FontTypeConfiguration,
            size: FontSize,
            weight: FontWeight
        ) -> UIFont {
            let fontFamilyNames = configuration.fontFamily
                .split(separator: ",")
                .map { value in
                    value.trimmingCharacters(
                        in: CharacterSet.whitespaces.union(
                            .punctuationCharacters
                        )
                    )
                }
            let availableFontFamilyNames = Set(UIFont.familyNames)
            let family = fontFamilyNames.first { name in
                availableFontFamilyNames.contains { availableName in
                    availableName.caseInsensitiveCompare(name) == .orderedSame
                }
            }

            let font: UIFont

            if let family = family {
                let fontDescriptor = UIFontDescriptor(
                    fontAttributes: [
                        .family: family,
                        .traits: [
                            UIFontDescriptor.TraitKey.weight: Weight(weight),
                        ],
                    ]
                )
                font = UIFont(
                    descriptor: fontDescriptor,
                    size: configuration.pointSize(for: size)
                )
            } else {
                font = UIFont.systemFont(
                    ofSize: configuration.pointSize(for: size),
                    weight: Weight(weight)
                )
            }

            return UIFontMetrics.default.scaledFont(for: font)
        }

        @available(iOS 13.0, tvOS 13.0, *)
        static func preferredFont(
            forFontType fontType: FontType,
            size: FontSize,
            weight: FontWeight
        ) -> UIFont {
            let font: UIFont

            switch fontType {
            case .monospace:
                font = .monospacedSystemFont(ofSize: size.defaultPointSize, weight: Weight(weight))
            default:
                font = .systemFont(ofSize: size.defaultPointSize, weight: Weight(weight))
            }

            return UIFontMetrics.default.scaledFont(for: font)
        }
    }

    private extension UIFont.Weight {
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
