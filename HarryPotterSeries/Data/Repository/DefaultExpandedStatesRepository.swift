struct DefaultExpandedStatesRepository: ExpandedStatesRepository {
    private let expandedStatesDataSource = ExpandedStatesDataSource()

    func saveExpandedStates(_ expandedStates: [String: Bool]) {
        expandedStatesDataSource.saveExpandedStates(expandedStates)
    }

    func fetchExpandedStates() -> [String: Bool]? {
        guard let expandedStates = expandedStatesDataSource.fetchExpandedStates() as? [String: Bool] else {
            return nil
        }

        return expandedStates
    }
}
