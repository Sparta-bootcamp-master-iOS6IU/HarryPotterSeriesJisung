import UIKit
import SnapKit

final class MainView: UIView {
    private let bookTitleLabel = BookTitleLabel()
    private let seriesOrderButton = SeriesOrderButton()
    private let bookDetailView = BookDetailView()
    private let bookDedicationView = BookDedicationView()

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

        [bookTitleLabel, seriesOrderButton, bookDetailView, bookDedicationView]
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
    }

    func updateUI(book: Book) {
        bookTitleLabel.text = book.title

        seriesOrderButton.setTitle(book.order, for: .normal)
        seriesOrderButton.isHidden = false

        bookDetailView.updateUI(book: book)

        bookDedicationView.updateUI(with: book.dedication)
    }
}
