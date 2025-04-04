import Foundation

struct BookDataSource {
    /// JSON 파일에서 책 데이터를 가져와 디코딩하는 메서드
    ///
    /// - Throws: `BookDataSourceError`
    ///   - `.invalidPath`: JSON 파일을 찾을 수 없는 경우
    ///   - `.jsonDecodingError`: JSON 디코딩이 실패 시
    ///   - `.unknownError`: 기타 알 수 없는 오류 발생 시
    /// - Returns: 디코딩된 `Attributes` 배열
    func fetchBooks() throws -> [Attributes] {
        guard let path = Bundle.main.path(forResource: DataConstant.name, ofType: DataConstant.type) else {
            AppLogger.dataSource.error("\(LoggingConstant.DataSource.invalidPath)")

            throw BookDataSourceError.invalidPath
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))

            let bookResponse = try JSONDecoder().decode(BookResponse.self, from: data)

            return bookResponse.data.map(\.attributes)
        } catch let error as DecodingError {
            AppLogger.dataSource.error("\(LoggingConstant.DataSource.jsonDecodingError)\(error.localizedDescription)")

            throw BookDataSourceError.jsonDecodingError
        } catch {
            AppLogger.dataSource.error("\(LoggingConstant.DataSource.unknownError)\(error.localizedDescription)")

            throw BookDataSourceError.unknownError
        }
    }
}
