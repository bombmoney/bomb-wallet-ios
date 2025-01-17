// Copyright SIX DAY LLC. All rights reserved.
// Copyright © 2020 Stormbird PTE. LTD.

import Foundation
import UIKit
import class PromiseKit.Promise
import Combine
import AlphaWalletFoundation

enum PopoverPresentationControllerSource {
    case barButtonItem(UIBarButtonItem)
    case view(UIView)
}

enum AlertControllerPreferredStyle {
    case alert
    case actionSheet(source: PopoverPresentationControllerSource)
}

extension UIAlertController {

    static func askPassword(
            title: String = "",
            message: String = "",
            completion: @escaping (Result<String, ConfirmationError>) -> Void
    ) -> UIAlertController {
        let alertController = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: R.string.localizable.oK(), style: .default, handler: { _ -> Void in
            let textField = alertController.textFields![0] as UITextField
            let password = textField.text ?? ""
            completion(.success(password))
        }))
        alertController.addAction(UIAlertAction(title: R.string.localizable.cancel(), style: .cancel, handler: { _ in
            completion(.failure(ConfirmationError.cancel))
        }))
        alertController.addTextField(configurationHandler: { (textField: UITextField!) -> Void in
            textField.placeholder = R.string.localizable.password()
            textField.isSecureTextEntry = true
        })
        return alertController
    }

    @discardableResult
    static func alert(title: String? = nil,
                      message: String? = nil,
                      alertButtonTitles: [String],
                      alertButtonStyles: [UIAlertAction.Style],
                      viewController: UIViewController,
                      style: AlertControllerPreferredStyle = .alert,
                      completion: ((Int) -> Void)? = nil) -> UIViewController {
        let preferredStyle: UIAlertController.Style
        let popoverSource: PopoverPresentationControllerSource?
        switch style {
        case .alert:
            preferredStyle = .alert
            popoverSource = nil
        case .actionSheet(let source):
            preferredStyle = .actionSheet
            popoverSource = source
        }
        let alertController = UIAlertController(
                title: title,
                message: message,
                preferredStyle: preferredStyle)
        switch popoverSource {
        case .some(.barButtonItem(let barButtonItem)):
            alertController.popoverPresentationController?.barButtonItem = barButtonItem
        case .some(.view(let view)):
            alertController.popoverPresentationController?.sourceView = view
            alertController.popoverPresentationController?.sourceRect = view.centerRect
        case .none:
            break
        }
        alertButtonTitles.forEach { title in
            let alertStyle = alertButtonStyles[alertButtonTitles.index(of: title)!]
            let action = UIAlertAction(title: title, style: alertStyle, handler: { action in
                if completion != nil {
                    completion!(alertButtonTitles.index(of: action.title!)!)
                }
            })
            alertController.addAction(action)
        }
        viewController.present(alertController, animated: true, completion: nil)

        return alertController
    }

    static func alertController(
        title: String? = .none,
        message: String? = .none,
        style: UIAlertController.Style,
        in viewController: UIViewController
    ) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        alertController.popoverPresentationController?.sourceView = viewController.view
        alertController.popoverPresentationController?.sourceRect = viewController.view.centerRect
        return alertController
    }
}

extension UIAlertController {
    static func showTransactionSent(transaction: SentTransaction, on target: UIViewController) {
        let alertController = UIAlertController(title: R.string.localizable.sendActionTransactionSent(), message: R.string.localizable.sendActionTransactionSentWait(), preferredStyle: .alert)
        let copyAction = UIAlertAction(title: R.string.localizable.sendActionCopyTransactionTitle(), style: UIAlertAction.Style.default, handler: { _ in
            UIPasteboard.general.string = transaction.id
        })
        alertController.addAction(copyAction)
        alertController.addAction(UIAlertAction(title: R.string.localizable.oK(), style: .default))

        target.present(alertController, animated: true)
    }
}

extension UIAlertController {
    static func promptToUseUnresolvedExplorerURL(customChain: WalletAddEthereumChainObject, chainId: Int, viewController: UIViewController) -> AnyPublisher<Bool, Never> {
        return AnyPublisher<Bool, Never>.create { seal in
            let message = R.string.localizable.addCustomChainWarningNoBlockchainExplorerUrl()
            let alertController = UIAlertController.alertController(title: R.string.localizable.warning(), message: message, style: .alert, in: viewController)
            let continueAction = UIAlertAction(title: R.string.localizable.continue(), style: .destructive, handler: { _ in
                seal.send(true)
                seal.send(completion: .finished)
            })

            let cancelAction = UIAlertAction(title: R.string.localizable.cancel(), style: .cancel, handler: { _ in
                seal.send(false)
                seal.send(completion: .finished)
            })

            alertController.addAction(continueAction)
            alertController.addAction(cancelAction)

            viewController.present(alertController, animated: true)

            return AnyCancellable { }
        }
    }
}
