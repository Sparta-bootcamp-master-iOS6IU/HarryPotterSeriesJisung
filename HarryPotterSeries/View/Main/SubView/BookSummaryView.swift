import UIKit
import SnapKit

final class BookSummaryView: UIView {
    private let summaryStackView = UIStackView()
    private let summaryTitleLabel = UILabel()
    private let summaryLabel = UILabel()

    private var isExpand = false
    private var summary = ""

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configureUI()
    }

    private func configureUI() {
        summaryTitleLabel.text = UIConstant.StringKey.summary
        summaryTitleLabel.font = .boldSystemFont(ofSize: UIConstant.FontSize.medium)
        summaryTitleLabel.textColor = .black

        summaryLabel.font = .systemFont(ofSize: UIConstant.FontSize.tiny)
        summaryLabel.textColor = .darkGray
        summaryLabel.numberOfLines = UIConstant.DefaultLabel.numberOfLines

        summaryStackView.axis = .vertical
        summaryStackView.alignment = .leading
        summaryStackView.spacing = UIConstant.Spacing.small

        [summaryTitleLabel, summaryLabel]
            .forEach { summaryStackView.addArrangedSubview($0) }

        addSubview(summaryStackView)

        summaryStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func updateUI(with summary: String) {
        self.summary = summary
        collapse()
    }

    private func collapse() {
        let ellipsis = String(summary.prefix(UIConstant.Summary.ellipsisThreshold)) + UIConstant.Summary.ellipsis
        summaryLabel.text = ellipsis
    }

    func switchText() {
        if isExpand {
            collapse()
        } else {
            summaryLabel.text = summary
        }

        isExpand.toggle()
    }
}
