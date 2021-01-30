import Foundation

public struct SemanticVersion: Equatable {
    public let major: Int
    public let minor: Int
    public let patch: Int

    public init(major: Int, minor: Int = 0, patch: Int = 0) {
        self.major = major
        self.minor = minor
        self.patch = patch
    }
}

extension SemanticVersion: Comparable {
    public static func < (lhs: SemanticVersion, rhs: SemanticVersion) -> Bool {
        if lhs.major < rhs.major { return true }
        if lhs.major > rhs.major { return false }

        if lhs.minor < rhs.minor { return true }
        if lhs.minor > rhs.minor { return false }

        if lhs.patch < rhs.patch { return true }
        if lhs.patch > rhs.patch { return false }

        return false
    }
}

extension SemanticVersion: LosslessStringConvertible {
    public var description: String {
        if major == 0, minor == 0, patch == 0 {
            return Constants.any
        } else {
            return "\(major).\(minor).\(patch)"
        }
    }

    public init?(_ description: String) {
        guard let value = Self.parse(description) else {
            return nil
        }
        self = value
    }
}

extension SemanticVersion: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let versionString = try container.decode(String.self)

        guard let value = Self.parse(versionString) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid semantic version: \(versionString)"
            )
        }
        self = value
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(description)
    }
}

private extension SemanticVersion {
    private enum Constants {
        static let separator: Character = "."
        static let maxComponents = 3
        static let any = "*"
    }

    static func parse(_ versionString: String) -> SemanticVersion? {
        guard !versionString.isEmpty else { return nil }

        if versionString == Constants.any {
            return SemanticVersion(major: 0)
        } else {
            let components = versionString
                .split(separator: Constants.separator)
                .map { Int($0) }

            guard components.count <= Constants.maxComponents else {
                return nil
            }

            guard let major = components[0] else {
                return nil
            }

            guard let minor = components.count > 1 ? components[1] : 0 else {
                return nil
            }

            guard let patch = components.count > 2 ? components[2] : 0 else {
                return nil
            }

            return SemanticVersion(major: major, minor: minor, patch: patch)
        }
    }
}

public extension Dictionary where Value == SemanticVersion {
    func satisfies(_ other: Dictionary) -> Bool {
        for (key, requiredVersion) in other {
            guard let version = self[key], version >= requiredVersion else {
                return false
            }
        }
        return true
    }
}
