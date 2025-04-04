struct DefaultExpandedStatesRepository: ExpandedStatesRepository {
    private let expandedStatesDataSource: ExpandedStatesDataSource

    init(expandedStatesDataSource: ExpandedStatesDataSource) {
        self.expandedStatesDataSource = expandedStatesDataSource
    }

    /// 접기/더보기 상태 데이터를 저장하는 메서드
    ///
    /// - Parameter expandedStates: 접기/ 더보기 상태 딕셔너리
    func saveExpandedStates(_ expandedStates: [String: Bool]) {
        expandedStatesDataSource.saveExpandedStates(expandedStates)
    }

    /// 저장된 접기/더보기 상태 데이터를 불러오는 메서드
    ///
    /// - Returns: 접기/더보기 상태 딕셔너리(데이터가 없을 경우 `nil` 반환)
    func fetchExpandedStates() -> [String: Bool]? {
        expandedStatesDataSource.fetchExpandedStates() as? [String: Bool]
    }
}
