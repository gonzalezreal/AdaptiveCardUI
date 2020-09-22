#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    struct ErrorView: View {
        @Environment(\.locale) private var locale
        @Environment(\.textStyle) private var textStyle
        @Environment(\.spacingStyle) private var spacingStyle
        @Environment(\.colorStyle) private var colorStyle
        @Environment(\.imageSizeStyle) private var imageSizeStyle

        private let text: String

        init(text: String) {
            self.text = text
        }

        var body: some View {
            VStack(spacing: spacingStyle.medium) {
                SwiftUI.Image(systemName: "rectangle.badge.xmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageSizeStyle.small)
                    .foregroundColor(
                        colorStyle.textColor(
                            .default,
                            isSubtle: true,
                            for: .emphasis
                        )
                    )
                Text(parsing: text, locale: locale)
                    .font(textStyle.font(.default, size: .default))
                    .foregroundColor(
                        colorStyle.textColor(
                            .default,
                            isSubtle: true,
                            for: .emphasis
                        )
                    )
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(spacingStyle.padding)
            .background(colorStyle.backgroundColor(for: .emphasis))
        }
    }

#endif
