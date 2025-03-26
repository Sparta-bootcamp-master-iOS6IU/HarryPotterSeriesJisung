import UIKit
import SnapKit

class MainViewController: UIViewController {
    var books: [Book] = []

    let bookTitleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let books = BookAPIService.shared.fetchBooks() {
            self.books = books
        }

        configureUI()
    }

    private func configureUI() {
        view.backgroundColor = .white

        bookTitleLabel.text = books[0].title
        bookTitleLabel.font = .boldSystemFont(ofSize: CGFloat(Layout.FontSize.large))
        bookTitleLabel.textAlignment = .center
        bookTitleLabel.numberOfLines = 2

        view.addSubview(bookTitleLabel)

        bookTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Layout.Constraints.insetStandard)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                .offset(Layout.Constraints.spacingBetweenTitleAndSeriesOrder)
        }
    }
}
