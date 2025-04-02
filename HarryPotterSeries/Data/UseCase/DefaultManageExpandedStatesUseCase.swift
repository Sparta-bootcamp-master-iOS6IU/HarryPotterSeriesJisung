struct DefaultManageExpandedStatesUseCase: ManageExpandedStatesUseCase {
    private let expandedStatesRepository: ExpandedStatesRepository

    init(expandedStatesRepository: ExpandedStatesRepository) {
        self.expandedStatesRepository = expandedStatesRepository
    }

    /// 접기/더보기 상태를 불러오는 메서드
    ///
    /// - Returns: 저장된 접기/더보기 상태 딕셔너리(저장된 값이 없으면 `nil` 반환)
    func fetchExpandedStates() -> [String: Bool]? {
        expandedStatesRepository.fetchExpandedStates()
    }

    /// 접기/더보기 상태를 저장하는 메서드
    ///
    /// - Parameter expandedStates: 저장할 접기/더보기 상태 딕셔너리
    func saveExpandedStates(_ expandedStates: [String: Bool]) {
        expandedStatesRepository.saveExpandedStates(expandedStates)
    }
}
