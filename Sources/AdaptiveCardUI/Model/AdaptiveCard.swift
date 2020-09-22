import DefaultCodable
import Foundation

public let adaptiveCardVersion = SemanticVersion(major: 1, minor: 3)

/// An Adaptive Card, containing a free-form body of card elements, and an optional set of actions.
public struct AdaptiveCard: Codable, Equatable {
    public var type: String = "AdaptiveCard"

    /// Schema version that this card requires. If a client is **lower** than this version, the `fallbackText` will be rendered.
    public var version: SemanticVersion?

    /// The card elements to show in the primary card region.
    @Default<Empty> public var body: [CardElement]

    /// The Actions to show in the card's action bar.
    @Default<Empty> public var actions: [Action]

    /// An action that will be invoked when the card is tapped or selected.
    public var selectAction: Action?

    /// Text shown when the client doesn't support the version specified (may contain markdown).
    @Default<Empty> public var fallbackText: String

    /// Specifies the background image of the card.
    public var backgroundImage: BackgroundImage?

    /// Specifies the minimum height of the card.
    public var minHeight: PixelDimension?

    /// Specifies what should be spoken for this entire card. This is simple text or SSML fragment.
    @Default<Empty> public var speak: String

    /// The 2-letter ISO-639-1 language used in the card. Used to localize any date/time functions.
    @Default<Empty> public var lang: String

    public init(
        version: SemanticVersion? = nil,
        body: [CardElement] = [],
        actions: [Action] = [],
        selectAction: Action? = nil,
        fallbackText: String = "",
        backgroundImage: BackgroundImage? = nil,
        minHeight: PixelDimension? = nil,
        speak: String = "",
        lang: String = ""
    ) {
        self.version = version
        self.body = body
        self.actions = actions
        self.selectAction = selectAction
        self.fallbackText = fallbackText
        self.backgroundImage = backgroundImage
        self.minHeight = minHeight
        self.speak = speak
        self.lang = lang
    }
}
