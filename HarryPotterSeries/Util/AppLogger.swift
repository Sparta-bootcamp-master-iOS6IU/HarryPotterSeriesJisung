import os

/// Logger를 관리하는 구조체
struct AppLogger {
    static let dataSource = Logger(subsystem: Logging.subsystem, category: Logging.dataSource)
    static let dateFormat = Logger(subsystem: Logging.subsystem, category: Logging.dateFormat)
}
