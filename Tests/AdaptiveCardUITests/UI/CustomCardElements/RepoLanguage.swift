import AdaptiveCardUI
import DefaultCodable
import Foundation

struct RepoLanguage: CustomCardElement, Codable, Equatable {
    // MARK: - CustomCardElement

    @ItemIdentifier var id: String

    @Default<True> var isVisible: Bool

    @Default<False> var separator: Bool

    @Default<FirstCase> var spacing: Spacing

    @Default<Fallback.None> var fallback: Fallback<CardElement>

    @Default<EmptyDictionary> var requires: [String: SemanticVersion]

    // MARK: - RepoLanguage

    @Default<FirstCase> var horizontalAlignment: HorizontalAlignment

    var language: String

    var color: String
}
