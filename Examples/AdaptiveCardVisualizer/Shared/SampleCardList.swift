import SwiftUI

struct SampleCardList: View {
    @State private var selection: SampleCard?

    let sampleCards: [SampleCard]

    var body: some View {
        List(selection: $selection) {
            ForEach(sampleCards) { sampleCard in
                NavigationLink(
                    destination: SampleCardView(sampleCard: sampleCard),
                    tag: sampleCard,
                    selection: $selection
                ) {
                    Text(sampleCard.title)
                }
                .tag(sampleCard)
            }
        }
        .navigationTitle("Adaptive Cards")
    }
}
