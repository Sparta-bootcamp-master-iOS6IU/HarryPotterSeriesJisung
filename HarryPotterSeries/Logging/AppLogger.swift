import os

struct AppLogger {
    static let api = Logger(subsystem: Logging.subsystem, category: Logging.api)
}
