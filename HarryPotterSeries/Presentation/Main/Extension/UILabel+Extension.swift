import UIKit

extension UILabel {
    /// Label 설정 메서드
    /// 
    /// - Parameters:
    ///   - text: 라벨 텍스트
    ///   - font: 폰트
    ///   - textColor: 텍스트 색상
    ///   - numberOfLines: 텍스트 최대 줄 수
    func configure(text: String? = nil, font: UIFont, textColor: UIColor, numberOfLines: Int = 1) {
        if let text = text { self.text = text }
        self.font = font
        self.textColor = textColor
        self.numberOfLines = numberOfLines
    }
}
