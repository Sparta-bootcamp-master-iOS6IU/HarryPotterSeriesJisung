import UIKit

final class SeriesOrderButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configureUI()
    }

    private func configureUI() {
        titleLabel?.textAlignment = .center
        titleLabel?.font = UIFont.systemFont(ofSize: UIConstant.FontSize.small)
        layer.cornerRadius = CGFloat(UIConstant.SeriesOrderButton.radius)
        backgroundColor = .systemBlue
        isHidden = true
    }
}
