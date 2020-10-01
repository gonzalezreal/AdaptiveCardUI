#if os(iOS) && canImport(SwiftUI)

    import AdaptiveCardUI
    import SwiftUI

    @available(iOS 13.0, *)
    extension TextColorConfiguration {
        static let test = TextColorConfiguration(
            default: TextColorPair(
                default: Color(argbHex: "#FF000000")!,
                subtle: Color(argbHex: "#B2000000")!
            ),
            accent: TextColorPair(
                default: Color(argbHex: "#FF0000FF")!,
                subtle: Color(argbHex: "#B20000FF")!
            ),
            dark: TextColorPair(
                default: Color(argbHex: "#FF101010")!,
                subtle: Color(argbHex: "#B2101010")!
            ),
            light: TextColorPair(
                default: Color(argbHex: "#FFFFFFFF")!,
                subtle: Color(argbHex: "#B2FFFFFF")!
            ),
            good: TextColorPair(
                default: Color(argbHex: "#FF008000")!,
                subtle: Color(argbHex: "#B2008000")!
            ),
            warning: TextColorPair(
                default: Color(argbHex: "#FFFFD700")!,
                subtle: Color(argbHex: "#B2FFD700")!
            ),
            attention: TextColorPair(
                default: Color(argbHex: "#FF8B0000")!,
                subtle: Color(argbHex: "#B28B0000")!
            )
        )

        static let alternateTest = TextColorConfiguration(
            default: TextColorPair(
                default: Color(argbHex: "#FF000000")!,
                subtle: Color(argbHex: "#B2000000")!
            ),
            accent: TextColorPair(
                default: Color(argbHex: "#FF0000FF")!,
                subtle: Color(argbHex: "#B20000FF")!
            ),
            dark: TextColorPair(
                default: Color(argbHex: "#FF101010")!,
                subtle: Color(argbHex: "#B2101010")!
            ),
            light: TextColorPair(
                default: Color(argbHex: "#FFFFFFFF")!,
                subtle: Color(argbHex: "#B2FFFFFF")!
            ),
            good: TextColorPair(
                default: Color(argbHex: "#FF008000")!,
                subtle: Color(argbHex: "#B2008000")!
            ),
            warning: TextColorPair(
                default: Color(argbHex: "#FFA60000")!,
                subtle: Color(argbHex: "#B2FFA600")!
            ),
            attention: TextColorPair(
                default: Color(argbHex: "#FF8B0000")!,
                subtle: Color(argbHex: "#B28B0000")!
            )
        )
    }

    @available(iOS 13.0, *)
    extension AdaptiveCardConfiguration {
        static let test = AdaptiveCardConfiguration(
            actions: ActionSetConfiguration(
                actionsOrientation: .horizontal,
                actionAlignment: .stretch,
                buttonSpacing: 10,
                spacing: .default,
                maxActions: 5,
                showCard: ShowCardConfiguration(
                    style: .emphasis,
                    inlineTopMargin: 16
                )
            ),
            containerStyles: ContainerStyleConfiguration(
                default: ContainerConfiguration(
                    backgroundColor: Color(argbHex: "#FFFFFFFF")!,
                    textColors: .test
                ),
                emphasis: ContainerConfiguration(
                    backgroundColor: Color(argbHex: "#08000000")!,
                    textColors: .test
                ),
                good: ContainerConfiguration(
                    backgroundColor: Color(argbHex: "#FFD5F0DD")!,
                    textColors: .alternateTest
                ),
                warning: ContainerConfiguration(
                    backgroundColor: Color(argbHex: "#F7F7DF")!,
                    textColors: .alternateTest
                ),
                attention: ContainerConfiguration(
                    backgroundColor: Color(argbHex: "#F7E9E9")!,
                    textColors: .alternateTest
                ),
                accent: ContainerConfiguration(
                    backgroundColor: Color(argbHex: "#DCE5F7")!,
                    textColors: .alternateTest
                )
            ),
            imageSizes: ImageSizeConfiguration(
                small: 40,
                medium: 80,
                large: 160
            ),
            factSet: FactSetConfiguration(
                title: TextBlockConfiguration(weight: .bold, maxWidth: 150),
                value: TextBlockConfiguration(),
                spacing: 10
            ),
            fonts: FontTypeConfiguration(
                default: FontConfiguration(
                    default: .system(size: 14),
                    small: .system(size: 12),
                    medium: .system(size: 17),
                    large: .system(size: 21),
                    extraLarge: .system(size: 26)
                ),
                monospace: FontConfiguration(
                    default: .system(size: 14, design: .monospaced),
                    small: .system(size: 12, design: .monospaced),
                    medium: .system(size: 17, design: .monospaced),
                    large: .system(size: 21, design: .monospaced),
                    extraLarge: .system(size: 26, design: .monospaced)
                )
            ),
            spacing: SpacingConfiguration(
                default: 8,
                small: 3,
                medium: 20,
                large: 30,
                extraLarge: 40,
                padding: 15
            )
        )
    }

#endif
