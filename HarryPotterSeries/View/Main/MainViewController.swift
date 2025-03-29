import UIKit

final class MainViewController: UIViewController {
    private let mainView = MainView()
    private let mainViewModel = MainViewModel()

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchBooks()
    }

    /// `MainViewModel`을 통해 책 데이터를 비동기적으로 가져오는 메서드
    /// 성공했을 경우 UI를 업데이트하고, 실패했을 경우 오류 메시지 표시
    private func fetchBooks() {
        mainViewModel.fetchBooks { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success:
                DispatchQueue.main.async { self.updateUI() }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.hideMainView()
                    self.showErrorAlert(error: error)
                }
            }
        }
    }

    private func updateUI() {
        let seriesOrder = "1"

        guard let book = mainViewModel.book(by: seriesOrder) else {
            return
        }

        mainView.updateUI(with: book)
    }

    /// 책 데이터를 가져오는데 실패할 경우, 오류 메시지를 표시하는 메서드
    /// - Parameter error: 발생한 오류
    private func showErrorAlert(error: BookError) {
        AlertManager.showFetchBookError(on: self, error: error)
    }

    private func hideMainView() {
        mainView.isHidden = true
    }
}
