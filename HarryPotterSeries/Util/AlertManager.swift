import UIKit

final class AlertManager {
    static func showFetchBookError(on viewController: UIViewController, error: BookError) {
        let message: String

        switch error {
        case .invalidPath:
            message = Alert.Message.invalidPath
        case .jsonDecodingError:
            message = Alert.Message.jsonDecodingError
        default:
            message = Alert.Message.unknownError
        }

        let alert = UIAlertController(title: Alert.error, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Alert.confirm, style: .default, handler: nil))

        viewController.present(alert, animated: true, completion: nil)
    }
}
