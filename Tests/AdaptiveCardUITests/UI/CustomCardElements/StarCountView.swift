#if canImport(SwiftUI)

    import AdaptiveCardUI
    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    struct StarCountView: View {
        @Environment(\.locale) private var locale
        @Environment(\.textStyle) private var textStyle
        @Environment(\.colorStyle) private var colorStyle
        @Environment(\.containerStyle) private var containerStyle

        private let starCount: StarCount

        init(_ starCount: StarCount) {
            self.starCount = starCount
        }

        var body: some View {
            HAlign(starCount.horizontalAlignment) {
                Label {
                    Text(formattedValue ?? "0")
                } icon: {
                    Image(systemName: "star")
                        .imageScale(.small)
                }
                .font(textStyle.font(.default, size: .default))
                .foregroundColor(colorStyle.textColor(.default, isSubtle: false, for: containerStyle))
            }
        }

        private var formattedValue: String? {
            let formatter = NumberFormatter()
            formatter.locale = locale
            formatter.numberStyle = .decimal

            return formatter.string(for: starCount.value)
        }
    }

#endif
