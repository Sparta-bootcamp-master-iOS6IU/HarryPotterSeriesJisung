protocol BookRepository {
    func fetchBooks(completion: @escaping (Result<[Book], BookError>) -> Void)
}
