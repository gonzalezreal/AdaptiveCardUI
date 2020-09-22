#if canImport(Combine)

    import Combine
    import Foundation

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    final class AdaptiveCardDownloader {
        private let session: URLSession
        private let adaptiveCardCache: AdaptiveCardCache

        static let shared = AdaptiveCardDownloader(
            session: URLSession(configuration: .default),
            adaptiveCardCache: ImmediateAdaptiveCardCache()
        )

        init(session: URLSession, adaptiveCardCache: AdaptiveCardCache) {
            self.session = session
            self.adaptiveCardCache = adaptiveCardCache
        }

        func adaptiveCard(for url: URL) -> AnyPublisher<AdaptiveCard, Error> {
            if let adaptiveCard = adaptiveCardCache.adaptiveCard(for: url) {
                return Just(adaptiveCard)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } else {
                return session.dataTaskPublisher(for: url)
                    .map(\.data)
                    .decode(type: AdaptiveCard.self, decoder: JSONDecoder())
                    .handleEvents(receiveOutput: { [adaptiveCardCache] adaptiveCard in
                        adaptiveCardCache.setAdaptiveCard(adaptiveCard, for: url)
                    })
                    .eraseToAnyPublisher()
            }
        }
    }

#endif
