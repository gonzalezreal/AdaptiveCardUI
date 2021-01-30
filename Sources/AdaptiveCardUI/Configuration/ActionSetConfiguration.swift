#if canImport(SwiftUI)

    import AdaptiveCard
    import SwiftUI

    /// A set of values that control the appearance of action sets inside adaptive cards.
    ///
    /// To set the action set configuration for a view hierarchy, use the `actionSetConfiguration(_:)`
    /// modifier and specify an instance of this type.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public struct ActionSetConfiguration: Equatable {
        public enum Orientation: String, Decodable {
            case horizontal, vertical
        }

        public enum Alignment: String, Decodable {
            case stretch, left, center, right
        }

        /// The orientation of the buttons in the action set.
        public let actionsOrientation: Orientation

        /// Controls how buttons are aligned.
        public let actionAlignment: Alignment

        /// The spacing between buttons.
        public let buttonSpacing: CGFloat

        /// The spacing between the actions and the card body elements.
        public let spacing: Spacing

        /// The maximum number of actions allowed.
        public let maxActions: Int

        /// Controls behavior and styling of `showCard` actions.
        public let showCard: ShowCardConfiguration

        public init(
            actionsOrientation: Orientation = .vertical,
            actionAlignment: Alignment = .stretch,
            buttonSpacing: CGFloat = 8,
            spacing: Spacing = .default,
            maxActions: Int = 5,
            showCard: ShowCardConfiguration = .default
        ) {
            self.actionsOrientation = actionsOrientation
            self.actionAlignment = actionAlignment
            self.buttonSpacing = buttonSpacing
            self.spacing = spacing
            self.maxActions = maxActions
            self.showCard = showCard
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension ActionSetConfiguration {
        static let `default` = ActionSetConfiguration()
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension ActionSetConfiguration: Decodable {
        private enum CodingKeys: String, CodingKey {
            case actionsOrientation, actionAlignment
            case buttonSpacing, spacing
            case maxActions, showCard
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            actionsOrientation = try container.decodeIfPresent(Orientation.self, forKey: .actionsOrientation) ?? Self.default.actionsOrientation
            actionAlignment = try container.decodeIfPresent(Alignment.self, forKey: .actionAlignment) ?? Self.default.actionAlignment
            buttonSpacing = try container.decodeIfPresent(CGFloat.self, forKey: .buttonSpacing) ?? Self.default.buttonSpacing
            spacing = try container.decodeIfPresent(Spacing.self, forKey: .spacing) ?? Self.default.spacing
            maxActions = try container.decodeIfPresent(Int.self, forKey: .maxActions) ?? Self.default.maxActions
            showCard = try container.decodeIfPresent(ShowCardConfiguration.self, forKey: .showCard) ?? Self.default.showCard
        }
    }

#endif
