import UIKit
import SnapKit

/// 챕터를 표시하는 커스텀 `UIView`
final class ChapterView: UIView {
    private let chaptersStackView = UIStackView()
    private let chaptersTitleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        nil
    }

    /// UI 기본 설정 메서드
    private func configureUI() {
        configureLabel()

        configureStackView()

        addSubview(chaptersStackView)

        configureConstraints()
    }

    /// Label 기본 설정 메서드
    private func configureLabel() {
        chaptersTitleLabel.configure(
            text: UIConstant.StringKey.chapters,
            font: .boldSystemFont(ofSize: UIConstant.FontSize.medium),
            textColor: .black
        )
    }

    /// StackView 기본 설정 메서드
    private func configureStackView() {
        chaptersStackView.configure(axis: .vertical, alignment: .leading, spacing: UIConstant.Spacing.small)

        chaptersStackView.addArrangedSubview(chaptersTitleLabel)
    }

    /// 제약 조건 설정 메서드
    private func configureConstraints() {
        chaptersStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    /// 챕터 Label을 생성하는 메서드
    ///
    /// - Parameter title: 챕터 문자열
    /// - Returns: 설정된 `UILabel` 인스턴스
    private func createChapterLabel(from title: String) -> UILabel {
        let chapterLabel = UILabel()
        chapterLabel.configure(text: title, font: .systemFont(ofSize: UIConstant.FontSize.tiny), textColor: .darkGray)

        return chapterLabel
    }

    /// 기존 챕터 목록을 모두 삭제하는 메서드
    private func clearAllChapterLabel() {
        chaptersStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }

    /// 챕터 목록을 업데이트하는 메서드
    /// 
    /// - Parameter chapters: 챕터 문자열 배열
    func updateUI(with chapters: [String]) {
        clearAllChapterLabel()

        chapters.forEach {
            let chapterLabel = createChapterLabel(from: $0)
            chaptersStackView.addArrangedSubview(chapterLabel)
        }
    }
}
