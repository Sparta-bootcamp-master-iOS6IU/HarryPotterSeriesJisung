import UIKit
import SnapKit

final class SeriesOrderButtonView: UIView {
    private let buttonStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configureUI()
    }

    private func configureUI() {
        buttonStackView.axis = .horizontal
        buttonStackView.alignment = .center
        buttonStackView.distribution = .equalSpacing

        addSubview(buttonStackView)

        buttonStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func updateUI(with booksCount: Int) {
        for order in 1...booksCount {
            let seriesOrderButton = SeriesOrderButton()

            buttonStackView.addArrangedSubview(seriesOrderButton)

            seriesOrderButton.updateTitle(with: "\(order)")
        }
    }
}
