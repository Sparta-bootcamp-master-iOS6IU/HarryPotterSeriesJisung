import UIKit

final class SummaryToggleButton: UIButton {
    var onButtonTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        nil
    }

    private func configureUI() {
        titleLabel?.textAlignment = .center
        titleLabel?.font = UIFont.systemFont(ofSize: UIConstant.FontSize.tiny)
        setTitleColor(.systemBlue, for: .normal)
        backgroundColor = .clear
    }

    func updateTitle(with title: String) {
        setTitle(title, for: .normal)
    }

    private func configureBindings() {
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc private func buttonTapped() {
        onButtonTapped?()
    }
}
