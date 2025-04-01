protocol ManageExpandedStatesUseCase {
    func fetchExpandedStates() -> [String: Bool]?
    func saveExpandedStates(_ states: [String: Bool])
}
