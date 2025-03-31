import Foundation

struct DateFormatterHelper {
    private static let dateFormatter = DateFormatter()
    /// 날짜 문자열 형식을 변환하는 메서드
    /// - Parameter releasedDate: 변환할 날짜 문자열
    /// - Returns: 변환된 날짜 문자열
    static func formatDateString(_ releasedDate: String) -> String {
        let formatter = DateFormatterHelper.dateFormatter

        formatter.dateFormat = UIConstant.ReleasedDate.dateFormat

        guard let date = formatter.date(from: releasedDate) else {
            AppLogger.dateFormat.error("\(LoggingConstant.DateFormat.parseError)")

            return releasedDate
        }

        formatter.dateStyle = .long

        return formatter.string(from: date)
    }
}
