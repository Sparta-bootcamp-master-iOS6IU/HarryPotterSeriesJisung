struct DefaultBookRepository: BookRepository {
    private let bookDataSource: BookDataSource
    private let bookMapper: BookMapper

    init(bookDataSource: BookDataSource, bookMapper: BookMapper) {
        self.bookDataSource = bookDataSource
        self.bookMapper = bookMapper
    }

    /// 책 데이터를 비동기적으로 가져오는 메서드
    /// - Parameter completion: 작업 결과를 처리하기 위한 클로저
    func fetchBooks(completion: @escaping (Result<[Book], BookDataSourceError>) -> Void) {
        bookDataSource.fetchBooks { result in
            switch result {
            case .success(let attributes):
                let books = bookMapper.mapToDomainModel(attributes)

                completion(.success(books))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
