import UIKit
import SnapKit

final class SeriesOrderButton: UIButton {
    var onButtonTapped: (() -> Void)?

    override var isSelected: Bool {
        didSet {
            updateUI()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()

        configureBindings()
    }

    required init?(coder: NSCoder) {
        nil
    }

    private func configureUI() {
        titleLabel?.textAlignment = .center
        titleLabel?.font = UIFont.systemFont(ofSize: UIConstant.FontSize.small)
        layer.cornerRadius = UIConstant.SeriesOrderButton.radius

        snp.makeConstraints {
            $0.width.height.equalTo(UIConstant.SeriesOrderButton.size)
        }
    }

    private func configureBindings() {
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    private func updateUI() {
        backgroundColor = isSelected ? .systemBlue : .systemGray5
        setTitleColor(isSelected ? .white : .systemBlue, for: .normal)
    }

    func updateTitle(with seriesOrder: String) {
        setTitle(seriesOrder, for: .normal)
    }

    @objc private func buttonTapped() {
        onButtonTapped?()
    }
}
