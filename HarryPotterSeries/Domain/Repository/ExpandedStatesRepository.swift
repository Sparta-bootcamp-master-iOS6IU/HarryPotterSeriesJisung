/// 접기/더보기 상태를 관리하는 기능을 담당하는 프로토콜
protocol ExpandedStatesRepository {
    /// 접기/더보기 상태 데이터를 저장하는 메서드
    ///
    /// - Parameter expandedStates: 접기/ 더보기 상태 딕셔너리
    func saveExpandedStates(_ expandedStates: [String: Bool])

    /// 저장된 접기/더보기 상태 데이터를 불러오는 메서드
    ///
    /// - Returns: 접기/더보기 상태 딕셔너리(데이터가 없을 경우 `nil` 반환)
    func fetchExpandedStates() -> [String: Bool]?
}
