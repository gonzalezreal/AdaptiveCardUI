#if canImport(SwiftUI)

    import SwiftUI

    /// A style that applies a custom appearance to all action set elements within a view hierarchy.
    ///
    /// To configure the current action set style for a view hierarchy, use the `actionSetStyle(_:)`
    /// modifier and specify an instance of this type.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public struct ActionSetStyle {
        public enum Defaults {
            public static let spacing: CGFloat = 8
            public static let maxActions = 5
        }

        /// The orientation of the buttons in the action set.
        public let orientation: Axis

        /// The horizontal alignment of the buttons in the action set.
        public let alignment: HAlignment?

        /// The spacing between buttons.
        public let buttonSpacing: CGFloat

        /// The spacing between the actions and the card body elements.
        public let spacing: Spacing

        /// The maximum number of actions allowed.
        public let maxActions: Int

        /// The initial container style for a card in a `showCard` action.
        public let cardStyle: ContainerStyle

        /// The top margin used when displaying a card in a `showCard` action.
        public let cardTopMargin: CGFloat

        internal var maxButtonWidth: CGFloat? {
            switch alignment {
            case .none:
                return .infinity
            case .some:
                return nil
            }
        }

        /// Creates an action set style.
        public init(
            orientation: Axis = .vertical,
            alignment: HAlignment? = nil,
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

        /// Creates an action set style from a `HostConfig` value.
        public init(hostConfig: HostConfig) {
            orientation = Axis(hostConfig.actions.actionsOrientation)
            alignment = HAlignment(hostConfig.actions.actionAlignment)
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
    private extension HAlignment {
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
