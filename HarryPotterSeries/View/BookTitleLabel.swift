import UIKit

final class BookTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configureUI()
    }

    private func configureUI() {
        font = .boldSystemFont(ofSize: CGFloat(Font.Size.extraLarge))
        textAlignment = .center
        numberOfLines = Component.DefaultLabel.numberOfLines
    }
}
