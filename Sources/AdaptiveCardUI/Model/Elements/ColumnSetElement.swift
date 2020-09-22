import Foundation

@dynamicMemberLookup
public indirect enum ColumnSetElement {
    case column(Column)
    case unknown(UnknownColumnSetElement)
}

extension ColumnSetElement: Equatable {}

extension ColumnSetElement: Codable {
    private enum CodingKeys: String, CodingKey {
        case type
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        switch type {
        case String(describing: Column.self):
            self = .column(try Column(from: decoder))
        default:
            self = .unknown(try UnknownColumnSetElement(from: decoder))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case let .column(element):
            try container.encode(String(describing: Column.self), forKey: .type)
            try element.encode(to: encoder)
        case .unknown:
            break // do nothing
        }
    }
}

public extension ColumnSetElement {
    subscript<T>(dynamicMember keyPath: KeyPath<ColumnSetElementProtocol, T>) -> T {
        switch self {
        case let .column(element):
            return element[keyPath: keyPath]
        case let .unknown(element):
            return element[keyPath: keyPath]
        }
    }
}
