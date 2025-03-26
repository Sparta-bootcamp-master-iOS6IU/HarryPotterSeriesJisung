import os

/// Logger를 관리하는 구조체
struct AppLogger {
    static let api = Logger(subsystem: Logging.subsystem, category: Logging.api)
}
