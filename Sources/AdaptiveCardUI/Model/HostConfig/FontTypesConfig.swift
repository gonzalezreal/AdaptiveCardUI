import DefaultCodable
import Foundation

public struct FontTypesConfig: Codable, Equatable {
    @Default<FontStyleConfig> public var `default`: FontStyleConfig

    @Default<FontStyleConfig> public var monospace: FontStyleConfig

    public subscript(fontType: FontType) -> FontStyleConfig {
        switch fontType {
        case .monospace: return monospace
        default: return `default`
        }
    }

    public init(
        default: FontStyleConfig = FontStyleConfig(),
        monospace: FontStyleConfig = FontStyleConfig()
    ) {
        self.default = `default`
        self.monospace = monospace
    }
}

extension FontTypesConfig: DefaultValueProvider {
    public static let `default` = FontTypesConfig()
}
