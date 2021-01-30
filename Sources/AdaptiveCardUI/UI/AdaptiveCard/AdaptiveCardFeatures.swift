#if canImport(SwiftUI)

    import AdaptiveCard
    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension View {
        /// Sets the supported features for adaptive cards within this view.
        func adaptiveCardFeatures(_ features: [String: SemanticVersion]) -> some View {
            environment(\.adaptiveCardFeatures, features)
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension EnvironmentValues {
        /// The adaptive card supported features of this environment.
        var adaptiveCardFeatures: [String: SemanticVersion] {
            get { self[AdaptiveCardFeaturesKey.self] }
            set {
                self[AdaptiveCardFeaturesKey.self] = newValue
                    .merging(AdaptiveCardFeaturesKey.defaultValue) { _, b in b }
            }
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private struct AdaptiveCardFeaturesKey: EnvironmentKey {
        enum Constants {
            static let adaptiveCardFeature = "adaptiveCards"
        }

        static let defaultValue: [String: SemanticVersion] = [
            Constants.adaptiveCardFeature: adaptiveCardVersion,
        ]
    }

#endif
