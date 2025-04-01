import UIKit
import SnapKit

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

    private func configureUI() {
        chaptersTitleLabel.text = UIConstant.StringKey.chapters
        chaptersTitleLabel.font = .boldSystemFont(ofSize: UIConstant.FontSize.medium)
        chaptersTitleLabel.textColor = .black

        chaptersStackView.axis = .vertical
        chaptersStackView.alignment = .leading
        chaptersStackView.spacing = UIConstant.Spacing.small

        [chaptersTitleLabel]
            .forEach { chaptersStackView.addArrangedSubview($0) }

        addSubview(chaptersStackView)

        chaptersStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func createChapterLabel(from title: String) -> UILabel {
        let chapterLabel = UILabel()

        chapterLabel.text = title
        chapterLabel.font = .systemFont(ofSize: UIConstant.FontSize.tiny)
        chapterLabel.textColor = .darkGray

        return chapterLabel
    }

    func updateUI(with chapters: [String]) {
        deleteAllSubvies()

        chapters.forEach {
            let chapterLabel = createChapterLabel(from: $0)

            chaptersStackView.addArrangedSubview(chapterLabel)
        }
    }

    func deleteAllSubvies() {
        chaptersStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
