import AdaptiveCardUI
import SwiftUI

@main
struct AdaptiveCardVisualizerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SampleCardList(sampleCards: SampleCard.all)
            }
            .onAppear {
                // Register custom elements
                CardElement.register(StarCount.self)
                CardElement.register(RepoLanguage.self)
            }
        }
    }
}
