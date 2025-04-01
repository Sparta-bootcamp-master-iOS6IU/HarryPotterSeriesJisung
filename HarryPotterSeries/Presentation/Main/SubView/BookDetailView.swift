import UIKit
import SnapKit

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

    private func configureUI() {
        imageView.contentMode = .scaleAspectFit

        configureLabels()
        configureStackViews()

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

        addSubview(detailContainerStackView)

        configureConstraints()
    }

    private func configureLabels() {
        titleLabel.font = .boldSystemFont(ofSize: UIConstant.FontSize.large)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = UIConstant.DefaultLabel.numberOfLines

        authorTitleLabel.text = UIConstant.StringKey.author
        authorTitleLabel.font = .boldSystemFont(ofSize: UIConstant.FontSize.small)
        authorTitleLabel.textColor = .black

        authorLabel.font = .systemFont(ofSize: UIConstant.FontSize.medium)
        authorLabel.textColor = .darkGray

        releasedTitleLabel.text = UIConstant.StringKey.released
        releasedTitleLabel.font = .boldSystemFont(ofSize: UIConstant.FontSize.tiny)
        releasedTitleLabel.textColor = .black

        releasedLabel.font = .systemFont(ofSize: UIConstant.FontSize.tiny)
        releasedLabel.textColor = .gray

        pagesTitleLabel.text = UIConstant.StringKey.pages
        pagesTitleLabel.font = .boldSystemFont(ofSize: UIConstant.FontSize.tiny)
        pagesTitleLabel.textColor = .black

        pagesLabel.font = .systemFont(ofSize: UIConstant.FontSize.tiny)
        pagesLabel.textColor = .gray
    }

    private func configureStackViews() {
        detailContainerStackView.axis = .horizontal
        detailContainerStackView.alignment = .top
        detailContainerStackView.distribution = .equalSpacing

        detailStackView.axis = .vertical
        detailStackView.alignment = .leading
        detailStackView.distribution = .equalSpacing

        configureHorizontalStackview(authorStackView)
        configureHorizontalStackview(releasedStackView)
        configureHorizontalStackview(pagesStackView)
    }

    private func configureHorizontalStackview(_ stackView: UIStackView) {
        stackView.axis = .horizontal
        stackView.spacing = UIConstant.Spacing.small
        stackView.alignment = .center
    }

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

    func updateUI(with book: Book) {
        imageView.image = UIImage(named: book.image)
        titleLabel.text = book.title
        authorLabel.text = book.author
        releasedLabel.text = book.releaseDate
        pagesLabel.text = book.pages
    }
}
