import Foundation

struct ExpandedStatesDataSource {
    private let usreDefaults = UserDefaults.standard

    func saveExpandedStates(_ expandedStates: [String: Bool]) {
        usreDefaults.set(expandedStates, forKey: DataConstant.expandedStates)
    }

    func fetchExpandedStates() -> [String: Any]? {
        usreDefaults.dictionary(forKey: DataConstant.expandedStates)
    }
}
