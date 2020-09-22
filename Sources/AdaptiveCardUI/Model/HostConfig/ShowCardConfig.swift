import DefaultCodable
import Foundation

/// Controls behavior and styling of `show` actions.
public struct ShowCardConfig: Codable, Equatable {
    public enum Defaults {
        public static let inlineTopMargin = 16
    }

    public enum ActionMode: String, CaseIterable, Codable {
        case inline, popup
    }

    /// Controls how the card is displayed.
    public var actionMode: ActionMode

    /// Indicates the initial container style for the card.
    public var style: ContainerStyle

    /// Amount of margin to use when displaying the card.
    public var inlineTopMargin: Int

    public init(
        actionMode: ActionMode = .inline,
        style: ContainerStyle = .emphasis,
        inlineTopMargin: Int = Defaults.inlineTopMargin
    ) {
        self.actionMode = actionMode
        self.style = style
        self.inlineTopMargin = inlineTopMargin
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        actionMode = try container.decodeIfPresent(ActionMode.self, forKey: .actionMode) ?? .inline
        style = try container.decodeIfPresent(ContainerStyle.self, forKey: .style) ?? .emphasis
        inlineTopMargin = try container.decodeIfPresent(Int.self, forKey: .inlineTopMargin) ?? Defaults.inlineTopMargin
    }
}

extension ShowCardConfig: DefaultValueProvider {
    public static var `default` = ShowCardConfig()
}
