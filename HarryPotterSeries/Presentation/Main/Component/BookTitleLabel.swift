import UIKit

final class BookTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        nil
    }

    private func configureUI() {
        font = .boldSystemFont(ofSize: UIConstant.FontSize.extraLarge)
        textAlignment = .center
        numberOfLines = UIConstant.DefaultLabel.numberOfLines
    }
}
