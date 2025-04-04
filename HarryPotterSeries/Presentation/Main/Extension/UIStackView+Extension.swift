import UIKit

extension UIStackView {
    /// StackView 설정 메서드
    /// 
    /// - Parameters:
    ///   - axis: 스택 방향
    ///   - alignment: 정렬 방식
    ///   - distribution: 배치 방식
    ///   - spacing: 간격
    func configure(
        axis: NSLayoutConstraint.Axis,
        alignment: Alignment,
        distribution: Distribution = .fill,
        spacing: CGFloat = 0
    ) {
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }
}
