protocol BookRepository {
    func fetchBooks(completion: @escaping (Result<[Book], BookDataSourceError>) -> Void)
}
