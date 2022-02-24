import Foundation
import Domain
import UI
import Presenter
import Validation

public final class SignUpComposer {
    public static func composeControllerWith(addAccount: AddAccount) -> SignUpViewController {
        let controller = SignUpViewController.instantiate()
        let emailValidatorAdapter = EmailValidatorAdapter()
        let presenter = SignUpPresenter(
            alertView: WeakVarProxy(controller),
            emailValidator: emailValidatorAdapter,
            addAccount: addAccount,
            loadingView: WeakVarProxy(controller)
        )
        controller.signUp = presenter.signUp
        return controller
    }
}
