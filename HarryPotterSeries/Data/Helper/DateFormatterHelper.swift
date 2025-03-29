import Foundation

struct DateFormatterHelper {
    private static let dateFormatter = DateFormatter()

    static func formatDateString(_ releasedDate: String) -> String {
        let formatter = DateFormatterHelper.dateFormatter

        formatter.dateFormat = StringKey.dateFormat

        guard let date = formatter.date(from: releasedDate) else {
            AppLogger.dateFormat.error("\(Logging.DateFormat.parseError)")

            return releasedDate
        }

        formatter.dateStyle = .long

        return formatter.string(from: date)
    }
}
