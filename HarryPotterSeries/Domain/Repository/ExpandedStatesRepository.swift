protocol ExpandedStatesRepository {
    func saveExpandedStates(_ expandedStates: [String: Bool])
    func fetchExpandedStates() -> [String: Bool]?
}
