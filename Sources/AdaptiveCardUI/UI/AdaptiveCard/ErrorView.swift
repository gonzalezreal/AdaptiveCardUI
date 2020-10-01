#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    struct ErrorView: View {
        @Environment(\.locale) private var locale
        @Environment(\.fontTypeConfiguration) private var fontTypeConfiguration
        @Environment(\.spacingConfiguration) private var spacingConfiguration
        @Environment(\.containerStyleConfiguration) private var containerStyleConfiguration
        @Environment(\.imageSizeConfiguration) private var imageSizeConfiguration

        private let text: String

        init(text: String) {
            self.text = text
        }

        var body: some View {
            VStack(spacing: spacingConfiguration.medium) {
                SwiftUI.Image(systemName: "rectangle.badge.xmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageSizeConfiguration.small)
                    .foregroundColor(containerStyleConfiguration.emphasis.textColors.default.subtle)
                Text(parsing: text, locale: locale)
                    .font(fontTypeConfiguration.default.default)
                    .foregroundColor(
                        containerStyleConfiguration.emphasis.textColors.default.subtle
                    )
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(spacingConfiguration.padding)
            .background(containerStyleConfiguration.emphasis.backgroundColor)
        }
    }

#endif
