/// 접기/더보기 상태를 관리하는 기능을 담당하는 프로토콜
protocol ManageExpandedStatesUseCase {
    /// 접기/더보기 상태를 불러오는 메서드
    ///
    /// - Returns: 저장된 접기/더보기 상태 딕셔너리(저장된 값이 없으면 `nil` 반환)
    func fetchExpandedStates() -> [String: Bool]?

    /// 접기/더보기 상태를 저장하는 메서드
    ///
    /// - Parameter expandedStates: 저장할 접기/더보기 상태 딕셔너리
    func saveExpandedStates(_ states: [String: Bool])
}
