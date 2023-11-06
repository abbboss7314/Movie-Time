import Foundation
import UIKit

struct TizerModel: Codable {
    var kind, etag, nextPageToken, regionCode: String?
    var pageInfo: TizerPageInfo?
    var items: [TizerItem]?
}

struct TizerItem: Codable {
    var kind, etag: String?
    var id: TizerID?
}

struct TizerID: Codable {
    var kind, videoID: String?
    
    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}

struct TizerPageInfo: Codable {
    var totalResults, resultsPerPage: Int?
}
