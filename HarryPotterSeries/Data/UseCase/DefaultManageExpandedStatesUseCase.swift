struct DefaultManageExpandedStatesUseCase: ManageExpandedStatesUseCase {
    private let expandedStatesRepository: ExpandedStatesRepository

    init(expandedStatesRepository: ExpandedStatesRepository) {
        self.expandedStatesRepository = expandedStatesRepository
    }

    /// 접기/더보기 상태를 불러오는 메서드
    func fetchExpandedStates() -> [String: Bool]? {
        guard let savedExpandedStates = expandedStatesRepository.fetchExpandedStates() else { return nil }

        return savedExpandedStates
    }

    /// 접기/더보기 상태를 저장하는 메서드
    func saveExpandedStates(_ expandedStates: [String: Bool]) {
        expandedStatesRepository.saveExpandedStates(expandedStates)
    }
}
