import UIKit

/// Summary를 접거나 펼치는 커스텀 `UIButton`
final class SummaryToggleButton: UIButton {
    /// 버튼 터치 시 실행할 클로저
    var onButtonTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()

        configureActions()
    }

    required init?(coder: NSCoder) {
        nil
    }

    /// UI 기본 설정 메서드
    private func configureUI() {
        titleLabel?.textAlignment = .center
        titleLabel?.font = UIFont.systemFont(ofSize: UIConstant.FontSize.tiny)
        setTitleColor(.systemBlue, for: .normal)
        backgroundColor = .clear
    }

    /// 버튼 액션 설정 메서드
    private func configureActions() {
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    /// 버튼 타이틀을 업데이트하는 메서드
    /// 
    /// - Parameter title: 변경할 버튼 타이틀
    func updateTitle(with title: String) {
        setTitle(title, for: .normal)
    }

    /// 버튼이 터치 시 호출 메서드
    @objc private func buttonTapped() {
        onButtonTapped?()
    }
}
