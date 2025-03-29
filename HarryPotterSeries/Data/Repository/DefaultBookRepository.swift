import Foundation

struct DefaultBookRepository: BookRepository {
    private let bookDataSource = BookDataSource()
    private let bookMapper = BookMapper()

    func fetchBooks(completion: @escaping (Result<[Book], BookError>) -> Void) {
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
