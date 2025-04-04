import Foundation

struct DefaultBookRepository: BookRepository {
    private let bookDataSource: BookDataSource
    private let bookMapper: BookMapper

    init(bookDataSource: BookDataSource, bookMapper: BookMapper) {
        self.bookDataSource = bookDataSource
        self.bookMapper = bookMapper
    }

    /// 책 데이터를 비동기적으로 가져오는 메서드
    ///
    /// - Parameter completion: 작업 결과를 처리하기 위한 클로저
    ///   - `.success([Book])`: 책 데이터 배열 반환
    ///   - `.failure(BookDataSourceError)`: 오류 발생 시 해당 오류 반환
    func fetchBooks(completion: @escaping (Result<[Book], BookDataSourceError>) -> Void) {
        DispatchQueue.global().async { [bookDataSource, bookMapper] in
            do {
                let attributes = try bookDataSource.fetchBooks()
                let books = bookMapper.mapToDomainModel(attributes)

                DispatchQueue.main.async {
                    completion(.success(books))
                }
            } catch let error as BookDataSourceError {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.unknownError))
                }
            }
        }
    }
}
