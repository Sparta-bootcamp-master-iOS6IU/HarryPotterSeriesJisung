import Foundation

struct BookAPIService {
    static let shared = BookAPIService()

    /// JSON 파일에서 책 데이터를 비동기적으로 가져오고 디코딩하는 메서드
    /// 파일을 찾을 수 없을 경우, 오류를 로깅하고 `.failure를 사용하여 `completion` 핸들러 호출
    ///
    /// - Parameter completion: 작업 결과를 처리하기 위한 클로저
    ///
    /// - Error
    ///   - `.invalidPath`: JSON 파일을 찾을 수 없을 때 발생
    ///   - `.jsonDecodingError`: JSON 디코딩이 실패할 때 발생
    func fetchBooks(completion: @escaping (Result<[Book], BookAPIError>) -> Void) {
        DispatchQueue.global().async {
            guard let path = Bundle.main.path(forResource: DataFile.name, ofType: DataFile.type) else {
                AppLogger.api.error("\(Logging.Message.invaliedPath)")
                completion(.failure(.invalidPath))

                return
            }

            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decodedData = try JSONDecoder().decode(BookAPIResponse.self, from: data)

                let books = decodedData.data.enumerated().map { index, bookData -> Book in
                    var book = bookData.attributes

                    let order = "\(index + 1)"
                    book.order = order
                    book.image = DataFile.imageFileNmaePrefix + order

                    return book
                }

                completion(.success(books))
            } catch {
                AppLogger.api.error("\(Logging.Message.jsonDecodingError)\(error.localizedDescription)")
                completion(.failure(.jsonDecodingError))
            }
        }
    }
}
