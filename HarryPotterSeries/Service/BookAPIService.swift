import Foundation
import os

struct BookAPIService {
    static let shared = BookAPIService()

    func fetchBooks() -> [Book]? {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            AppLogger.api.error("\(Logging.Message.invaliedPath)")

            return nil
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decodedData = try JSONDecoder().decode(BookAPIResponse.self, from: data)

            let books = decodedData.data.enumerated().map { index, bookData -> Book in
                var book = bookData.attributes
                book.order = "\(index + 1)"

                return book
            }

            return books
        } catch {
            AppLogger.api.error("\(Logging.Message.jsonDecodingError)")

            return nil
        }
    }
}
