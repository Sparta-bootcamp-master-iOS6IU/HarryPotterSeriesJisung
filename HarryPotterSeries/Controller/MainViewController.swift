import UIKit
import SnapKit

class MainViewController: UIViewController {
    var books: [Book] = []

    let bookTitleLabel = UILabel()
    let seriesOrderButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchBooks()

        configureUI()
    }

    /// 책 데이터를 가져오고 `books` 프로퍼티 업데이트하는 메서드
    /// 데이터를 가져오는데 실패하면 함수 종료
    private func fetchBooks() {
        switch BookAPIService.shared.fetchBooks() {
        case .success(let success):
            books = success
        case .failure(let failure):
            return
        }
    }

    /// UI 설정 함수
    private func configureUI() {
        view.backgroundColor = .white

        bookTitleLabel.text = books[0].title
        bookTitleLabel.font = .boldSystemFont(ofSize: CGFloat(Layout.FontSize.large))
        bookTitleLabel.textAlignment = .center
        bookTitleLabel.numberOfLines = 2

        seriesOrderButton.setTitle(books[0].order, for: .normal)
        seriesOrderButton.titleLabel?.textAlignment = .center
        seriesOrderButton.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(Layout.FontSize.small))
        seriesOrderButton.layer.cornerRadius = CGFloat(Layout.SeriesOrderButton.radius)
        seriesOrderButton.backgroundColor = .systemBlue

        [bookTitleLabel, seriesOrderButton]
            .forEach { view.addSubview($0) }

        bookTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Layout.Constraints.insetStandard)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Layout.Constraints.insetTopSafeArea)
        }

        seriesOrderButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bookTitleLabel.snp.bottom).offset(Layout.Constraints.spacingBetweenTitleAndSeriesOrder)
            $0.width.height.equalTo(Layout.SeriesOrderButton.size)
        }
    }
}
