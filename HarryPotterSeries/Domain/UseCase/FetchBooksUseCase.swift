protocol FetchBooksUseCase {
    func fetchBooks(completion: @escaping (Result<[Book], BookDataSourceError>) -> Void)
}
