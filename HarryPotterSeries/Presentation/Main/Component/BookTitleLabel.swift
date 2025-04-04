import UIKit

/// 책 제목을 표시하는 커스텀 `UILabel`
final class BookTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        nil
    }

    /// UI 기본 설정 메서드
    private func configureUI() {
        font = .boldSystemFont(ofSize: UIConstant.FontSize.extraLarge)
        textAlignment = .center
        numberOfLines = UIConstant.DefaultLabel.numberOfLines
    }
}
