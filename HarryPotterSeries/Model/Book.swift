struct Book: Codable {
    var order: String
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

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        order = ""
        title = try container.decode(String.self, forKey: .title)
        author = try container.decode(String.self, forKey: .author)
        pages = try container.decode(Int.self, forKey: .pages)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        dedication = try container.decode(String.self, forKey: .dedication)
        summary = try container.decode(String.self, forKey: .summary)
        wiki = try container.decode(String.self, forKey: .wiki)
        chapters = try container.decode([Chapter].self, forKey: .chapters)
    }
}
