import UIKit

struct AlertManager {
    /// 책 데이터를 가져오는 과정에서 발생하는 오류를 `Alert`으로 표시하는 메서드
    /// - Parameters:
    ///   - viewController: `Alert`을 표시할 `ViewController`
    ///   - error: 발생한 `BookError`
    static func showFetchBookError(on viewController: UIViewController, error: BookDataSourceError) {
        let message: String

        switch error {
        case .invalidPath:
            message = UIConstant.Alert.invalidPathErrorMessage
        case .jsonDecodingError:
            message = UIConstant.Alert.jsonDecodingErrorMessage
        default:
            message = UIConstant.Alert.unknownErrorMessage
        }

        let alert = UIAlertController(title: UIConstant.Alert.errorTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: UIConstant.Alert.confirmButtonTitle, style: .default, handler: nil))

        viewController.present(alert, animated: true, completion: nil)
    }
}
