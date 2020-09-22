import DefaultCodable
import Foundation

public struct ActionsConfig: Codable, Equatable {
    public enum Defaults {
        public static let buttonSpacing = 10
        public static let maxActions = 5
        public static let iconSize = 30
    }

    public enum Orientation: String, CaseIterable, Codable {
        case horizontal, vertical
    }

    public enum Alignment: String, CaseIterable, Codable {
        case stretch, left, center, right
    }

    public enum IconPlacement: String, CaseIterable, Codable {
        case leftOfTitle, aboveTitle
    }

    /// Controls how buttons are laid out.
    public var actionsOrientation: Orientation

    /// Controls how buttons are aligned.
    public var actionAlignment: Alignment

    /// Controls how much spacing to use between buttons.
    public var buttonSpacing: Int

    /// Controls how many actions are allowed in total.
    public var maxActions: Int

    /// Controls overall spacing of action element.
    public var spacing: Spacing

    /// Controls behavior and styling of `show` actions.
    public var showCard: ShowCardConfig

    /// Controls where to place the action icon.
    public var iconPlacement: IconPlacement

    /// Controls the size of action icon.
    public var iconSize: Int

    public init(
        actionsOrientation: Orientation = .horizontal,
        actionAlignment: Alignment = .stretch,
        buttonSpacing: Int = Defaults.buttonSpacing,
        maxActions: Int = Defaults.maxActions,
        spacing: Spacing = .default,
        showCard: ShowCardConfig = .default,
        iconPlacement: IconPlacement = .leftOfTitle,
        iconSize: Int = Defaults.iconSize
    ) {
        self.actionsOrientation = actionsOrientation
        self.actionAlignment = actionAlignment
        self.buttonSpacing = buttonSpacing
        self.maxActions = maxActions
        self.spacing = spacing
        self.showCard = showCard
        self.iconPlacement = iconPlacement
        self.iconSize = iconSize
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        actionsOrientation = try container.decodeIfPresent(Orientation.self, forKey: .actionsOrientation) ?? .horizontal
        actionAlignment = try container.decodeIfPresent(Alignment.self, forKey: .actionAlignment) ?? .stretch
        buttonSpacing = try container.decodeIfPresent(Int.self, forKey: .buttonSpacing) ?? Defaults.buttonSpacing
        maxActions = try container.decodeIfPresent(Int.self, forKey: .maxActions) ?? Defaults.maxActions
        spacing = try container.decodeIfPresent(Spacing.self, forKey: .spacing) ?? .default
        showCard = try container.decodeIfPresent(ShowCardConfig.self, forKey: .showCard) ?? .default
        iconPlacement = try container.decodeIfPresent(IconPlacement.self, forKey: .iconPlacement) ?? .leftOfTitle
        iconSize = try container.decodeIfPresent(Int.self, forKey: .iconSize) ?? Defaults.iconSize
    }
}

extension ActionsConfig: DefaultValueProvider {
    public static let `default` = ActionsConfig()
}
