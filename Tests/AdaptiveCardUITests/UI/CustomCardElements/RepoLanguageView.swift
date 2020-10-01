#if canImport(SwiftUI)

    import AdaptiveCardUI
    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    struct RepoLanguageView: View {
        @Environment(\.fontTypeConfiguration) private var fontTypeConfiguration
        @Environment(\.containerStyleConfiguration) private var containerStyleConfiguration
        @Environment(\.containerStyle) private var containerStyle

        private let repoLanguage: RepoLanguage

        init(_ repoLanguage: RepoLanguage) {
            self.repoLanguage = repoLanguage
        }

        var body: some View {
            HAlign(repoLanguage.horizontalAlignment) {
                Label {
                    Text(repoLanguage.language)
                        .foregroundColor(
                            containerStyleConfiguration[containerStyle].textColors.default.default
                        )
                } icon: {
                    Image(systemName: "circle.fill")
                        .imageScale(.small)
                        .foregroundColor(Color(argbHex: repoLanguage.color))
                }
                .font(fontTypeConfiguration.default.default)
            }
        }
    }

#endif
