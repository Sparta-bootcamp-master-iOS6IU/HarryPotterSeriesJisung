import Foundation

struct ExpandedStatesDataSource {
    private let usreDefaults = UserDefaults.standard

    /// 접기/더보기 상태 데이터를 `UserDefaults` 저장하는 메서드
    /// - Parameter expandedStates: 접기/더보기 상태 딕셔너리
    func saveExpandedStates(_ expandedStates: [String: Bool]) {
        usreDefaults.set(expandedStates, forKey: DataConstant.expandedStates)
    }

    /// `UserDefaults`에서 접기/더보기 상태 데이터를 불러오는 메서드
    /// - Returns: 저장된 접기/더보기 상태 딕셔너리
    func fetchExpandedStates() -> [String: Any]? {
        usreDefaults.dictionary(forKey: DataConstant.expandedStates)
    }
}
