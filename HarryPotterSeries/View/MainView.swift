import UIKit
import SnapKit

final class MainView: UIView {
    private let bookTitleLabel = BookTitleLabel()
    private let seriesOrderButton = SeriesOrderButton()
    private let bookDetailView = BookDetailView()
    private let bookDedicationView = BookDedicationView()
    private let bookSummaryView = BookSummaryView()
    private let chapterView = ChapterView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configureUI()
    }

    private func configureUI() {
        backgroundColor = .white

        [bookTitleLabel,
         seriesOrderButton,
         bookDetailView,
         bookDedicationView,
         bookSummaryView,
         chapterView]
            .forEach { addSubview($0) }

        bookTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Layout.Inset.large)
            $0.top.equalTo(safeAreaLayoutGuide).offset(Layout.Offset.small)
        }

        seriesOrderButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bookTitleLabel.snp.bottom).offset(Layout.Offset.medium)
            $0.width.height.equalTo(Component.SeriesOrderButton.size)
        }

        bookDetailView.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(Layout.Inset.tiny)
            $0.top.equalTo(seriesOrderButton.snp.bottom).offset(Layout.Offset.large)
        }

        bookDedicationView.snp.makeConstraints {
            $0.top.equalTo(bookDetailView.snp.bottom).offset(Layout.Offset.extraLarge)
            $0.leading.trailing.equalToSuperview().inset(Layout.Inset.large)
        }

        bookSummaryView.snp.makeConstraints {
            $0.top.equalTo(bookDedicationView.snp.bottom).offset(Layout.Offset.extraLarge)
            $0.leading.trailing.equalToSuperview().inset(Layout.Inset.large)
        }

        chapterView.snp.makeConstraints {
            $0.top.equalTo(bookSummaryView.snp.bottom).offset(Layout.Offset.extraLarge)
            $0.leading.trailing.equalToSuperview().inset(Layout.Inset.large)
        }
    }

    func updateUI(with book: Book) {
        bookTitleLabel.text = book.title

        seriesOrderButton.setTitle(book.order, for: .normal)
        seriesOrderButton.isHidden = false

        bookDetailView.updateUI(with: book)

        bookDedicationView.updateUI(with: book.dedication)

        bookSummaryView.updateUI(with: book.summary)

        chapterView.updateUI(with: book.chapters)
    }
}
