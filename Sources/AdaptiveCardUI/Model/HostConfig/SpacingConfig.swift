import DefaultCodable
import Foundation

/// Specifies how much spacing should be used for the various spacing options.
public struct SpacingConfig: Codable, Equatable {
    /// Small spacing value
    public var small: Int

    /// Default spacing value
    public var `default`: Int

    /// Medium spacing value
    public var medium: Int

    /// Large spacing value
    public var large: Int

    /// Extra large spacing value
    public var extraLarge: Int

    /// Padding value
    public var padding: Int

    public subscript(spacing: Spacing) -> Int {
        switch spacing {
        case .small: return small
        case .medium: return medium
        case .large: return large
        case .extraLarge: return extraLarge
        case .padding: return padding
        case .none: return 0
        default: return `default`
        }
    }

    public init(
        small: Int = Spacing.small.defaultValue,
        default: Int = Spacing.default.defaultValue,
        medium: Int = Spacing.medium.defaultValue,
        large: Int = Spacing.large.defaultValue,
        extraLarge: Int = Spacing.extraLarge.defaultValue,
        padding: Int = Spacing.padding.defaultValue
    ) {
        self.small = small
        self.default = `default`
        self.medium = medium
        self.large = large
        self.extraLarge = extraLarge
        self.padding = padding
    }

    private enum CodingKeys: String, CodingKey {
        case small, `default`, medium, large, extraLarge, padding
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        small = try container.decodeIfPresent(Int.self, forKey: .small) ?? Spacing.small.defaultValue
        `default` = try container.decodeIfPresent(Int.self, forKey: .default) ?? Spacing.default.defaultValue
        medium = try container.decodeIfPresent(Int.self, forKey: .medium) ?? Spacing.medium.defaultValue
        large = try container.decodeIfPresent(Int.self, forKey: .large) ?? Spacing.large.defaultValue
        extraLarge = try container.decodeIfPresent(Int.self, forKey: .extraLarge) ?? Spacing.extraLarge.defaultValue
        padding = try container.decodeIfPresent(Int.self, forKey: .padding) ?? Spacing.padding.defaultValue
    }
}

extension SpacingConfig: DefaultValueProvider {
    public static let `default` = SpacingConfig()
}

public extension Spacing {
    var defaultValue: Int {
        switch self {
        case .none: return 0
        case .small: return 3
        case .medium: return 20
        case .large: return 30
        case .extraLarge: return 40
        case .padding: return 15
        default: return 8
        }
    }
}
