import Foundation

struct BookAPIService {
    static let shared = BookAPIService()

    /// JSON 파일에서 책 목록을 가져오는 메서드
    /// - Returns: Book 배열 또는 오류 시 `nil` 반환
    func fetchBooks() -> [Book]? {
        guard let path = Bundle.main.path(forResource: DataFile.name, ofType: DataFile.type) else {
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
