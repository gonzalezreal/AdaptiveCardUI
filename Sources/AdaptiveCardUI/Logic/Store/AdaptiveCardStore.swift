#if canImport(Combine)

    import AdaptiveCard
    import Combine
    import CombineSchedulers
    import Foundation
    import NetworkImage

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    final class AdaptiveCardStore {
        enum State: Equatable {
            case notRequested
            case loading
            case adaptiveCard(AdaptiveCard)
            case fallbackText(String)
            case failed
        }

        enum Action {
            case didSetURL(URL)
            case didLoadAdaptiveCard(AdaptiveCard)
            case didLoadImages(AdaptiveCard)
            case didFail
            case toggleVisibility([TargetElement])
        }

        struct Environment {
            let features: [String: SemanticVersion]
            let adaptiveCard: (URL) -> AnyPublisher<AdaptiveCard, Error>
            let images: (Set<URL>) -> AnyPublisher<Void, Error>
            let scheduler: AnySchedulerOf<DispatchQueue>

            init(
                features: [String: SemanticVersion],
                adaptiveCard: @escaping (URL) -> AnyPublisher<AdaptiveCard, Error> = AdaptiveCardDownloader.shared.adaptiveCard(for:),
                images: @escaping (Set<URL>) -> AnyPublisher<Void, Error> = ImageDownloader.shared.images(with:),
                scheduler: AnySchedulerOf<DispatchQueue> = DispatchQueue.main.eraseToAnyScheduler()
            ) {
                self.features = features
                self.adaptiveCard = adaptiveCard
                self.images = images
                self.scheduler = scheduler
            }
        }

        @Published private(set) var state: State = .notRequested

        private let environment: Environment
        private var cancellable: AnyCancellable?

        init(environment: Environment) {
            self.environment = environment
        }

        func send(_ action: Action) {
            switch action {
            case let .didSetURL(url):
                loadAdaptiveCard(url: url)
            case let .didLoadAdaptiveCard(adaptiveCard):
                switch adaptiveCard.version {
                case let .some(version) where version <= adaptiveCardVersion:
                    let featureAdaptedCard = adaptiveCard.adaptingToFeatures(environment.features)
                    let duplicateIdentifiers = featureAdaptedCard.duplicateIdentifiers
                    if duplicateIdentifiers.isEmpty {
                        loadAdaptiveCardImages(featureAdaptedCard)
                    } else {
                        NSLog(
                            "The adaptive card could not be rendered because it has duplicate identifiers: %@.",
                            duplicateIdentifiers.joined(separator: ", ")
                        )
                        state = .failed
                    }
                case let .some(version):
                    if adaptiveCard.fallbackText.isEmpty {
                        NSLog(
                            "The adaptive card could not be rendered. The specified version (%@) is greater than the currently supported version (%@).",
                            version.description,
                            adaptiveCardVersion.description
                        )
                        state = .failed
                    } else {
                        state = .fallbackText(adaptiveCard.fallbackText)
                    }
                case .none:
                    NSLog("The adaptive card could not be rendered because its version was not specified.")
                    state = .failed
                }
            case let .didLoadImages(adaptiveCard):
                state = .adaptiveCard(adaptiveCard)
            case .didFail:
                state = .failed
            case let .toggleVisibility(targetElements):
                toggleVisibility(of: targetElements)
            }
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private extension AdaptiveCardStore {
        func loadAdaptiveCard(url: URL) {
            state = .loading
            cancellable = environment.adaptiveCard(url)
                .map { .didLoadAdaptiveCard($0) }
                .handleEvents(
                    receiveCompletion: { completion in
                        guard case let .failure(error) = completion else { return }
                        NSLog("The adaptive card could not be loaded. %@", (error as NSError).localizedDescription)
                    }
                )
                .replaceError(with: .didFail)
                .receive(on: environment.scheduler)
                .sink { [weak self] action in
                    self?.send(action)
                }
        }

        func loadAdaptiveCardImages(_ adaptiveCard: AdaptiveCard) {
            state = .loading
            cancellable = environment.images(adaptiveCard.imageURLs)
                .map { .didLoadImages(adaptiveCard) }
                .handleEvents(
                    receiveCompletion: { completion in
                        guard case let .failure(error) = completion else { return }
                        NSLog("Could not load images from card. %@", (error as NSError).localizedDescription)
                    }
                )
                .replaceError(with: .didFail)
                .receive(on: environment.scheduler)
                .sink { [weak self] action in
                    self?.send(action)
                }
        }

        func toggleVisibility(of targetElements: [TargetElement]) {
            guard case var .adaptiveCard(adaptiveCard) = state else { return }
            adaptiveCard.toggleVisibility(of: targetElements)
            state = .adaptiveCard(adaptiveCard)
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension ImageDownloader {
        func images(with urls: Set<URL>) -> AnyPublisher<Void, Error> {
            guard !urls.isEmpty else {
                return Just(())
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }

            return Publishers.MergeMany(urls.map { image(for: $0) })
                .collect()
                .map { _ in () }
                .eraseToAnyPublisher()
        }
    }

#endif
