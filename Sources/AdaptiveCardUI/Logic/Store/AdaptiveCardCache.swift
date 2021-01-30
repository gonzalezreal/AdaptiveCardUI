import AdaptiveCard
import Foundation

protocol AdaptiveCardCache: AnyObject {
    func adaptiveCard(for url: URL) -> AdaptiveCard?
    func setAdaptiveCard(_ adaptiveCard: AdaptiveCard, for url: URL)
}
