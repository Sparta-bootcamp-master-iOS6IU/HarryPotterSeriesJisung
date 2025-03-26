enum Logging {
    static let subsystem = "com.meowbutlerdev.HarryPotterSeries"
    static let api = "API"

    enum Message {
        static let invaliedPath = "파일을 찾을 수 없습니다."
        static let jsonDecodingError = "JSON 데이터를 디코딩하는 중에 오류가 발생했습니다."
    }
}
