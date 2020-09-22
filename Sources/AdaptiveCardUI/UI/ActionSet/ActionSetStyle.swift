#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public struct ActionSetStyle {
        public enum Defaults {
            public static let spacing: CGFloat = 8
            public static let maxActions = 5
        }

        public let orientation: Axis
        public let alignment: AdaptiveCardUI.HorizontalAlignment?
        public let buttonSpacing: CGFloat
        public let spacing: Spacing
        public let maxActions: Int
        public let cardStyle: ContainerStyle
        public let cardTopMargin: CGFloat

        internal var maxButtonWidth: CGFloat? {
            switch alignment {
            case .none:
                return .infinity
            case .some:
                return nil
            }
        }

        public init(
            orientation: Axis = .vertical,
            alignment: AdaptiveCardUI.HorizontalAlignment? = nil,
            buttonSpacing: CGFloat = Defaults.spacing,
            spacing: Spacing = .default,
            maxActions: Int = Defaults.maxActions,
            cardStyle: ContainerStyle = .emphasis,
            cardTopMargin: CGFloat = Defaults.spacing
        ) {
            self.orientation = orientation
            self.alignment = alignment
            self.buttonSpacing = buttonSpacing
            self.spacing = spacing
            self.maxActions = maxActions
            self.cardStyle = cardStyle
            self.cardTopMargin = cardTopMargin
        }

        public init(hostConfig: HostConfig) {
            orientation = Axis(hostConfig.actions.actionsOrientation)
            alignment = AdaptiveCardUI.HorizontalAlignment(hostConfig.actions.actionAlignment)
            buttonSpacing = CGFloat(hostConfig.actions.buttonSpacing)
            spacing = hostConfig.actions.spacing
            maxActions = hostConfig.actions.maxActions
            cardStyle = hostConfig.actions.showCard.style
            cardTopMargin = CGFloat(hostConfig.actions.showCard.inlineTopMargin)
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private extension Axis {
        init(_ orientation: ActionsConfig.Orientation) {
            switch orientation {
            case .horizontal:
                self = .horizontal
            case .vertical:
                self = .vertical
            }
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private extension AdaptiveCardUI.HorizontalAlignment {
        init?(_ alignment: ActionsConfig.Alignment) {
            switch alignment {
            case .stretch:
                return nil
            case .left:
                self = .left
            case .center:
                self = .center
            case .right:
                self = .right
            }
        }
    }

#endif
