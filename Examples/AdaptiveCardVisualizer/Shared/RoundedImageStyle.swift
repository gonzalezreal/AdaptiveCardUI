import AdaptiveCardUI
import SwiftUI

struct RoundedImageStyle: CustomImageStyle {
    func makeBody(content: Content) -> some View {
        content.clipShape(RoundedRectangle(cornerRadius: 4))
    }
}
