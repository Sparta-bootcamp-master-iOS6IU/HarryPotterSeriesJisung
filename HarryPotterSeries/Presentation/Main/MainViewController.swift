import UIKit
import SnapKit

/// Custom View들을 배치하고, 시리즈 내 다른 책을 선택할 수 있도록 하는 화면 담당
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

        configureViewModelBindings()

        configurButtoneBindings()

        mainViewModel.fetchBooks()
    }

    // MARK: - UI

    /// UI 기본 설정 메서드
    private func configureUI() {
        view.backgroundColor = .white

        scrollView.showsVerticalScrollIndicator = false

        configureSubviews()

        configureConstraints()
    }

    /// Subview 기본 설정 메서드
    private func configureSubviews() {
        [bookTitleLabel, seriesOrderButtonView, scrollView]
            .forEach { view.addSubview($0) }

        scrollView.addSubview(scrollContentView)

        [bookDetailView, bookDedicationView, bookSummaryView, summaryToggleButton, chapterView]
            .forEach { scrollContentView.addSubview($0) }
    }

    /// 제약 조건 설정 메서드
    private func configureConstraints() {
        bookTitleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(UIConstant.Inset.large)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(UIConstant.Offset.small)
        }

        seriesOrderButtonView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
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
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(UIConstant.Inset.large)
        }

        bookSummaryView.snp.makeConstraints {
            $0.top.equalTo(bookDedicationView.snp.bottom).offset(UIConstant.Offset.extraLarge)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(UIConstant.Inset.large)
        }

        summaryToggleButton.snp.makeConstraints {
            $0.top.equalTo(bookSummaryView.snp.bottom)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(UIConstant.Inset.large)
        }

        chapterView.snp.makeConstraints {
            $0.top.equalTo(summaryToggleButton.snp.bottom).offset(UIConstant.Offset.extraLarge)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(UIConstant.Inset.large)
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: - Bindings

    /// ViewModel과의 데이터 바인딩 설정 메서드
    private func configureViewModelBindings() {
        mainViewModel.onBooksUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.updateSeriesOrderButtons()
                self?.updateUI()
            }
        }

        mainViewModel.onBookSelected = { [weak self] in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }

        mainViewModel.onFetchError = { [weak self] error in
            DispatchQueue.main.async {
                self?.showErrorAlert(error: error)
            }
        }
    }

    /// 버튼 액션 설정 메서드
    private func configurButtoneBindings() {
        summaryToggleButton.onButtonTapped = { [weak self] in
            self?.mainViewModel.toggleExpandedState()

            self?.updateSummary()
        }

        seriesOrderButtonView.onButtonTapped = { [weak self] seriesOrder in
            self?.mainViewModel.selectBook(at: seriesOrder)
        }
    }

    // MARK: UI Update

    /// UI 업데이트 메서드
    ///
    /// 시리즈 순서 버튼과 현재 선택된 책 정보 업데이트
    private func updateUI() {
        guard let book = mainViewModel.selectedBook else { return }

        updateBook(with: book)

        updateSeriesOrderButtonStates(by: book.seriesOrder)
    }

    /// 현재 선택된 책의 정보로 변경하는 메서드
    private func updateBook(with book: Book) {
        updateBookTitle(with: book.title)

        updateBookDetail(with: book)

        updateBookDedication(with: book.dedication)

        updateChapters(with: book.chapters)

        updateSummary()
    }

    /// 책 시리즈 버튼 설정 메서드
    ///
    /// 시리즈 권수만큼의 버튼을 생성하는 메서드
    private func updateSeriesOrderButtons() {
        seriesOrderButtonView.configureButtons(with: mainViewModel.books.count)
    }

    /// 시리즈 순서 버튼의 상태를 변경하기 위한 메서드
    ///
    /// - Parameter seriesOrder: 시리즈 순서 문자열
    private func updateSeriesOrderButtonStates(by seriesOrder: String) {
        seriesOrderButtonView.updateButtons(by: seriesOrder)
    }

    /// 책 제목을 업데이트 하는 메서드
    ///
    /// - Parameter title: 책 제목 문자열
    private func updateBookTitle(with title: String) {
        bookTitleLabel.text = title
    }

    /// 책 정보를 업데이트 하는 메서드
    ///
    /// - Parameter book: 책 데이터
    private func updateBookDetail(with book: Book) {
        bookDetailView.updateUI(with: book)
    }

    /// 헌정사를 업데이트 하는 메서드
    ///
    /// - Parameter dedication:헌정사 문자열
    private func updateBookDedication(with dedication: String) {
        bookDedicationView.updateUI(with: dedication)
    }

    /// 챕터 목록을 업데이트 하는 메서드
    ///
    /// - Parameter chapters: 챕터 문자열 배열
    private func updateChapters(with chapters: [String]) {
        chapterView.updateUI(with: chapters)
    }

    /// Summary 정보를 업데이트 하는 메서드
    private func updateSummary() {
        guard let (summary, buttonTitle) = mainViewModel.summary() else { return }

        bookSummaryView.updateSummary(with: summary)
        summaryToggleButton.updateButton(with: buttonTitle)
    }

    /// 책 데이터를 가져오는데 실패할 경우, 오류 메시지를 표시하는 메서드
    ///
    /// - Parameter error: 발생한 오류
    private func showErrorAlert(error: BookDataSourceError) {
        AlertManager.showFetchBookError(on: self, error: error)
    }
}
