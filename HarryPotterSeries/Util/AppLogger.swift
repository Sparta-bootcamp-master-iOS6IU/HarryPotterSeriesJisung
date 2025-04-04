import os

/// Logger를 관리하는 구조체
struct AppLogger {
    static let dataSource = Logger(subsystem: LoggingConstant.subsystem, category: LoggingConstant.dataSource)
    static let dateFormat = Logger(subsystem: LoggingConstant.subsystem, category: LoggingConstant.dateFormat)
}
