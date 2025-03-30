import UIKit

final class AlertManager {
    static func showFetchBookError(on viewController: UIViewController, error: BookError) {
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
