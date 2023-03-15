//
//  BookListModel.swift
//  BookTableViewApp
//
//  Created by Paolo Cifuentes on 8/25/21.
//

import Foundation

struct Books: Codable {
    var kind: String?
    var id: String?
    var etag: String?
    var selfLink: String?
    var volumeInfo: VolumeInfo?
    var saleInfo: SaleInfo?
    var accessInfo: AccessInfo?
    var searchInfo: SearchInfo?

    enum CodingKeys: String, CodingKey {
        case kind
        case id
        case etag
        case selfLink
        case volumeInfo
        case saleInfo
        case accessInfo
        case searchInfo
    }
}

struct VolumeInfo: Codable {
    var title: String?
    var subTitle: String?
    var authors: [String]?
    var publisher: String?
    var publishedDate: String?
    var description: String?
    var industryIdentifiers: [IndustryIdentifier]?
    var readingModes: ReadingModes?
    var pageCount: Int?
    var printType: String?
    var categories: [String]?
    var averageRating: Double?
    var ratingCount: Int?
    var maturityRating: String?
    var allowAnonLogging: Bool
    var contentVerions: String?
    var panelizationSummary: PanelizationSummary?
    var imageLinks: ImageLinks?
    var language: String?
    var previewLink: String?
    var infoLink: String?
    var canonicalVolumeLink: String?

    enum CodingKeys: String, CodingKey {
        case title
        case subTitle = "subtitle"
        case authors
        case publisher
        case publishedDate
        case description
        case industryIdentifiers
        case readingModes
        case pageCount
        case printType
        case categories
        case averageRating
        case ratingCount
        case maturityRating
        case allowAnonLogging
        case contentVerions
        case panelizationSummary
        case imageLinks
        case language
        case previewLink
        case infoLink
        case canonicalVolumeLink
    }
}

struct IndustryIdentifier: Codable {
    var type: String?
    var identifier: String?

    enum CodingKeys: String, CodingKey {
        case type
        case identifier
    }
}

struct ReadingModes: Codable {
    var text: Bool
    var image: Bool

    enum CodingKeys: String, CodingKey {
        case text
        case image
    }
}

struct PanelizationSummary: Codable {
    var containsEpubBubbles: Bool
    var containsImageBubbles: Bool

    enum CodingKeys: String, CodingKey {
        case containsEpubBubbles
        case containsImageBubbles
    }
}

struct ImageLinks: Codable {
    var smallThumbnail: String?
    var thumbnail: String?

    enum CodingKeys: String, CodingKey {
        case smallThumbnail
        case thumbnail
    }
}

struct SaleInfo: Codable {
    var country: String?
    var saleAbility: String?
    var isEbook: Bool

    enum CodingKeys: String, CodingKey {
        case country
        case saleAbility = "saleability"
        case isEbook
    }
}

struct AccessInfo: Codable {
    var country: String?
    var viewAbility: String?
    var embeddable: Bool
    var publicDomain: Bool
    var textToSpeechPermission: String?
    var epub: Online?
    var pdf: Online?
    var webReaderLink: String?
    var accessViewStatus: String?
    var quoteSharingAllowed: Bool

    enum CodingKeys: String, CodingKey {
        case country
        case viewAbility = "viewability"
        case embeddable
        case publicDomain
        case textToSpeechPermission
        case epub
        case pdf
        case webReaderLink
        case accessViewStatus
        case quoteSharingAllowed
    }
}

struct Online: Codable {
    var isAvailable: Bool
    var acsTokenLink: String?

    enum CodingKeys: String, CodingKey {
        case isAvailable
        case acsTokenLink
    }
}

struct SearchInfo: Codable {
    var textSnippet: String?

    enum CodingKeys: String, CodingKey {
        case textSnippet
    }
}

struct BookDetails: Codable {
    var kind: String?
    var totalItems: Int?
    var items: [Books]?

    enum CodingKeys: String, CodingKey {
        case kind
        case totalItems
        case items
    }
}
