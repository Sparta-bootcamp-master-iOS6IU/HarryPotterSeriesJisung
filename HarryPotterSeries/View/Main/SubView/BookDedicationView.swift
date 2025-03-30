import UIKit
import SnapKit

final class BookDedicationView: UIView {
    private let dedicationStackView = UIStackView()
    private let dedicationTitleLabel = UILabel()
    private let dedicationLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configureUI()
    }

    private func configureUI() {
        dedicationTitleLabel.text = UIConstant.StringKey.dedication
        dedicationTitleLabel.font = .boldSystemFont(ofSize: UIConstant.FontSize.medium)
        dedicationTitleLabel.textColor = .black

        dedicationLabel.font = .systemFont(ofSize: UIConstant.FontSize.tiny)
        dedicationLabel.textColor = .darkGray
        dedicationLabel.numberOfLines = UIConstant.DefaultLabel.numberOfLines

        dedicationStackView.axis = .vertical
        dedicationStackView.alignment = .leading
        dedicationStackView.spacing = CGFloat(UIConstant.Spacing.small)

        [dedicationTitleLabel, dedicationLabel]
            .forEach { dedicationStackView.addArrangedSubview($0) }

        addSubview(dedicationStackView)

        dedicationStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func updateUI(with dedication: String) {
        dedicationLabel.text = dedication
    }
}
