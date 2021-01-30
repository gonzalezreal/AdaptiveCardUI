import AdaptiveCard
import Foundation

final class ImmediateAdaptiveCardCache: AdaptiveCardCache {
    private class AdaptiveCardBox {
        let value: AdaptiveCard

        init(value: AdaptiveCard) {
            self.value = value
        }
    }

    private let cache = NSCache<NSURL, AdaptiveCardBox>()

    func adaptiveCard(for url: URL) -> AdaptiveCard? {
        cache.object(forKey: url as NSURL)?.value
    }

    func setAdaptiveCard(_ adaptiveCard: AdaptiveCard, for url: URL) {
        cache.setObject(AdaptiveCardBox(value: adaptiveCard), forKey: url as NSURL)
    }
}
