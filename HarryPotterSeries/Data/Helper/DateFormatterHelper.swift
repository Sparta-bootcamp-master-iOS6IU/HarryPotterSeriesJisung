import Foundation

struct DateFormatterHelper {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long

        return formatter
    }()

    /// 날짜 문자열 형식을 변환하는 메서드
    ///
    /// - Parameter releasedDate: 변환할 날짜 문자열
    /// - Returns: 변환된 날짜 문자열(변환 실패 시 원본 문자열 반환)
    static func formatDateString(_ releasedDate: String) -> String {
        dateFormatter.dateFormat = UIConstant.ReleasedDate.dateFormat

        guard let date = dateFormatter.date(from: releasedDate) else {
            AppLogger.dateFormat.error("\(LoggingConstant.DateFormat.parseError)")

            return releasedDate
        }

        dateFormatter.dateStyle = .long

        return dateFormatter.string(from: date)
    }
}
