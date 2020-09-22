import DefaultCodable
import Foundation

/// Controls font size metrics for different text styles.
public struct FontSizesConfig: Codable, Equatable {
    /// Small font size
    public var small: Int

    /// Default font size
    public var `default`: Int

    /// Medium font size
    public var medium: Int

    /// Large font size
    public var large: Int

    /// Extra large font size
    public var extraLarge: Int

    public subscript(size: FontSize) -> Int {
        switch size {
        case .small: return small
        case .medium: return medium
        case .large: return large
        case .extraLarge: return extraLarge
        default: return `default`
        }
    }

    public init(
        small: Int = FontSize.small.defaultValue,
        default: Int = FontSize.default.defaultValue,
        medium: Int = FontSize.medium.defaultValue,
        large: Int = FontSize.large.defaultValue,
        extraLarge: Int = FontSize.extraLarge.defaultValue
    ) {
        self.small = small
        self.default = `default`
        self.medium = medium
        self.large = large
        self.extraLarge = extraLarge
    }

    private enum CodingKeys: String, CodingKey {
        case small, `default`, medium, large, extraLarge
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        small = try container.decodeIfPresent(Int.self, forKey: .small) ?? FontSize.small.defaultValue
        `default` = try container.decodeIfPresent(Int.self, forKey: .default) ?? FontSize.default.defaultValue
        medium = try container.decodeIfPresent(Int.self, forKey: .medium) ?? FontSize.medium.defaultValue
        large = try container.decodeIfPresent(Int.self, forKey: .large) ?? FontSize.large.defaultValue
        extraLarge = try container.decodeIfPresent(Int.self, forKey: .extraLarge) ?? FontSize.extraLarge.defaultValue
    }
}

extension FontSizesConfig: DefaultValueProvider {
    public static let `default` = FontSizesConfig()
}

public extension FontSize {
    var defaultValue: Int {
        switch self {
        case .small: return 12
        case .medium: return 17
        case .large: return 21
        case .extraLarge: return 26
        default: return 14
        }
    }
}
