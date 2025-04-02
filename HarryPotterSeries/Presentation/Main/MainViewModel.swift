import Foundation

/// 책 데이터를 관리하고, 선택된 책의 상태를 추적하며, UI와의 데이터 바인딩 담당
final class MainViewModel {
    private let fetchBooksUseCase: FetchBooksUseCase
    private let manageExpandedStatesUseCase: ManageExpandedStatesUseCase
    private let bookSummaryUseCase: BookSummaryUseCase

    private(set) var books: [Book] = [] {
        didSet {
            onBooksUpdated?()
        }
    }

    private(set) var selectedBook: Book? {
        didSet {
            onBookSelected?()
        }
    }

    private var expandedStates: [String: Bool] = [:]

    var onBooksUpdated: (() -> Void)?
    var onBookSelected: (() -> Void)?
    var onFetchError: ((BookDataSourceError) -> Void)?

    init(
        fetchBooksUseCase: FetchBooksUseCase,
        manageExpandedStatesUseCase: ManageExpandedStatesUseCase,
        bookSummaryUseCase: BookSummaryUseCase
    ) {
        self.fetchBooksUseCase = fetchBooksUseCase
        self.manageExpandedStatesUseCase = manageExpandedStatesUseCase
        self.bookSummaryUseCase = bookSummaryUseCase
    }

    // MARK: Data Fetching

    /// 책 데이터를 가져오는 메서드
    ///
    /// 성공하면 `books` 프로퍼티를 업데이트하고, 첫 번째 책 선택
    ///
    /// 실패하면 `onFetchError` 클로저 호출
    func fetchBooks() {
        fetchBooksUseCase.fetchBooks { [weak self] result in
            switch result {
            case .success(let books):
                self?.books = books.sorted { $0.seriesOrder < $1.seriesOrder }

                if self?.selectedBook == nil, let book = self?.books.first {
                    self?.selectedBook = book
                }

                self?.fetchExpandedStates()
            case .failure(let error):
                self?.onFetchError?(error)
            }
        }
    }

    // MARK: Book

    /// 특정 시리즈 순서의 책을 선택하는 메서드
    ///
    /// - Parameter seriesOrder: 시리즈 순서 문자열
    func selectBook(at seriesOrder: String) {
        guard let book = books.first(where: { $0.seriesOrder == seriesOrder }) else {
            return
        }

        selectedBook = book
        onBookSelected?()
    }

    // MARK: - Expand/Collapse Management

    /// 선택된 책의 접기/더보기 상태를 반환하는 메서드
    ///
    /// - Parameter seriesOrder: 시리즈 순서 문자열
    /// - Returns: 접기/더보기 상태 Boolean 값(기본값은 `false`)
    private func state(for seriesOrder: String) -> Bool {
        guard let isExpanded = expandedStates[seriesOrder] else { return false }
        return isExpanded
    }

    /// 선택된 책의 접기/더보기 상태를 변환하는 메서드
    func toggleExpandedState() {
        guard let seriesOrder = selectedBook?.seriesOrder else { return }

        expandedStates[seriesOrder]?.toggle()

        saveExpandedStates()
    }

    /// 선택된 책의 Summary 정보를 반환하는 메서드
    ///
    /// - Returns: (Summary 문자열, 버튼 타이틀 문자열) 튜플
    func summaryWithTitle() -> (String, String?)? {
        guard let book = selectedBook else { return nil }

        let seriesOrder = book.seriesOrder

        let isExpanded = state(for: seriesOrder)
        let (summary, title) = bookSummaryUseCase.summaryWithTitle(for: book.summary, isExpanded: isExpanded)

        if title != .none {
            expandedStates[seriesOrder] = isExpanded
        }

        return (summary, title)
    }

    /// 저장된 접기/더보기 상태를 불러오는 메서드
    func fetchExpandedStates() {
        guard let savedExpandedStates = manageExpandedStatesUseCase.fetchExpandedStates() else { return }

        expandedStates = savedExpandedStates
    }

    /// 접기/더보기 상태를 저장하는 메서드
    func saveExpandedStates() {
        manageExpandedStatesUseCase.saveExpandedStates(expandedStates)
    }
}
