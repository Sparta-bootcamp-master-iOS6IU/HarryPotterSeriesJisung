import UIKit
import SnapKit

/// 책 시리즈를 선택하는 버튼을 표시하기 위한 커스텀 `UIView`
final class SeriesOrderButtonView: UIView {
    private let buttonStackView = UIStackView()

    /// 버튼 터치 시 실행할 클로저
    var onButtonTapped: ((String) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        nil
    }

    /// UI 기본 설정 메서드
    private func configureUI() {
        configureStackView()

        addSubview(buttonStackView)

        configureConstraints()
    }

    /// StackView 기본 설정 메서드
    private func configureStackView() {
        buttonStackView.configure(axis: .horizontal, alignment: .center, distribution: .equalSpacing)
    }

    /// 제약 조건 설정 메서드
    private func configureConstraints() {
        buttonStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    /// 버튼을 생성하는 메서드
    private func createButton(of seriesOrder: String) -> SeriesOrderButton {
        let button = SeriesOrderButton()
        button.updateTitle(with: seriesOrder)
        button.onButtonTapped = { [weak self] in
            self?.onButtonTapped?(seriesOrder)
        }

        return button
    }

    /// 기존 버튼을 제거하는 메서드
    private func clearAllButtons() {
        buttonStackView.arrangedSubviews
            .forEach { $0.removeFromSuperview() }
    }

    /// Button 기본 설정 메서드
    ///
    /// - Parameter booksCount: 시리즈 권수
    func configureButtons(with booksCount: Int) {
        clearAllButtons()

        for order in 1...booksCount {
            let seriesOrderButton = createButton(of: "\(order)")
            buttonStackView.addArrangedSubview(seriesOrderButton)
        }
    }

    /// Button을 업데이트 하는 메서드
    ///
    /// - Parameter seriesOrder: 시리즈 순서 문자열
    func updateButtons(by seriesOrder: String) {
        buttonStackView.arrangedSubviews.enumerated().forEach { index, subview in
            if let button = subview as? SeriesOrderButton {
                button.isSelected = "\(index + 1)" == seriesOrder
            }
        }
    }
}
