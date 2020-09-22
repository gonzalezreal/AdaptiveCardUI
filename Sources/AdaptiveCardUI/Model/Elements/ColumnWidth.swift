import DefaultCodable
import Foundation

public enum ColumnWidth: Codable, Equatable {
    case auto
    case stretch
    case weight(Double)
    case pixels(Int)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let weight = try? container.decode(Double.self) {
            self = .weight(weight)
        } else {
            let value = try container.decode(String.self)

            if let weight = Double(value) {
                self = .weight(weight)
            } else {
                switch value {
                case "auto":
                    self = .auto
                case "stretch":
                    self = .stretch
                default:
                    let pixelDimension = try PixelDimension(from: decoder)
                    self = .pixels(pixelDimension.value)
                }
            }
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        switch self {
        case .auto:
            try container.encode("auto")
        case .stretch:
            try container.encode("stretch")
        case let .weight(value):
            try container.encode(value)
        case let .pixels(value):
            try container.encode(PixelDimension(value: value))
        }
    }
}

extension ColumnWidth: DefaultValueProvider {
    public static var `default` = ColumnWidth.stretch
}
