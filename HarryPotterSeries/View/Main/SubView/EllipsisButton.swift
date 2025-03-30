import UIKit

final class EllipsisButton: UIButton {
    private var isExpand = true

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
        titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(Font.Size.tiny))
        setTitleColor(.systemBlue, for: .normal)
        backgroundColor = .clear

        expand()
    }

    private func expand() {
        setTitle(Component.EllipsisButton.expand, for: .normal)
    }

    private func collapse() {
        setTitle(Component.EllipsisButton.collapse, for: .normal)
    }

    func switchTitle() {
        if isExpand {
            collapse()
        } else {
            expand()
        }

        isExpand.toggle()
    }
}
