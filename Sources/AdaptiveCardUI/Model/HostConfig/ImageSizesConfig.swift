import DefaultCodable
import Foundation

/// Controls `Image` sizes.
public struct ImageSizesConfig: Codable, Equatable {
    public enum Defaults {
        public static let small = 40
        public static let medium = 80
        public static let large = 160
    }

    /// Small image size value
    public var small: Int

    /// Medium image size value
    public var medium: Int

    /// Large image size value
    public var large: Int

    public subscript(size: ImageSize) -> Int? {
        switch size {
        case .small: return small
        case .medium: return medium
        case .large: return large
        default: return nil
        }
    }

    public init(
        small: Int = Defaults.small,
        medium: Int = Defaults.medium,
        large: Int = Defaults.large
    ) {
        self.small = small
        self.medium = medium
        self.large = large
    }

    private enum CodingKeys: String, CodingKey {
        case small, medium, large
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        small = try container.decodeIfPresent(Int.self, forKey: .small) ?? Defaults.small
        medium = try container.decodeIfPresent(Int.self, forKey: .medium) ?? Defaults.medium
        large = try container.decodeIfPresent(Int.self, forKey: .large) ?? Defaults.large
    }
}

extension ImageSizesConfig: DefaultValueProvider {
    public static let `default` = ImageSizesConfig()
}
