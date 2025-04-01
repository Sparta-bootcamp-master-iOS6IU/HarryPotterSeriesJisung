import Foundation

struct BookDataSource {
    /// JSON 파일에서 책 데이터를 가져오고 디코딩하는 메서드
    ///
    /// 파일을 찾을 수 없을 경우, 오류를 로깅하고 던짐
    ///
    /// - Parameter completion: 작업 결과를 처리하기 위한 클로저
    ///
    /// - Error
    ///   - `.invalidPath`: JSON 파일을 찾을 수 없을 때 발생
    ///   - `.jsonDecodingError`: JSON 디코딩이 실패할 때 발생
    ///   - `.unknownError`: 그 외 오류 발생
    func fetchBooks() throws -> [Attributes] {
        guard let path = Bundle.main.path(forResource: DataConstant.name, ofType: DataConstant.type) else {
            AppLogger.dataSource.error("\(LoggingConstant.DataSource.invalidPath)")

            throw BookDataSourceError.invalidPath
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))

            let bookResponse = try JSONDecoder().decode(BookResponse.self, from: data)

            return bookResponse.data.map { $0.attributes }
        } catch let error as DecodingError {
            AppLogger.dataSource.error("\(LoggingConstant.DataSource.jsonDecodingError)\(error.localizedDescription)")

            throw BookDataSourceError.jsonDecodingError
        } catch {
            AppLogger.dataSource.error("\(LoggingConstant.DataSource.unknownError)\(error.localizedDescription)")

            throw BookDataSourceError.unknownError
        }
    }
}
