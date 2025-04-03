struct Attributes: Codable {
    let title: String
    let author: String
    let pages: Int
    let releaseDate: String
    let dedication: String
    let summary: String
    let wiki: String
    let chapters: [Chapter]

    enum CodingKeys: String, CodingKey {
        case title,
             author,
             pages,
             releaseDate = "release_date",
             dedication,
             summary,
             wiki,
             chapters
    }
}
