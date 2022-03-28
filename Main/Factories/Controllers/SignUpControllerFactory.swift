import Foundation
import Domain
import UI
import Presenter
import Validation

public func makeSignUpController() -> SignUpViewController {
    return makeSignUpControllerWith(addAccount: makeRemoteAddAccount())
}

public func makeSignUpControllerWith(addAccount: AddAccount) -> SignUpViewController {
    let controller = SignUpViewController.instantiate()
    let validationComposite = ValidationComposite(validations: makeSignUpValidations())
    let presenter = SignUpPresenter(
        alertView: WeakVarProxy(controller),
        validation: validationComposite,
        addAccount: addAccount,
        loadingView: WeakVarProxy(controller)
    )
    controller.signUp = presenter.signUp
    return controller
}

public func makeSignUpValidations() -> [Validation]{
    return [
        RequiredFieldValidation(fieldName: "username", fieldLabel: "Username"),
        RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
        RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"),
        EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: makeEmailValidatorAdapter())
    ]
}
