/// 책 데이터를 가져오는 기능을 담당하는 프로토콜
protocol FetchBooksUseCase {
    /// 책 데이터를 가져오는 메서드
    ///
    /// - Parameter completion: 작업 결과를 처리하는 클로저
    ///   - `.success([Book])`: 책 데이터 배열 반환
    ///   - `.failure(BookDataSourceError)`: 오류 발생 시 해당 오류 반환
    func fetchBooks(completion: @escaping (Result<[Book], BookDataSourceError>) -> Void)
}
