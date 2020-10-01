import AdaptiveCardUI
import SwiftUI

struct SampleCardPreview: View {
    private enum Constants {
        static let cardCornerRadius: CGFloat = 4
        static let cardBorderColor = Color.primary.opacity(0.25)
        static let cardBorderWidth: CGFloat = 0.5
        static let maxCardWidth: CGFloat = 400
    }

    let resourceName: String

    var body: some View {
        if let url = Bundle.main.url(forResource: resourceName, withExtension: nil) {
            AdaptiveCardView(url: url)
                .clipShape(RoundedRectangle(cornerRadius: Constants.cardCornerRadius))
                .overlay(
                    RoundedRectangle(cornerRadius: Constants.cardCornerRadius)
                        .strokeBorder(Constants.cardBorderColor, lineWidth: Constants.cardBorderWidth)
                )
                .frame(maxWidth: Constants.maxCardWidth)
                .padding()
                .actionSetConfiguration(ActionSetConfiguration(actionsOrientation: .horizontal))
                .customCardElement { StarCountView($0) }
                .customCardElement { RepoLanguageView($0) }
                .onImageStyle(.default, apply: RoundedImageStyle())
                .buttonStyle(CapsuleButtonStyle())
                .animation(.default)
        }
    }
}

struct SampleCardPreview_Previews: PreviewProvider {
    static var previews: some View {
        SampleCardPreview(resourceName: SampleCard.activityUpdate.resourceName)
    }
}
