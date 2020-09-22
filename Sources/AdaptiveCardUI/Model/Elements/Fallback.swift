import DefaultCodable
import Foundation

/// Describes what to do when an unknown item is encountered or the requires of this or any children can't be met.
public enum Fallback<Element> {
    case none
    case drop
    case element(Element)
}

extension Fallback: Equatable where Element: Equatable {}

private enum Constants {
    static let drop = "drop"
}

extension Fallback: Codable where Element: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let fallbackOption = try? container.decode(String.self),
            fallbackOption.caseInsensitiveCompare(Constants.drop) == .orderedSame
        {
            self = .drop
        } else if let element = try? container.decode(Element.self) {
            self = .element(element)
        } else {
            self = .none
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        switch self {
        case .none:
            try container.encodeNil()
        case .drop:
            try container.encode(Constants.drop)
        case let .element(element):
            try container.encode(element)
        }
    }
}

extension Fallback where Element: Equatable & Codable {
    public enum None: DefaultValueProvider {
        public static var `default`: Fallback { .none }
    }
}
