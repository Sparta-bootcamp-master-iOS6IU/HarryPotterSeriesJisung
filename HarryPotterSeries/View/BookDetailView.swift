import UIKit
import SnapKit

final class BookDetailView: UIView {
    private let mainStackView = UIStackView()
    private let verticalStackView = UIStackView()
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
        super.init(coder: coder)

        configureUI()
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
            .forEach { verticalStackView.addArrangedSubview($0) }

        [imageView, verticalStackView]
            .forEach { mainStackView.addArrangedSubview($0) }

        addSubview(mainStackView)

        setConstraints()
    }

    private func configureLabels() {
        titleLabel.font = .boldSystemFont(ofSize: CGFloat(Font.Size.large))
        titleLabel.textColor = .black
        titleLabel.numberOfLines = Component.DefaultLabel.numberOfLines

        authorTitleLabel.font = .boldSystemFont(ofSize: CGFloat(Font.Size.small))
        authorTitleLabel.textColor = .black

        authorLabel.font = .systemFont(ofSize: CGFloat(Font.Size.medium))
        authorLabel.textColor = .darkGray

        releasedTitleLabel.font = .boldSystemFont(ofSize: CGFloat(Font.Size.tiny))
        releasedTitleLabel.textColor = .black

        releasedLabel.font = .systemFont(ofSize: CGFloat(Font.Size.tiny))
        releasedLabel.textColor = .gray

        pagesTitleLabel.font = .boldSystemFont(ofSize: CGFloat(Font.Size.tiny))
        pagesTitleLabel.textColor = .black

        pagesLabel.font = .systemFont(ofSize: CGFloat(Font.Size.tiny))
        pagesLabel.textColor = .gray
    }

    private func configureStackViews() {
        mainStackView.axis = .horizontal
        mainStackView.alignment = .top
        mainStackView.distribution = .equalSpacing

        verticalStackView.axis = .vertical
        verticalStackView.alignment = .leading
        verticalStackView.distribution = .equalSpacing

        configureHorizontalStackview(authorStackView)
        configureHorizontalStackview(releasedStackView)
        configureHorizontalStackview(pagesStackView)
    }

    private func configureHorizontalStackview(_ stackView: UIStackView) {
        stackView.axis = .horizontal
        stackView.spacing = CGFloat(Layout.Spacing.small)
        stackView.alignment = .center
    }

    private func setConstraints() {
        mainStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Layout.Inset.large)
        }

        imageView.snp.makeConstraints {
            $0.width.equalTo(Component.BookImage.width)
            $0.height.equalTo(imageView.snp.width).multipliedBy(Component.BookImage.aspectRatio)
        }

        verticalStackView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(Layout.verticalStackViewHeightMultiplier)
            $0.leading.equalTo(imageView.snp.trailing).offset(Layout.Offset.large)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
        }
    }

    func updateUI(book: Book) {
        imageView.image = UIImage(named: book.image)

        titleLabel.text = book.title

        authorTitleLabel.text = StringKey.author
        authorLabel.text = book.author

        releasedTitleLabel.text = StringKey.released
        releasedLabel.text = book.releaseDate

        pagesTitleLabel.text = StringKey.pages
        pagesLabel.text = "\(book.pages)"
    }
}
