#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public struct SystemColorStyle: ContainerColorStyle {
        private enum Defaults {
            static let subtleOpacity = 0.5
        }

        public init() {}

        public func backgroundColor(for containerStyle: ContainerStyle) -> Color? {
            switch containerStyle {
            case .default, .good, .attention, .warning:
                return .background
            case .emphasis:
                return .secondaryBackground
            case .accent:
                return .accentColor
            default:
                return nil
            }
        }

        public func textColor(_ textColor: TextColor, isSubtle: Bool, for _: ContainerStyle) -> Color? {
            switch (textColor, isSubtle) {
            case (.dark, false):
                return Color.darkText
            case (.dark, true):
                return Color.darkText.opacity(Defaults.subtleOpacity)
            case (.light, false):
                return .white
            case (.light, true):
                return Color.white.opacity(Defaults.subtleOpacity)
            case (.accent, false):
                return .accentColor
            case (.accent, true):
                return Color.accentColor.opacity(Defaults.subtleOpacity)
            case (.good, false):
                return .green
            case (.good, true):
                return Color.green.opacity(Defaults.subtleOpacity)
            case (.warning, false):
                return .yellow
            case (.warning, true):
                return Color.yellow.opacity(Defaults.subtleOpacity)
            case (.attention, false):
                return .red
            case (.attention, true):
                return Color.red.opacity(Defaults.subtleOpacity)
            case (_, false):
                return .primary
            case (_, true):
                return .secondary
            }
        }
    }

    #if os(macOS)

        @available(macOS 10.15, *)
        private extension Color {
            static var background: Color {
                Color(.controlBackgroundColor)
            }

            static var secondaryBackground: Color {
                Color(.windowBackgroundColor)
            }

            static var darkText: Color {
                Color.black
            }
        }

    #elseif os(iOS)

        @available(iOS 13.0, *)
        private extension Color {
            static var background: Color {
                Color(.systemBackground)
            }

            static var secondaryBackground: Color {
                Color(.secondarySystemBackground)
            }

            static var darkText: Color {
                Color(.darkText)
            }
        }

    #elseif os(tvOS)

        @available(tvOS 13.0, *)
        private extension Color {
            static var background: Color {
                Color.clear
            }

            static var secondaryBackground: Color {
                Color.clear
            }

            static var darkText: Color {
                Color.black
            }
        }

    #elseif os(watchOS)

        @available(watchOS 6.0, *)
        private extension Color {
            static var background: Color {
                Color.black
            }

            static var secondaryBackground: Color {
                Color(.darkGray)
            }

            static var darkText: Color {
                Color.black
            }
        }

    #endif

#endif
