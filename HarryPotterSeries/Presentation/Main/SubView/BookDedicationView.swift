import UIKit
import SnapKit

/// 헌정사를 표시하는 커스텀 `UIView`
final class BookDedicationView: UIView {
    private let dedicationStackView = UIStackView()
    private let dedicationTitleLabel = UILabel()
    private let dedicationLabel = UILabel()

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

        addSubview(dedicationStackView)

        configureConstraints()
    }

    /// Label 기본 설정 메서드
    private func configureLabels() {
        dedicationTitleLabel.text = UIConstant.StringKey.dedication
        dedicationTitleLabel.font = .boldSystemFont(ofSize: UIConstant.FontSize.medium)
        dedicationTitleLabel.textColor = .black

        dedicationLabel.font = .systemFont(ofSize: UIConstant.FontSize.tiny)
        dedicationLabel.textColor = .darkGray
        dedicationLabel.numberOfLines = UIConstant.DefaultLabel.numberOfLines
    }

    /// StackView 기본 설정 메서드
    private func configureStackView() {
        dedicationStackView.axis = .vertical
        dedicationStackView.alignment = .leading
        dedicationStackView.spacing = CGFloat(UIConstant.Spacing.small)

        [dedicationTitleLabel, dedicationLabel]
            .forEach { dedicationStackView.addArrangedSubview($0) }
    }

    /// 제약 조건 설정 메서드
    private func configureConstraints() {
        dedicationStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    /// 헌정사 내용을 업데이트 하는 메서드
    /// 
    /// - Parameter dedication: 변경할 헌정사 문자열
    func updateUI(with dedication: String) {
        dedicationLabel.text = dedication
    }
}
