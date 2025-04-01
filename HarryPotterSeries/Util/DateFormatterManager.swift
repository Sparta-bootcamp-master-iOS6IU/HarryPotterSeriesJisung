import Foundation

struct DateFormatterManager {
    static let shared = DateFormatterManager()

    private let formatter: DateFormatter

    private init() {
        formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
    }

    func formatDate(from dateString: String) -> String {
        guard let date = formatter.date(from: dateString) else {
            return dateString
        }

        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}
