import UIKit
import SnapKit

/// 책 시리즈를 선택하는 커스텀 `UIButton`
final class SeriesOrderButton: UIButton {
    /// 버튼 터치 시 실행할 클로저
    var onButtonTapped: (() -> Void)?

    override var isSelected: Bool {
        didSet {
            updateUI()
        }
    }

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
        titleLabel?.font = UIFont.systemFont(ofSize: UIConstant.FontSize.small)
        layer.cornerRadius = UIConstant.SeriesOrderButton.radius

        snp.makeConstraints {
            $0.width.height.equalTo(UIConstant.SeriesOrderButton.size)
        }
    }

    /// 버튼 액션 설정 메서드
    private func configureActions() {
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    /// 버튼 상태에 따라 UI를 업데이트하는 메서드
    private func updateUI() {
        backgroundColor = isSelected ? .systemBlue : .systemGray5
        setTitleColor(.white, for: .selected)
        setTitleColor(.systemBlue, for: .normal)
    }

    /// 버튼 타이틀 업데이트 메서드
    /// 
    /// - Parameter seriesOrder: 시리즈 순서 문자열
    func updateTitle(with seriesOrder: String) {
        setTitle(seriesOrder, for: .normal)
    }

    /// 버튼이 터치 시 호출 메서드
    @objc private func buttonTapped() {
        onButtonTapped?()
    }
}
