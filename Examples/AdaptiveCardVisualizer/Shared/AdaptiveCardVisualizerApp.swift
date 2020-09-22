import SwiftUI

@main
struct AdaptiveCardVisualizerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SampleCardList(sampleCards: SampleCard.all)
            }
        }
    }
}
