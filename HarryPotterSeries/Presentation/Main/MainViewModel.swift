import Foundation

final class MainViewModel {
    private let fetchBooksUseCase: FetchBooksUseCase
    private let manageExpandedStatesUseCase: ManageExpandedStatesUseCase
    private let bookSummaryUseCase: BookSummaryUseCase

    private var books: [Book] = []
    private var expandedStates: [String: Bool] = [:]

    init(
        fetchBooksUseCase: FetchBooksUseCase,
        manageExpandedStatesUseCase: ManageExpandedStatesUseCase,
        bookSummaryUseCase: BookSummaryUseCase
    ) {
        self.fetchBooksUseCase = fetchBooksUseCase
        self.manageExpandedStatesUseCase = manageExpandedStatesUseCase
        self.bookSummaryUseCase = bookSummaryUseCase
    }

    /// `DefaultFetchBooksUseCase`를 통해 책 데이터를 비동기적으로 가져오는 메서드
    /// 성공했을 경우 `completion` 클로저를 호출하여 성공을 전달하고, 실패하면 오류를 전달
    ///
    /// - Parameter completion: 작업 결과를 처리하기 위한 클로저
    func fetchBooks(completion: @escaping (Result<Void, BookDataSourceError>) -> Void) {
        fetchBooksUseCase.fetchBooks { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let books):
                self.books = books

                self.fetchExpandedStates()

                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    /// 선택된 `Book` 객체를 반환하는 메서드
    /// - Parameter seriesOrder: `Book`의 시리즈 순서 문자열
    /// - Returns: 선택된 `Book`
    func book(by seriesOrder: String) -> Book? {
        books.first { $0.seriesOrder == seriesOrder }
    }

    /// 접기/더보기 상태를 불러오는 메서드
    func fetchExpandedStates() {
        guard let savedExpandedStates = manageExpandedStatesUseCase.fetchExpandedStates() else { return }

        expandedStates = savedExpandedStates
    }

    /// 접기/더보기 상태를 저장하는 메서드
    func saveExpandedStates() {
        manageExpandedStatesUseCase.saveExpandedStates(expandedStates)
    }
}

extension MainViewModel {
    /// 선택된 책의 Summary 정보를 반환하는 메서드
    /// - Parameter seriesOrder: `Book`의 시리즈 순서 문자열
    /// - Returns: (Summary 문자열, 버튼 타이틀 문자열) 튜플
    func summary(by seriesOrder: String) -> (String, String)? {
        guard let book = book(by: seriesOrder) else { return nil }

        let isExpanded = state(for: seriesOrder)

        return bookSummaryUseCase.summary(for: book, isExpanded: isExpanded)
    }

    /// 선택된 책의 접기/더보기 상태를 반환하는 메서드
    /// - Parameter seriesOrder: `Book`의 시리즈 순서`
    /// - Returns: 접기/더보기 상태 Boolean 값. 기본값은 `false`
    private func state(for seriesOrder: String) -> Bool {
        guard let isExpanded = expandedStates[seriesOrder] else {
            expandedStates[seriesOrder] = false

            return false
        }

        return isExpanded
    }

    /// 선택된 책의 접기/더보기 상태를 변환하는 메서드
    /// - Parameter seriesOrder: `Book`의 시리즈 순서
    func toggleExpandedState(for seriesOrder: String) {
        expandedStates[seriesOrder]?.toggle()

        saveExpandedStates()
    }
}
