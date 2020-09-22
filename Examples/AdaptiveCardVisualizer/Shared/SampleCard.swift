import Foundation

struct SampleCard: Identifiable, Hashable {
    var id: String
    var title: String
    var resourceName: String
}

extension SampleCard {
    static let gitHubRepository = SampleCard(
        id: "GitHubRepository",
        title: "GitHub Repository",
        resourceName: "GitHubRepository.json"
    )

    static let activityUpdate = SampleCard(
        id: "ActivityUpdate",
        title: "Activity Update",
        resourceName: "ActivityUpdate.json"
    )

    static let flightItinerary = SampleCard(
        id: "FlightItinerary",
        title: "Flight Itinerary",
        resourceName: "FlightItinerary.json"
    )

    static let flightUpdate = SampleCard(
        id: "FlightUpdate",
        title: "Flight Update",
        resourceName: "FlightUpdate.json"
    )

    static let sportingEvent = SampleCard(
        id: "SportingEvent",
        title: "Sporting Event",
        resourceName: "SportingEvent.json"
    )

    static let stockUpdate = SampleCard(
        id: "StockUpdate",
        title: "Stock Update",
        resourceName: "StockUpdate.json"
    )

    static let weatherCompact = SampleCard(
        id: "WeatherCompact",
        title: "Weather Compact",
        resourceName: "WeatherCompact.json"
    )

    static let weatherLarge = SampleCard(
        id: "WeatherLarge",
        title: "Weather Large",
        resourceName: "WeatherLarge.json"
    )

    static let flightDetails = SampleCard(
        id: "FlightDetails",
        title: "Flight Details",
        resourceName: "FlightDetails.json"
    )

    static let all: [SampleCard] = [
        .gitHubRepository,
        .activityUpdate,
        .flightItinerary,
        .flightUpdate,
        .sportingEvent,
        .stockUpdate,
        .weatherCompact,
        .weatherLarge,
        .flightDetails,
    ]
}
