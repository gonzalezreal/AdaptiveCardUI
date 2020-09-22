import Foundation

public protocol ActionProtocol {
    /// Label for button or link that represents this action.
    var title: String { get }

    /// Optional icon to be shown on the action in conjunction with the title.
    var iconURL: URL? { get }

    /// Controls the style of an Action, which influences how the action is displayed, spoken, etc.
    var style: ActionStyle { get }

    /// Describes what to do when an unknown action is encountered or the requires of this can’t be met.
    var fallback: Fallback<Action> { get }

    /// A series of key/value pairs indicating features that the action requires with corresponding minimum version.
    /// When a feature is missing or of insufficient version, fallback is triggered.
    var requires: [String: SemanticVersion] { get }
}
