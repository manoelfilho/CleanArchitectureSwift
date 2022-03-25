import Foundation
import Domain
import UI
import Presenter
import Validation
import Infra

public final class SignUpComposer {
    public static func composeControllerWith(addAccount: AddAccount) -> SignUpViewController {
        let controller = SignUpViewController.instantiate()
        let validationComposite = ValidationComposite(validations: makeValidations())
        let presenter = SignUpPresenter(
            alertView: WeakVarProxy(controller),
            validation: validationComposite,
            addAccount: addAccount,
            loadingView: WeakVarProxy(controller)
        )
        controller.signUp = presenter.signUp
        return controller
    }
    
    public static func makeValidations() -> [Validation]{
        return [
            RequiredFieldValidation(fieldName: "username", fieldLabel: "Username"),
            RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
            RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"),
            EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorAdapter())
        ]
    }
}
