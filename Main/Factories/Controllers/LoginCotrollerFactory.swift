import Foundation
import Domain
import UI
import Presenter
import Validation

public func makeLoginCotroller() -> LoginViewController {
    return makeLoginCotrollerWith(authentication: makeRemoteAuthentication())
}

public func makeLoginCotrollerWith(authentication: Authentication) -> LoginViewController {
    let controller = LoginViewController.instantiate()
    let validationComposite = ValidationComposite(validations: makeLoginValidations())
    let presenter = LoginPresenter(
        validation: validationComposite,
        alertView: WeakVarProxy(controller),
        authentication: authentication,
        loadingView: WeakVarProxy(controller)
    )
    controller.authenticate = presenter.authenticate
    return controller
}

public func makeLoginValidations() -> [Validation]{
    return [
        RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
        RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"),
        EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: makeEmailValidatorAdapter())
    ]
}
