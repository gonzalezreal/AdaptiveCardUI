#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    struct ContainerView: View {
        @Environment(\.colorStyle) private var colorStyle
        @Environment(\.spacingStyle) private var spacingStyle
        @Environment(\.containerStyle) private var parentContainerStyle

        private let container: Container

        private var padding: CGFloat {
            if container.backgroundImage != nil {
                return spacingStyle.padding
            } else {
                switch (container.style, parentContainerStyle) {
                case (.none, _), (ContainerStyle.default, ContainerStyle.default):
                    return 0
                case (.some, _):
                    return spacingStyle.padding
                }
            }
        }

        private var backgroundColor: Color? {
            container.style.flatMap {
                colorStyle.backgroundColor(for: $0)
            }
        }

        init(_ container: Container) {
            self.container = container
        }

        var body: some View {
            CardElementList(container.items, padding: padding)
                .containerStyle(container.style)
                .frame(
                    minHeight: container.minHeight?.cgFloatValue,
                    alignment: Alignment(container.verticalContentAlignment)
                )
                .backgroundImage(container.backgroundImage)
                .background(backgroundColor)
                .selectAction(container.selectAction)
        }
    }

#endif
