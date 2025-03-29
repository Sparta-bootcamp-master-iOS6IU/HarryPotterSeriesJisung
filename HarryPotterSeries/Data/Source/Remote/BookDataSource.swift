import Foundation

struct BookDataSource {
    /// JSON 파일에서 책 데이터를 비동기적으로 가져오고 디코딩하는 메서드
    /// 파일을 찾을 수 없을 경우, 오류를 로깅하고 `.failure를 사용하여 `completion` 핸들러 호출
    ///
    /// - Parameter completion: 작업 결과를 처리하기 위한 클로저
    ///
    /// - Error
    ///   - `.invalidPath`: JSON 파일을 찾을 수 없을 때 발생
    ///   - `.jsonDecodingError`: JSON 디코딩이 실패할 때 발생
    ///   - `.unknownError`: 그 외 오류 발생
    func fetchBooks(completion: @escaping (Result<[Attributes], BookError>) -> Void) {
        DispatchQueue.global().async {
            guard let path = Bundle.main.path(forResource: DataFile.name, ofType: DataFile.type) else {
                AppLogger.dataSource.error("\(Logging.DataSource.invalidPath)")
                completion(.failure(.invalidPath))

                return
            }

            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))

                let bookResponse = try JSONDecoder().decode(BookResponse.self, from: data)

                let attributes = bookResponse.data.map { $0.attributes }

                completion(.success(attributes))
            } catch let error {
                let errorMessage = error.localizedDescription

                func handleError(_ logMessage: String, _ error: BookError) {
                    AppLogger.dataSource.error("\(logMessage)\(errorMessage)")
                    completion(.failure(error))
                }

                if (error as? DecodingError) != nil {
                    handleError(Logging.DataSource.jsonDecodingError, .jsonDecodingError)
                } else {
                    handleError(Logging.DataSource.unknownError, .unknownError)
                }
            }
        }
    }
}
