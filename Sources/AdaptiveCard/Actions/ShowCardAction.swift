import DefaultCodable
import Foundation

/// Defines an AdaptiveCard which is shown to the user when the button or link is clicked.
public struct ShowCardAction: ActionProtocol, Codable, Equatable {
    /// The Adaptive Card to show.
    public var card: AdaptiveCard

    /// Label for button or link that represents this action.
    @Default<Empty> public var title: String

    /// Optional icon to be shown on the action in conjunction with the title.
    public var iconURL: URL?

    /// Controls the style of an Action, which influences how the action is displayed, spoken, etc.
    @Default<FirstCase> public var style: ActionStyle

    /// Describes what to do when an unknown action is encountered or the requires of this can’t be met.
    @Default<Fallback.None> public var fallback: Fallback<Action>

    /// A series of key/value pairs indicating features that the action requires with corresponding minimum version.
    /// When a feature is missing or of insufficient version, fallback is triggered.
    @Default<EmptyDictionary> public var requires: [String: SemanticVersion]

    public init(
        card: AdaptiveCard,
        title: String = "",
        iconURL: URL? = nil,
        style: ActionStyle = .default,
        fallback: Fallback<Action> = .none,
        requires: [String: SemanticVersion] = [:]
    ) {
        self.card = card
        self.title = title
        self.iconURL = iconURL
        self.style = style
        self.fallback = fallback
        self.requires = requires
    }
}
