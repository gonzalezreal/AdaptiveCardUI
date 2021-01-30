import AnyValue
import Foundation

/// A card action, represented with a button when rendered.
@dynamicMemberLookup
public indirect enum Action {
    /// An action that opens a given URL.
    case openURL(OpenURLAction)

    /// An action that shows an inline card.
    case showCard(ShowCardAction)

    /// An action that gathers input fields, merges with an optional data field,
    /// and sends it to the client for further processing.
    case submit(SubmitAction)

    /// An action that toggles the visibility of associated card elements.
    case toggleVisibility(ToggleVisibilityAction)

    /// An unknown action. Unknown actions are discarded or replaced by
    /// their `fallback`, in case one is provided.
    case unknown(UnknownAction)
}

extension Action: Equatable {}

extension Action: Codable {
    private enum CodingKeys: String, CodingKey {
        case type
    }

    private enum ActionType: String, Codable {
        case openURL = "Action.OpenUrl"
        case showCard = "Action.ShowCard"
        case submit = "Action.Submit"
        case toggleVisibility = "Action.ToggleVisibility"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let type = try? container.decode(ActionType.self, forKey: .type) {
            switch type {
            case .openURL:
                self = try .openURL(OpenURLAction(from: decoder))
            case .showCard:
                self = try .showCard(ShowCardAction(from: decoder))
            case .submit:
                self = try .submit(SubmitAction(from: decoder))
            case .toggleVisibility:
                self = try .toggleVisibility(ToggleVisibilityAction(from: decoder))
            }
        } else {
            self = try .unknown(UnknownAction(from: decoder))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case let .openURL(action):
            try container.encode(ActionType.openURL, forKey: .type)
            try action.encode(to: encoder)
        case let .showCard(action):
            try container.encode(ActionType.showCard, forKey: .type)
            try action.encode(to: encoder)
        case let .submit(action):
            try container.encode(ActionType.submit, forKey: .type)
            try action.encode(to: encoder)
        case let .toggleVisibility(action):
            try container.encode(ActionType.toggleVisibility, forKey: .type)
            try action.encode(to: encoder)
        case .unknown:
            break // do nothing
        }
    }
}

public extension Action {
    subscript<T>(dynamicMember keyPath: KeyPath<ActionProtocol, T>) -> T {
        switch self {
        case let .openURL(action):
            return action[keyPath: keyPath]
        case let .showCard(action):
            return action[keyPath: keyPath]
        case let .submit(action):
            return action[keyPath: keyPath]
        case let .toggleVisibility(action):
            return action[keyPath: keyPath]
        case let .unknown(action):
            return action[keyPath: keyPath]
        }
    }
}
