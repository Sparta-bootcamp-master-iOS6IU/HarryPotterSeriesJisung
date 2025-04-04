struct DefaultBookSummaryUseCase: BookSummaryUseCase {
    /// 책의 Summary 정보를 반환하는 메서드
    ///
    /// - Parameters:
    ///   - summary: 요약 문자열
    ///   - isExpanded: 접기/더보기 상태를 나타내는 `Bool` 값`
    /// - Returns: `(summary: String, buttonTitle: String)` 튜플
    func summaryWithTitle(for summary: String, isExpanded: Bool) -> (String, String?) {
        let isEllipsisNeeded = needsEllipsis(in: summary)
        if isEllipsisNeeded {
            let summary = isExpanded ? summary : applyEllipsis(to: summary)
            let buttonTitle = summaryToggleButtonTitle(with: isExpanded)

            return (summary, buttonTitle)
        }

        return (summary, .none)
    }

    /// Summary를 일정 길이까지만 표시하고 말줄임표(...)를 추가하는 메서드
    ///
    /// - Parameter summary: 원본 Summary 문자열
    /// - Returns: 말줄임표가 추가된 Summary 문자열
    private func applyEllipsis(to summary: String) -> String {
        let threshold = UIConstant.Summary.ellipsisThreshold

        return (summary.count > threshold)
            ? summary.prefix(threshold) + UIConstant.Summary.ellipsis
            : summary
    }

    /// 접기/더보기 상태에 따라 버튼 타이틀 문자열을 반환하는 메서드
    ///
    /// - Parameter expandedState: 접기/더보기 상태를 나타내는 `Bool` 값
    /// - Returns: `접기` 또는 `더보기` 문자열
    private func summaryToggleButtonTitle(with expandedState: Bool) -> String {
        expandedState ? UIConstant.EllipsisButton.collapse : UIConstant.EllipsisButton.expand
    }

    /// 말줄임표가 필요한지 확인하는 메서드
    ///
    /// - Parameter summary: Summary 문자열
    /// - Returns: 말줄임표 필요 여부 `Bool` 값
    private func needsEllipsis(in summary: String) -> Bool {
        summary.count > UIConstant.Summary.ellipsisThreshold
    }
}
