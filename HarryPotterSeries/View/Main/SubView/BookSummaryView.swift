import UIKit
import SnapKit

final class BookSummaryView: UIView {
    private let summaryStackView = UIStackView()
    private let summaryTitleLabel = UILabel()
    private let summaryLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configureUI()
    }

    private func configureUI() {
        summaryTitleLabel.text = StringKey.summary
        summaryTitleLabel.font = .boldSystemFont(ofSize: CGFloat(Font.Size.medium))
        summaryTitleLabel.textColor = .black

        summaryLabel.font = .systemFont(ofSize: CGFloat(Font.Size.tiny))
        summaryLabel.textColor = .darkGray
        summaryLabel.numberOfLines = Component.DefaultLabel.numberOfLines

        summaryStackView.axis = .vertical
        summaryStackView.alignment = .leading
        summaryStackView.spacing = CGFloat(Layout.Spacing.small)

        [summaryTitleLabel, summaryLabel]
            .forEach { summaryStackView.addArrangedSubview($0) }

        addSubview(summaryStackView)

        summaryStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func updateUI(with summary: String) {
        summaryLabel.text = summary
    }
}
