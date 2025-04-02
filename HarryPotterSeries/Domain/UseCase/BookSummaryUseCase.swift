/// 책의 Summary 정보에 말줄임표 처리 기능을 담당하는 프로토콜
protocol BookSummaryUseCase {
    /// 책의 Summary 정보를 반환하는 메서드
    ///
    /// - Parameters:
    ///   - summary: 요약 문자열
    ///   - isExpanded: 접기/더보기 상태를 나타내는 `Bool` 값`
    /// - Returns: `(summary: String, buttonTitle: String)` 튜플
    func summary(for summary: String, isExpanded: Bool) -> (String, String?)
}
