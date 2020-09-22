import Foundation

@propertyWrapper
public struct ItemIdentifier: Codable, Equatable {
    public var wrappedValue: String

    public init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if container.decodeNil() {
            wrappedValue = UUID().uuidString
        } else {
            wrappedValue = try container.decode(String.self)
        }
    }
}

public extension KeyedDecodingContainer {
    func decode(_: ItemIdentifier.Type, forKey key: Key) throws -> ItemIdentifier {
        if let value = try decodeIfPresent(ItemIdentifier.self, forKey: key) {
            return value
        } else {
            return ItemIdentifier(wrappedValue: UUID().uuidString)
        }
    }
}

public extension KeyedEncodingContainer {
    mutating func encode(_ value: ItemIdentifier, forKey key: Key) throws {
        guard !value.wrappedValue.isEmpty else { return }
        try encode(value.wrappedValue, forKey: key)
    }
}
