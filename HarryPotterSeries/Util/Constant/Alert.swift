enum Alert {
    static let error = "Error"
    static let confirm = "확인"

    enum Message {
        static let invalidPath = "책 데이터를 찾을 수 없습니다."
        static let jsonDecodingError = "책 데이터를 불러오는 중에 문제가 발생했습니다."
        static let unknownError = "알 수 없는 오류가 발생했습니다."
    }
}
