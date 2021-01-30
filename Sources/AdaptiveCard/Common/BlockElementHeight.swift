import DefaultCodable
import Foundation

public enum BlockElementHeight: Codable, Equatable {
    /// The height of the element will be determined by the height of its contents.
    case auto

    /// The element will stretch its height to the available remaining height of the parent container.
    case stretch

    /// The fixed height for the element.
    case pixels(Int)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self).lowercased()

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

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        switch self {
        case .auto:
            try container.encode("auto")
        case .stretch:
            try container.encode("stretch")
        case let .pixels(value):
            try container.encode(PixelDimension(value: value))
        }
    }
}

extension BlockElementHeight: DefaultValueProvider {
    public static var `default` = BlockElementHeight.auto
}
