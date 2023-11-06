import Foundation

// MARK: - Result
struct GeneralResult: Codable {
    var adult: Bool?
    var backdropPath: String?
    var id: Int?
    var title: String?
    var originalLanguage: String?
    var originalTitle, overview, posterPath: String?
    var mediaType: String?
    var genreIDS: [Int]?
    var popularity: Double?
    var releaseDate: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}
    enum OriginalLanguage: String, Codable {
        case en = "en"
        case fr = "fr"
        case hi = "hi"
        case zh = "zh"
        case uk = "uk"
        case n1 = "nI"
        case ja = "ja"
}
