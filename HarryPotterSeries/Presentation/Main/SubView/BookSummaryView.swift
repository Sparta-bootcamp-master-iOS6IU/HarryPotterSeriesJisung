import UIKit
import SnapKit

/// 요약을 표시하는 커스텀 `UIView`
final class BookSummaryView: UIView {
    private let summaryStackView = UIStackView()
    private let summaryTitleLabel = UILabel()
    private let summaryLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        nil
    }

    /// UI 기본 설정 메서드
    private func configureUI() {
        configureLabels()

        configureStackView()

        addSubview(summaryStackView)

        configureConstraints()
    }

    /// Label 기본 설정 메서드
    private func configureLabels() {
        summaryTitleLabel.configure(
            text: UIConstant.StringKey.summary,
            font: .boldSystemFont(ofSize: UIConstant.FontSize.medium),
            textColor: .black
        )

        summaryLabel.configure(
            font: .systemFont(ofSize: UIConstant.FontSize.tiny),
            textColor: .darkGray,
            numberOfLines: UIConstant.DefaultLabel.numberOfLines
        )
    }

    /// StackView 기본 설정 메서드
    private func configureStackView() {
        summaryStackView.configure(axis: .vertical, alignment: .leading, spacing: UIConstant.Spacing.small)

        [summaryTitleLabel, summaryLabel]
            .forEach { summaryStackView.addArrangedSubview($0) }
    }

    /// 제약 조건 설정 메서드
    private func configureConstraints() {
        summaryStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    /// Summary를 업데이트 하는 메서드
    /// 
    /// - Parameter summary: 변경할 Summary 문자열
    func updateSummary(with summary: String) {
        summaryLabel.text = summary
    }
}
