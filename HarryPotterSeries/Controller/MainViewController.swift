import UIKit

final class MainViewController: UIViewController {
    private let mainView = MainView()

    private var books: [Book] = []

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchBooks()
    }

    /// BookAPIService를 통해 책 데이터를 비동기적으로 가져오는 메서드
    /// 성공했을 경우 UI를 업데이트하고, 실패했을 경우 오류 메시지 표시
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

    private func updateUI() {
        guard let book = books.first else {
            return
        }

        mainView.updateUI(book: book)
    }

    /// 책 데이터를 가져오는데 실패할 경우, 오류 메시지를 표시하는 메서드
    /// - Parameter error: 발생한 오류
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
