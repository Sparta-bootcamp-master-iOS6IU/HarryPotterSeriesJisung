import Foundation

final class MainViewModel {
    private let bookRepository = DefaultBookRepository()

    private var books: [Book] = []

    private var expandedStates: [String: Bool] = [:]

    /// `DefaultBookRepository`를 통해 책 데이터를 비동기적으로 가져오는 메서드
    /// 성공했을 경우 `completion` 클로저를 호출하여 성공을 전달하고, 실패하면 오류를 전달
    ///
    /// - Parameter completion: 작업 결과를 처리하기 위한 클로저
    func fetchBooks(completion: @escaping (Result<Void, BookError>) -> Void) {
        bookRepository.fetchBooks { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let books):
                self.books = books

                self.initializeExpandedStates()

                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func book(by seriesOrder: String) -> Book? {
        books.first { $0.seriesOrder == seriesOrder }
    }

    private func initializeExpandedStates() {
        expandedStates = books.reduce(into: [String: Bool]()) { $0[$1.seriesOrder] = false }
    }
}

extension MainViewModel {
    func summary(by seriesOrder: String) -> (String, String)? {
        guard let book = book(by: seriesOrder) else { return nil }

        let isExpanded = expandedStates[seriesOrder, default: false]

        let summary = isExpanded ? book.summary : applyEllipsis(to: book.summary)
        let buttonTitle = summaryToggleButtonTitle(with: isExpanded)

        return (summary, buttonTitle)
    }

    private func applyEllipsis(to summary: String) -> String {
        String(summary.prefix(UIConstant.Summary.ellipsisThreshold)) + UIConstant.Summary.ellipsis
    }

    private func summaryToggleButtonTitle(with expandedState: Bool) -> String {
        expandedState ? UIConstant.EllipsisButton.collapse : UIConstant.EllipsisButton.expand
    }

    func toggleExpandedState(for seriesOrder: String) {
        expandedStates[seriesOrder]?.toggle()
    }
}
