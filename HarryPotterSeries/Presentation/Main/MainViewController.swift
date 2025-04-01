import UIKit
import SnapKit

final class MainViewController: UIViewController {
    private let bookTitleLabel = BookTitleLabel()
    private let seriesOrderButtonView = SeriesOrderButtonView()
    private let scrollView = UIScrollView()
    private let scrollContentView = UIView()
    private let bookDetailView = BookDetailView()
    private let bookDedicationView = BookDedicationView()
    private let bookSummaryView = BookSummaryView()
    private let summaryToggleButton = SummaryToggleButton()
    private let chapterView = ChapterView()

    private let mainViewModel: MainViewModel

    init(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()

        mainViewModel.onBookSelected = { [weak self] book in
            DispatchQueue.main.async {
                self?.updateBook(with: book)
            }
        }

        fetchBooks()

        configureBindings()
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

    private func configureUI() {
        view.backgroundColor = .white

        scrollView.showsVerticalScrollIndicator = false

        [bookTitleLabel, seriesOrderButtonView, scrollView]
            .forEach { view.addSubview($0) }

        scrollView.addSubview(scrollContentView)

        [bookDetailView, bookDedicationView, bookSummaryView, summaryToggleButton, chapterView]
            .forEach { scrollContentView.addSubview($0) }

        bookTitleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(UIConstant.Inset.large)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(UIConstant.Offset.small)
        }

        seriesOrderButtonView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(UIConstant.Inset.extraLarge)
            $0.top.equalTo(bookTitleLabel.snp.bottom).offset(UIConstant.Offset.medium)
        }

        scrollView.snp.makeConstraints {
            $0.top.equalTo(seriesOrderButtonView.snp.bottom).offset(UIConstant.Offset.large)
            $0.horizontalEdges.bottom.equalToSuperview()
        }

        scrollContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        bookDetailView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(UIConstant.Inset.tiny)
        }

        bookDedicationView.snp.makeConstraints {
            $0.top.equalTo(bookDetailView.snp.bottom).offset(UIConstant.Offset.extraLarge)
            $0.horizontalEdges.equalToSuperview().inset(UIConstant.Inset.large)
        }

        bookSummaryView.snp.makeConstraints {
            $0.top.equalTo(bookDedicationView.snp.bottom).offset(UIConstant.Offset.extraLarge)
            $0.horizontalEdges.equalToSuperview().inset(UIConstant.Inset.large)
        }

        summaryToggleButton.snp.makeConstraints {
            $0.top.equalTo(bookSummaryView.snp.bottom)
            $0.trailing.equalToSuperview().inset(UIConstant.Inset.large)
        }

        chapterView.snp.makeConstraints {
            $0.top.equalTo(summaryToggleButton.snp.bottom).offset(UIConstant.Offset.extraLarge)
            $0.horizontalEdges.equalToSuperview().inset(UIConstant.Inset.large)
            $0.bottom.equalToSuperview()
        }
    }

    private func updateUI() {
        guard let book = mainViewModel.selectedBook else { return }

        seriesOrderButtonView.updateUI(with: mainViewModel.books.count)

        updateBook(with: book)
    }

    private func updateBook(with book: Book?) {
        guard let book = mainViewModel.selectedBook else { return }

        bookTitleLabel.text = book.title

        bookDetailView.updateUI(with: book)

        bookDedicationView.updateUI(with: book.dedication)

        chapterView.updateUI(with: book.chapters)

        updateSummary()

        updateSeriesOrderButton(by: book.seriesOrder)
    }

    private func updateSeriesOrderButton(by seriesOrder: String) {
        seriesOrderButtonView.updateSeriesOrderButton(by: seriesOrder)
    }

    /// Summary 정보를 업데이트 하는 메서드
    private func updateSummary() {
        guard let (summary, buttonTitle) = mainViewModel.summary() else { return }

        bookSummaryView.updateSummary(with: summary)
        summaryToggleButton.updateTitle(with: buttonTitle)
    }

    /// 버튼 액션 설정을 바인딩하는 메서드
    private func configureBindings() {
        configureToggleSummaryButtonTarget(target: self, action: #selector(toggleSummaryButtonTapped))

        seriesOrderButtonView.onButtonTapped = { [weak self] seriesOrder in
            self?.mainViewModel.selectBook(at: seriesOrder)
        }
    }

    /// 책 데이터를 가져오는데 실패할 경우, 오류 메시지를 표시하는 메서드
    /// - Parameter error: 발생한 오류
    private func showErrorAlert(error: BookDataSourceError) {
        AlertManager.showFetchBookError(on: self, error: error)
    }

    private func hideMainView() {
        view.isHidden = true
    }

    /// 접기/더보기 버튼 터치 이벤트 액션 설정 메서드
    /// - Parameters:
    ///   - target: 이벤트를 받을 객체
    ///   - action: 실행될 액션
    func configureToggleSummaryButtonTarget(target: Any, action: Selector) {
        summaryToggleButton.addTarget(target, action: action, for: .touchUpInside)
    }

    @objc func toggleSummaryButtonTapped() {
        mainViewModel.toggleExpandedState()

        updateSummary()
    }
}
