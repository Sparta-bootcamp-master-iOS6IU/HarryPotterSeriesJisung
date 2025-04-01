struct DefaultFetchBooksUseCase: FetchBooksUseCase {
    private let bookRepository: BookRepository

    init(bookRepository: BookRepository) {
        self.bookRepository = bookRepository
    }

    /// `DefaultBookRepository`를 통해 책 데이터를 비동기적으로 가져오는 메서드
    /// 성공했을 경우 `completion` 클로저를 호출하여 성공을 전달하고, 실패하면 오류를 전달
    ///
    /// - Parameter completion: 작업 결과를 처리하기 위한 클로저
    func fetchBooks(completion: @escaping (Result<[Book], BookDataSourceError>) -> Void) {
        bookRepository.fetchBooks { result in
            switch result {
            case .success(let books):
                completion(.success(books))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
