import Foundation

struct DateFormatterHelper {
    private static let dateFormatter = DateFormatter()

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
