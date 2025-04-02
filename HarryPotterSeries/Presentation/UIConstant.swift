import Foundation

enum UIConstant {
    static let verticalStackViewHeightMultiplier = 0.85

    enum Spacing {
        static let large: CGFloat = 20
        static let medium: CGFloat = 16
        static let small: CGFloat = 8
    }

    enum Offset {
        static let extraLarge = 24
        static let large = 20
        static let medium = 16
        static let small = 10
    }

    enum Inset {
        static let extraLarge = 32
        static let large = 20
        static let medium = 15
        static let tiny = 5
    }

    enum FontSize {
        static let extraLarge: CGFloat = 24
        static let large: CGFloat = 20
        static let medium: CGFloat = 18
        static let small: CGFloat = 16
        static let tiny: CGFloat = 14
    }

    enum StringKey {
        static let author = "Author"
        static let released = "Released"
        static let pages = "Pages"
        static let dedication = "Dedication"
        static let summary = "Summary"
        static let chapters = "Chapters"
    }

    enum SeriesOrderButton {
        static let size = 40
        static let radius: CGFloat = 20
    }

    enum BookImage {
        static let width = 100
        static let aspectRatio = 1.5
    }

    enum DefaultLabel {
        static let numberOfLines = 0
    }

    enum ReleasedDate {
        static let dateFormat = "yyyy-MM-dd"
    }

    enum Summary {
        static let ellipsisThreshold = 450
        static let ellipsis = "..."
    }

    enum EllipsisButton {
        static let expand = "더보기"
        static let collapse = "접기"
    }

    enum Alert {
        static let errorTitle = "Error"
        static let confirmButtonTitle = "확인"
        static let invalidPathErrorMessage = "책 데이터를 찾을 수 없습니다."
        static let jsonDecodingErrorMessage = "책 데이터를 불러오는 중에 문제가 발생했습니다."
        static let unknownErrorMessage = "알 수 없는 오류가 발생했습니다."
    }
}
