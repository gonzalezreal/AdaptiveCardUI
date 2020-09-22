#if canImport(Combine)

    import Combine
    import CombineSchedulers
    import XCTest

    @testable import AdaptiveCardUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    final class AdaptiveCardStoreTests: XCTestCase {
        enum Fixtures {
            static let anyURL = URL(string: "https://example.com/anyCard.json")!
            static let anyOtherURL = URL(string: "https://example.com/anyOtherCard.json")!
            static let anyAdaptiveCard = AdaptiveCard(version: adaptiveCardVersion)
            static let unsupportedCard = AdaptiveCard(version: SemanticVersion(major: 99))
            static let unsupportedCardWithFallback = AdaptiveCard(
                version: SemanticVersion(major: 99),
                fallbackText: "Fallback"
            )
            static let cardWithDuplicateId = AdaptiveCard(
                version: adaptiveCardVersion,
                body: [
                    .textBlock(TextBlock(id: "1", text: "test")),
                    .textBlock(TextBlock(id: "1", text: "test")),
                ]
            )
            static let anyError = NSError(domain: "test", code: 42, userInfo: nil)
        }

        private let scheduler = DispatchQueue.testScheduler
        private var cancellables = Set<AnyCancellable>()

        override func tearDownWithError() throws {
            cancellables.removeAll()
        }

        func testDidSetURL() throws {
            // given
            let sut = AdaptiveCardStore(
                environment: AdaptiveCardStore.Environment(
                    features: [:],
                    adaptiveCard: successfulAdaptiveCard(Fixtures.anyAdaptiveCard),
                    images: successfulImages,
                    scheduler: scheduler.eraseToAnyScheduler()
                )
            )
            var result: [AdaptiveCardStore.State] = []

            sut.$state
                .sink { result.append($0) }
                .store(in: &cancellables)

            // when
            sut.send(.didSetURL(Fixtures.anyURL))
            sut.send(.didSetURL(Fixtures.anyOtherURL))
            scheduler.run()

            // then
            XCTAssertEqual(
                [
                    .notRequested,
                    .loading,
                    .loading,
                    .loading,
                    .adaptiveCard(Fixtures.anyAdaptiveCard),
                ],
                result
            )
        }

        func testCouldNotLoadCard() {
            // given
            let sut = AdaptiveCardStore(
                environment: AdaptiveCardStore.Environment(
                    features: [:],
                    adaptiveCard: failedAdaptiveCard,
                    images: successfulImages,
                    scheduler: scheduler.eraseToAnyScheduler()
                )
            )
            var result: [AdaptiveCardStore.State] = []

            sut.$state
                .sink { result.append($0) }
                .store(in: &cancellables)

            // when
            sut.send(.didSetURL(Fixtures.anyURL))
            scheduler.run()

            // then
            XCTAssertEqual(
                [
                    .notRequested,
                    .loading,
                    .failed,
                ],
                result
            )
        }

        func testCouldNotLoadImages() {
            // given
            let sut = AdaptiveCardStore(
                environment: AdaptiveCardStore.Environment(
                    features: [:],
                    adaptiveCard: successfulAdaptiveCard(Fixtures.anyAdaptiveCard),
                    images: failedImages,
                    scheduler: scheduler.eraseToAnyScheduler()
                )
            )
            var result: [AdaptiveCardStore.State] = []

            sut.$state
                .sink { result.append($0) }
                .store(in: &cancellables)

            // when
            sut.send(.didSetURL(Fixtures.anyURL))
            scheduler.run()

            // then
            XCTAssertEqual(
                [
                    .notRequested,
                    .loading,
                    .loading,
                    .failed,
                ],
                result
            )
        }

        func testVersionNotSpecified() {
            // given
            let sut = AdaptiveCardStore(
                environment: AdaptiveCardStore.Environment(
                    features: [:],
                    adaptiveCard: successfulAdaptiveCard(AdaptiveCard()),
                    images: successfulImages,
                    scheduler: scheduler.eraseToAnyScheduler()
                )
            )
            var result: [AdaptiveCardStore.State] = []

            sut.$state
                .sink { result.append($0) }
                .store(in: &cancellables)

            // when
            sut.send(.didSetURL(Fixtures.anyURL))
            scheduler.run()

            // then
            XCTAssertEqual(
                [
                    .notRequested,
                    .loading,
                    .failed,
                ],
                result
            )
        }

        func testUnsupportedVersion() {
            // given
            let sut = AdaptiveCardStore(
                environment: AdaptiveCardStore.Environment(
                    features: [:],
                    adaptiveCard: successfulAdaptiveCard(Fixtures.unsupportedCard),
                    images: successfulImages,
                    scheduler: scheduler.eraseToAnyScheduler()
                )
            )
            var result: [AdaptiveCardStore.State] = []

            sut.$state
                .sink { result.append($0) }
                .store(in: &cancellables)

            // when
            sut.send(.didSetURL(Fixtures.anyURL))
            scheduler.run()

            // then
            XCTAssertEqual(
                [
                    .notRequested,
                    .loading,
                    .failed,
                ],
                result
            )
        }

        func testDuplicateIdentifiers() {
            // given
            let sut = AdaptiveCardStore(
                environment: AdaptiveCardStore.Environment(
                    features: [:],
                    adaptiveCard: successfulAdaptiveCard(Fixtures.cardWithDuplicateId),
                    images: successfulImages,
                    scheduler: scheduler.eraseToAnyScheduler()
                )
            )
            var result: [AdaptiveCardStore.State] = []

            sut.$state
                .sink { result.append($0) }
                .store(in: &cancellables)

            // when
            sut.send(.didSetURL(Fixtures.anyURL))
            scheduler.run()

            // then
            XCTAssertEqual(
                [
                    .notRequested,
                    .loading,
                    .failed,
                ],
                result
            )
        }

        func testFallbackText() {
            // given
            let sut = AdaptiveCardStore(
                environment: AdaptiveCardStore.Environment(
                    features: [:],
                    adaptiveCard: successfulAdaptiveCard(Fixtures.unsupportedCardWithFallback),
                    images: successfulImages,
                    scheduler: scheduler.eraseToAnyScheduler()
                )
            )
            var result: [AdaptiveCardStore.State] = []

            sut.$state
                .sink { result.append($0) }
                .store(in: &cancellables)

            // when
            sut.send(.didSetURL(Fixtures.anyURL))
            scheduler.run()

            // then
            XCTAssertEqual(
                [
                    .notRequested,
                    .loading,
                    .fallbackText(Fixtures.unsupportedCardWithFallback.fallbackText),
                ],
                result
            )
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private extension AdaptiveCardStoreTests {
        func successfulAdaptiveCard(_ adaptiveCard: AdaptiveCard) -> (URL) -> AnyPublisher<AdaptiveCard, Error> {
            { _ in
                Just(adaptiveCard)
                    .delay(for: .seconds(1), scheduler: self.scheduler)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
        }

        var failedAdaptiveCard: (URL) -> AnyPublisher<AdaptiveCard, Error> {
            { _ in
                Fail(error: Fixtures.anyError)
                    .delay(for: .seconds(1), scheduler: self.scheduler)
                    .eraseToAnyPublisher()
            }
        }

        var successfulImages: (Set<URL>) -> AnyPublisher<Void, Error> {
            { _ in
                Just(())
                    .delay(for: .seconds(1), scheduler: self.scheduler)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
        }

        var failedImages: (Set<URL>) -> AnyPublisher<Void, Error> {
            { _ in
                Fail(error: Fixtures.anyError)
                    .delay(for: .seconds(1), scheduler: self.scheduler)
                    .eraseToAnyPublisher()
            }
        }
    }

#endif
