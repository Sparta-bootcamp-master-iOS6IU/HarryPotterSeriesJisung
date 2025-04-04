import Foundation

struct ExpandedStatesDataSource {
    private let userDefaults = UserDefaults.standard

    /// 접기/더보기 상태를 `userDefaults`에 저장하는 메서드
    ///
    /// - Parameter expandedStates: 접기/더보기 상태 딕셔너리
    func saveExpandedStates(_ expandedStates: [String: Bool]) {
        userDefaults.set(expandedStates, forKey: DataConstant.expandedStates)
    }

    /// `userDefaults`에서 접기/더보기 상태를 불러오는 메서드
    ///
    /// - Returns: 저장된 접기/더보기 상태 딕셔너리(데이터가 없을 경우 `nil` 반환)
    func fetchExpandedStates() -> [String: Any]? {
        userDefaults.dictionary(forKey: DataConstant.expandedStates)
    }
}
