enum LoggingConstant {
    static let subsystem = "com.meowbutlerdev.HarryPotterSeries"
    static let dataSource = "DataSource"
    static let dateFormat = "DateFormat"

    enum DataSource {
        static let lineBreak = "\n"
        static let invalidPath = "파일을 찾을 수 없습니다."
        static let jsonDecodingError = "JSON 데이터를 디코딩하는 중에 오류가 발생했습니다." + lineBreak
        static let unknownError = "알 수 없는 오류가 발생했습니다." + lineBreak
    }

    enum DateFormat {
        static let parseError = "날짜 변환에 실패했습니다."
    }
}
