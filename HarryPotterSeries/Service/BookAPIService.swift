import Foundation

struct BookAPIService {
    static let shared = BookAPIService()

    /// JSON 파일에서 책 데이터를 가져오는 메서드
    /// - Returns: 성공 시 `Book` 객체 배열을 포함한 `.success`를 반환하며,
    ///   실패 시 `BookAPIError`를 포함한 `.failure`를 반환
    func fetchBooks() -> Result<[Book], BookAPIError> {
        guard let path = Bundle.main.path(forResource: DataFile.name, ofType: DataFile.type) else {
            AppLogger.api.error("\(Logging.Message.invaliedPath)")

            return .failure(.invalidPath)
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decodedData = try JSONDecoder().decode(BookAPIResponse.self, from: data)

            let books = decodedData.data.enumerated().map { index, bookData -> Book in
                var book = bookData.attributes
                book.order = "\(index + 1)"

                return book
            }

            return .success(books)
        } catch {
            AppLogger.api.error("\(Logging.Message.jsonDecodingError)\(error.localizedDescription)")

            return .failure(.jsonDecodingError)
        }
    }
}
