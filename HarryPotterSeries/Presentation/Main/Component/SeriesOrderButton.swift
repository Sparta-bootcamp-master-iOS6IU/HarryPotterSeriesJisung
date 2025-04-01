import UIKit
import SnapKit

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
        layer.cornerRadius = UIConstant.SeriesOrderButton.radius
        backgroundColor = .systemBlue

        snp.makeConstraints {
            $0.width.height.equalTo(UIConstant.SeriesOrderButton.size)
        }
    }

    func updateTitle(with seriesOrder: String) {
        setTitle(seriesOrder, for: .normal)
    }
}
