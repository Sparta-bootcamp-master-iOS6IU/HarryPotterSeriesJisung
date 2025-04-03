import UIKit
import SnapKit

final class MainView: UIView {
    private let bookTitleLabel = BookTitleLabel()
    private let seriesOrderButton = SeriesOrderButton()
    private let scrollView = UIScrollView()
    private let scrollContentView = UIView()
    private let bookDetailView = BookDetailView()
    private let bookDedicationView = BookDedicationView()
    private let bookSummaryView = BookSummaryView()
    private let summaryToggleButton = SummaryToggleButton()
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

        scrollView.showsVerticalScrollIndicator = false

        [bookTitleLabel, seriesOrderButton, scrollView]
            .forEach { addSubview($0) }

        scrollView.addSubview(scrollContentView)

        [bookDetailView, bookDedicationView, bookSummaryView, summaryToggleButton, chapterView]
            .forEach { scrollContentView.addSubview($0) }

        bookTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(UIConstant.Inset.large)
            $0.top.equalTo(safeAreaLayoutGuide).offset(UIConstant.Offset.small)
        }

        seriesOrderButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bookTitleLabel.snp.bottom).offset(UIConstant.Offset.medium)
            $0.width.height.equalTo(UIConstant.SeriesOrderButton.size)
        }

        scrollView.snp.makeConstraints {
            $0.top.equalTo(seriesOrderButton.snp.bottom).offset(UIConstant.Offset.large)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        scrollContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        bookDetailView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(UIConstant.Inset.tiny)
        }

        bookDedicationView.snp.makeConstraints {
            $0.top.equalTo(bookDetailView.snp.bottom).offset(UIConstant.Offset.extraLarge)
            $0.leading.trailing.equalToSuperview().inset(UIConstant.Inset.large)
        }

        bookSummaryView.snp.makeConstraints {
            $0.top.equalTo(bookDedicationView.snp.bottom).offset(UIConstant.Offset.extraLarge)
            $0.leading.trailing.equalToSuperview().inset(UIConstant.Inset.large)
        }

        summaryToggleButton.snp.makeConstraints {
            $0.top.equalTo(bookSummaryView.snp.bottom)
            $0.trailing.equalToSuperview().inset(UIConstant.Inset.large)
        }

        chapterView.snp.makeConstraints {
            $0.top.equalTo(summaryToggleButton.snp.bottom).offset(UIConstant.Offset.extraLarge)
            $0.leading.trailing.equalToSuperview().inset(UIConstant.Inset.large)
            $0.bottom.equalToSuperview()
        }
    }

    func updateUI(with book: Book) {
        bookTitleLabel.text = book.title

        seriesOrderButton.setTitle(book.seriesOrder, for: .normal)
        seriesOrderButton.isHidden = false

        bookDetailView.updateUI(with: book)

        bookDedicationView.updateUI(with: book.dedication)

        chapterView.updateUI(with: book.chapters)
    }
    
    /// Summary 정보를 업데이트하는 메서드
    /// - Parameters:
    ///   - summary: Summary 문자열
    ///   - buttonTitle: 버튼에 표시될 문자열
    func updateSummary(with summary: String, _ buttonTitle: String) {
        bookSummaryView.updateSummary(with: summary)
        summaryToggleButton.updateTitle(with: buttonTitle)
    }
    
    /// 접기/더보기 버튼 터치 이벤트 액션 설정 메서드
    /// - Parameters:
    ///   - target: 이벤트를 받을 객체
    ///   - action: 실행될 액션
    func configureToggleSummaryButtonTarget(target: Any, action: Selector) {
        summaryToggleButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
