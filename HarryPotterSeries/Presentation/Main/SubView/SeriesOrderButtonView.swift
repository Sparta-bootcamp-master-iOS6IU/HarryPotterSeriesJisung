import UIKit
import SnapKit

final class SeriesOrderButtonView: UIView {
    private let buttonStackView = UIStackView()

    var onButtonTapped: ((String) -> Void)?

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
        for seriesOrder in 1...booksCount {
            let seriesOrderButton = SeriesOrderButton()

            seriesOrderButton.updateTitle(with: "\(seriesOrder)")

            seriesOrderButton.onButtonTapped = { [weak self] in
                self?.onButtonTapped?("\(seriesOrder)")
            }

            buttonStackView.addArrangedSubview(seriesOrderButton)
        }
    }

    func updateSeriesOrderButton(by seriesOrder: String) {
        buttonStackView.arrangedSubviews.enumerated().forEach { index, subview in
            if let button = subview as? SeriesOrderButton {
                button.isSelected = "\(index + 1)" == seriesOrder
            }
        }
    }
}
