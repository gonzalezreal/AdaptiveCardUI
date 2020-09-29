#if canImport(SwiftUI)

    import Combine
    import SwiftUI

    enum AdaptiveCardSource {
        case url(URL)
        case value(AdaptiveCard)
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension AdaptiveCardStore: ObservableObject {}

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension AdaptiveCardStore {
        convenience init(source: AdaptiveCardSource, features: [String: SemanticVersion]) {
            self.init(environment: Environment(features: features))

            switch source {
            case let .url(url):
                send(.didSetURL(url))
            case let .value(value):
                send(.didLoadAdaptiveCard(value))
            }
        }
    }

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    struct AdaptiveCardSourceView: View {
        @StateObject private var store: AdaptiveCardStore

        init(source: AdaptiveCardSource, features: [String: SemanticVersion]) {
            _store = StateObject(
                wrappedValue: AdaptiveCardStore(
                    source: source,
                    features: features
                )
            )
        }

        var body: some View {
            switch store.state {
            case .notRequested, .loading:
                EmptyView()
            case let .adaptiveCard(adaptiveCard):
                PrimitiveCardView(adaptiveCard)
                    .environmentObject(store)
            case let .fallbackText(text):
                ErrorView(text: text)
            case .failed:
                ErrorView(text: NSLocalizedString("Error.render", bundle: .module, comment: ""))
            }
        }
    }

#endif
