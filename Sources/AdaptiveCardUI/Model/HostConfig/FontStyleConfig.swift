import DefaultCodable
import Foundation

public struct FontStyleConfig: Codable, Equatable {
    @Default<Empty> public var fontFamily: String

    @Default<FontSizesConfig> public var fontSizes: FontSizesConfig

    public var fontFamilyNames: [String] {
        fontFamily
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: CharacterSet.whitespaces.union(.punctuationCharacters)) }
    }

    public init(
        fontFamily: String = "",
        fontSizes: FontSizesConfig = FontSizesConfig()
    ) {
        self.fontFamily = fontFamily
        self.fontSizes = fontSizes
    }

    public func firstFontFamilyName(in availableFontFamilyNames: Set<String>) -> String? {
        fontFamilyNames.first { name in
            availableFontFamilyNames.contains { availableName in
                availableName.caseInsensitiveCompare(name) == .orderedSame
            }
        }
    }
}

extension FontStyleConfig: DefaultValueProvider {
    public static let `default` = FontStyleConfig()
}
