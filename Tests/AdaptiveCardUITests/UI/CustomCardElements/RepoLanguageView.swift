#if canImport(SwiftUI)

    import AdaptiveCardUI
    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    struct RepoLanguageView: View {
        @Environment(\.textStyle) private var textStyle
        @Environment(\.containerColorStyle) private var containerColorStyle
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
                            containerColorStyle.textColor(
                                .default,
                                isSubtle: false,
                                for: containerStyle
                            )
                        )
                } icon: {
                    Image(systemName: "circle.fill")
                        .imageScale(.small)
                        .foregroundColor(Color(argbHex: repoLanguage.color))
                }
                .font(textStyle.font(.default, size: .default))
            }
        }
    }

#endif
