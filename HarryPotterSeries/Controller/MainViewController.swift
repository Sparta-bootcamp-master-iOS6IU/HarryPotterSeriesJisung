import UIKit
import SnapKit

final class MainViewController: UIViewController {
    var books: [Book] = []

    let bookTitleLabel = BookTitleLabel()
    let seriesOrderButton = SeriesOrderButton()
    let bookDetailView = BookDetailView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        fetchBooks()
    }

    /// BookAPIService를 통해 책 데이터를 비동기적으로 가져오는 메서드
    /// 성공했을 경우 UI를 업데이트하고, 실패했을 경우 아무 동작 없이 반환
    private func fetchBooks() {
        BookAPIService.shared.fetchBooks { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let success):
                self.books = success
                DispatchQueue.main.async { self.updateUI() }
            case .failure(let failure):
                DispatchQueue.main.async { self.showErrorAlert(error: failure) }
            }
        }
    }

    private func configureUI() {
        view.backgroundColor = .white

        [bookTitleLabel, seriesOrderButton, bookDetailView]
            .forEach { view.addSubview($0) }

        bookTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Layout.Constraints.insetStandard)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Layout.Constraints.insetTopSafeArea)
        }

        seriesOrderButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bookTitleLabel.snp.bottom).offset(Layout.Constraints.spacingBetweenTitleAndSeriesOrder)
            $0.width.height.equalTo(Component.SeriesOrderButton.size)
        }

        bookDetailView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(5)
            $0.top.equalTo(seriesOrderButton.snp.bottom).offset(20)
        }
    }

    private func updateUI() {
        guard let book = books.first else {
            return
        }

        bookTitleLabel.text = book.title

        seriesOrderButton.setTitle(book.order, for: .normal)
        seriesOrderButton.isHidden = false

        bookDetailView.updateUI(book: book)
    }

    private func showErrorAlert(error: BookAPIError) {
        let message: String

        switch error {
        case .invalidPath:
            message = Alert.Message.invalidPath
        case .jsonDecodingError:
            message = Alert.Message.jsonDecodingError
        }

        let alert = UIAlertController(title: Alert.error, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Alert.confirm, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
