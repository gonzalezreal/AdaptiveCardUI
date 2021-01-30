import Foundation

public struct PixelDimension: Codable, Equatable {
    public var value: Int

    public init(value: Int) {
        self.value = value
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)

        let scanner = Scanner(string: stringValue)
        var value = 0

        guard scanner.scanInt(&value) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid pixel dimension: \(stringValue)"
            )
        }

        self.value = value
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode("\(value)px")
    }
}

extension PixelDimension: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(value: value)
    }
}
