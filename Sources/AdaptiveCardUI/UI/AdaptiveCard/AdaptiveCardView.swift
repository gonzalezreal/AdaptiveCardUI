#if canImport(SwiftUI)

    import AdaptiveCard
    import SwiftUI

    /// A view that displays an adaptive card.
    ///
    /// You can create an adaptive card view by providing the URL where the adaptive card is located.
    ///
    ///     AdaptiveCardView(url: URL(string: "https://adaptivecards.io/payloads/ActivityUpdate.json")!)
    ///
    /// Or by providing a previously fetched adaptive card.
    ///
    ///     AdaptiveCardView(response.adaptiveCard)
    ///
    /// Before displaying the card, the view checks that its version is supported and downloads
    /// its content asynchronously.
    ///
    /// ## Customizing Appearance
    ///
    /// You can customize an adaptive card's appearance by providing a configuration. An adaptive card
    /// configuration is a set of values that specify how the library renders the different
    /// elements. To set a specific configuration for all the adaptive cards within a view, use the
    /// `adaptiveCardConfiguration(_:)` modifier:
    ///
    ///     VStack {
    ///         AdaptiveCardView(url: URL(string: "https://adaptivecards.io/payloads/ActivityUpdate.json")!)
    ///         AdaptiveCardView(response.adaptiveCard)
    ///     }
    ///     .adaptiveCardConfiguration(myConfiguration)
    ///
    /// Alternatively, you can customize only a specific aspect of an adaptive card's appearance, like
    /// the actions or the different spacing values. Use one of the following modifiers to customize a
    /// specific aspect of all the adaptive cards within a view:
    ///
    /// * `actionSetConfiguration(_:)` to customize the appearance of the adaptive card actions.
    /// * `containerStyleConfiguration(_:)` to customize the colors of the different container styles.
    /// * `factSetConfiguration(_:)` to customize the appearance of the fact set elements.
    /// * `imageSizeConfiguration(_:)` to provide custom values for the different image size cases.
    /// * `spacingConfiguration(_:)` to provide custom values for the different spacing cases.
    /// * `fontTypeConfiguration(_:)` to provide custom fonts for the different font types and sizes.
    ///
    /// ## Custom Elements
    ///
    /// Adaptive cards are extensible, so you can add your own elements and the views that display them.
    ///
    /// As an example, imagine that we are designing a card to present the summary of a GitHub repo.
    /// One of the elements is the repo language, which GitHub represents with a circle filled with a given
    /// color, next to the language name. The JSON representation of the element could look like this:
    ///
    ///     {
    ///       "type": "RepoLanguage",
    ///       "horizontalAlignment": "center",
    ///       "language": "Swift",
    ///       "color": "#ffac45"
    ///     }
    ///
    /// We have omitted inherited optional properties like `"id"`, `"isVisible"`, `"spacing"`,
    /// `"separator"`, etc. But you will need to support them, nevertheless.
    ///
    /// To add this new element, you need to create a type that conforms to `CustomCardElement`,
    /// `Codable`, and `Equatable`:
    ///
    ///     struct RepoLanguage: CustomCardElement, Codable, Equatable {
    ///         // CustomCardElement
    ///
    ///         @ItemIdentifier var id: String
    ///         @Default<True> var isVisible: Bool
    ///         @Default<False> var separator: Bool
    ///         @Default<FirstCase> var spacing: Spacing
    ///         @Default<Fallback.None> var fallback: Fallback<CardElement>
    ///         @Default<EmptyDictionary> var requires: [String: SemanticVersion]
    ///
    ///         // RepoLanguage
    ///
    ///         @Default<FirstCase> var horizontalAlignment: HAlignment
    ///         var language: String
    ///         var color: String
    ///     }
    ///
    /// In case you are wondering, the `Default` property wrapper lets you provide default values for
    /// JSON properties that are not required, removing much of the boilerplate. See
    /// [DefaultCodable](https://github.com/gonzalezreal/DefaultCodable) for more
    /// information.
    ///
    /// As the new element conforms to `CustomCardElement`, you can add it to the body of an adaptive
    /// card, a container, or a column in a column set. It will have a spacing relative to the previous element
    /// and an optional separator. Besides that, you can provide a fallback element for those clients that still
    /// don't support it.
    ///
    /// Notice that you will need to register the new element before any adaptive card decoding happens:
    ///
    ///     CardElement.register(RepoLanguage.self)
    ///
    /// You can create the view that renders the new element as any other SwiftUI view:
    ///
    ///     struct RepoLanguageView: View {
    ///         var repoLanguage: RepoLanguage
    ///
    ///         var body: some View {
    ///             HAlign(repoLanguage.horizontalAlignment) {
    ///                 Label {
    ///                     Text(repoLanguage.language)
    ///                 } icon: {
    ///                     Image(systemName: "circle.fill")
    ///                         .imageScale(.small)
    ///                         .foregroundColor(Color(argbHex: repoLanguage.color))
    ///                 }
    ///             }
    ///         }
    ///     }
    ///
    /// Finally, to associate the new element and its view to all the adaptive card views within a view hierarchy,
    /// use the `customCardElement(_:, content:)` modifier:
    ///
    ///     VStack {
    ///         AdaptiveCardView(url: URL(string: "https://adaptivecards.io/payloads/ActivityUpdate.json")!)
    ///         AdaptiveCardView(response.adaptiveCard)
    ///     }
    ///     .customCardElement(RepoLanguage.self) {
    ///         RepoLanguageView($0)
    ///     }
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    public struct AdaptiveCardView: View {
        @Environment(\.adaptiveCardFeatures) private var features

        private let source: AdaptiveCardSource

        public init(url: URL) {
            source = .url(url)
        }

        public init(_ adaptiveCard: AdaptiveCard) {
            source = .value(adaptiveCard)
        }

        public var body: some View {
            AdaptiveCardSourceView(source: source, features: features)
        }
    }

#endif
