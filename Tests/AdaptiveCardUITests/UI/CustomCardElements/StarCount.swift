import AdaptiveCardUI
import DefaultCodable
import Foundation

struct StarCount: CustomCardElement, Codable, Equatable {
    // MARK: - CustomCardElement

    @ItemIdentifier var id: String

    @Default<True> var isVisible: Bool

    @Default<False> var separator: Bool

    @Default<FirstCase> var spacing: Spacing

    @Default<Fallback.None> var fallback: Fallback<CardElement>

    @Default<EmptyDictionary> var requires: [String: SemanticVersion]

    // MARK: - StartCount

    @Default<FirstCase> var horizontalAlignment: HAlignment

    var value: Int
}
