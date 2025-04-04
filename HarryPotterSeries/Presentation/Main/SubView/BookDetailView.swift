import UIKit
import SnapKit

/// 상세 정보를 표시하는 커스텀 `UIView`
final class BookDetailView: UIView {
    private let detailContainerStackView = UIStackView()
    private let detailStackView = UIStackView()
    private let authorStackView = UIStackView()
    private let releasedStackView = UIStackView()
    private let pagesStackView = UIStackView()

    private let imageView = UIImageView()
    private let titleLabel = UILabel()

    private let authorTitleLabel = UILabel()
    private let authorLabel = UILabel()

    private let releasedTitleLabel = UILabel()
    private let releasedLabel = UILabel()

    private let pagesTitleLabel = UILabel()
    private let pagesLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        nil
    }

    /// UI 기본 설정 메서드
    private func configureUI() {
        configureImageView()

        configureLabels()

        configureStackViews()

        addSubview(detailContainerStackView)

        configureConstraints()
    }

    /// 이미지 기본 설정 메서드
    private func configureImageView() {
        imageView.contentMode = .scaleAspectFit
    }

    /// Label 기본 설정 메서드
    private func configureLabels() {
        titleLabel.configure(
            font: .boldSystemFont(ofSize: UIConstant.FontSize.large),
            textColor: .black,
            numberOfLines: UIConstant.DefaultLabel.numberOfLines
        )

        authorTitleLabel.configure(
            text: UIConstant.StringKey.author,
            font: .boldSystemFont(ofSize: UIConstant.FontSize.small),
            textColor: .black
        )
        authorLabel.configure(font: .systemFont(ofSize: UIConstant.FontSize.medium), textColor: .darkGray)

        releasedTitleLabel.configure(
            text: UIConstant.StringKey.released,
            font: .boldSystemFont(ofSize: UIConstant.FontSize.tiny),
            textColor: .black
        )
        releasedLabel.configure(font: .systemFont(ofSize: UIConstant.FontSize.tiny), textColor: .gray)

        pagesTitleLabel.configure(
            text: UIConstant.StringKey.pages,
            font: .boldSystemFont(ofSize: UIConstant.FontSize.tiny),
            textColor: .black)
        pagesLabel.configure(font: .systemFont(ofSize: UIConstant.FontSize.tiny), textColor: .gray)
    }

    /// StackView 기본 설정 메서드
    private func configureStackViews() {
        detailContainerStackView.configure(axis: .horizontal, alignment: .top, distribution: .equalSpacing)
        detailStackView.configure(axis: .vertical, alignment: .leading, distribution: .equalSpacing)

        [authorStackView, releasedStackView, pagesStackView]
            .forEach { $0.configure(axis: .horizontal, alignment: .center, spacing: UIConstant.Spacing.small) }

        [authorTitleLabel, authorLabel]
            .forEach { authorStackView.addArrangedSubview($0) }

        [releasedTitleLabel, releasedLabel]
            .forEach { releasedStackView.addArrangedSubview($0) }

        [pagesTitleLabel, pagesLabel]
            .forEach { pagesStackView.addArrangedSubview($0) }

        [titleLabel, authorStackView, releasedStackView, pagesStackView]
            .forEach { detailStackView.addArrangedSubview($0) }

        [imageView, detailStackView]
            .forEach { detailContainerStackView.addArrangedSubview($0) }
    }

    /// 제약 조건 설정 메서드
    private func configureConstraints() {
        detailContainerStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(UIConstant.Inset.medium)
            $0.verticalEdges.equalToSuperview()
        }

        imageView.snp.makeConstraints {
            $0.width.equalTo(UIConstant.BookImage.width)
            $0.height.equalTo(imageView.snp.width).multipliedBy(UIConstant.BookImage.aspectRatio)
        }

        detailStackView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(UIConstant.verticalStackViewHeightMultiplier)
            $0.leading.equalTo(imageView.snp.trailing).offset(UIConstant.Offset.large)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
        }
    }

    /// 상세 정보를 업데이트 하는 메서드
    /// 
    /// - Parameter book: 변경할 Book 객체
    func updateUI(with book: Book) {
        imageView.image = UIImage(named: book.image)
        titleLabel.text = book.title
        authorLabel.text = book.author
        releasedLabel.text = book.releaseDate
        pagesLabel.text = book.pages
    }
}
