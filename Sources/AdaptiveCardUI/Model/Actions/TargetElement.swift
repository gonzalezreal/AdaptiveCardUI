import Foundation

/// Represents an entry for `Action.ToggleVisibility`'s targetElements property.
public struct TargetElement: Codable, Equatable {
    /// Element ID of element to toggle.
    public var elementId: String

    /// If `true`, always show target element. If `false`, always hide target element. If `nil`, toggle target element''s visibility.
    public var isVisible: Bool?

    public init(elementId: String, isVisible: Bool? = nil) {
        self.elementId = elementId
        self.isVisible = isVisible
    }

    private enum CodingKeys: String, CodingKey {
        case elementId, isVisible
    }

    public init(from decoder: Decoder) throws {
        let singleValueContainer = try decoder.singleValueContainer()

        if let elementId = try? singleValueContainer.decode(String.self) {
            self.init(elementId: elementId)
        } else {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            try self.init(
                elementId: container.decode(String.self, forKey: .elementId),
                isVisible: container.decodeIfPresent(Bool.self, forKey: .isVisible)
            )
        }
    }
}
