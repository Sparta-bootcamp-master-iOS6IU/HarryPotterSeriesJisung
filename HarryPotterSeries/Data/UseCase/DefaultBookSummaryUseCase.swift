struct DefaultBookSummaryUseCase: BookSummaryUseCase {
    /// 책의 Summary 정보를 반환하는 메서드
    /// - Parameters:
    ///   - book: 현재 선택된 책
    ///   - isExpanded: 접기/더보기 상태 Boolean
    /// - Returns: (Summary 문자열, 버튼 타이틀 문자열) 튜플
    func summary(for book: Book, isExpanded: Bool) -> (String, String) {
        let summary = isExpanded ? book.summary : applyEllipsis(to: book.summary)
        let buttonTitle = summaryToggleButtonTitle(with: isExpanded)

        return (summary, buttonTitle)
    }

    /// Summary를 일정 길이까지만 표시하고 말줄임표(...)를 추가하는 메서드
    /// - Parameter summary: 원본 Summary
    /// - Returns: 말줄임표가 추가된 Summary
    private func applyEllipsis(to summary: String) -> String {
        String(summary.prefix(UIConstant.Summary.ellipsisThreshold)) + UIConstant.Summary.ellipsis
    }

    /// 접기/더보기 상태에 따라 버튼 타이틀 문자열을 반환하는 메서드
    /// - Parameter expandedState: 접기/더보기 상태 Boolean
    /// - Returns: `접기` 또는 `더보기` 문자열
    private func summaryToggleButtonTitle(with expandedState: Bool) -> String {
        expandedState ? UIConstant.EllipsisButton.collapse : UIConstant.EllipsisButton.expand
    }
}
