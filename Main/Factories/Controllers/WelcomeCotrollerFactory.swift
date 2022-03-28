import Foundation
import UI

public func makeWelcomeViewController(nav: NavigationController) -> WelcomeViewController {
    let router = WelcomeRouter(nav: nav, loginFactory: makeLoginCotroller, signUpFactory: makeSignUpController)
    let controller = WelcomeViewController.instantiate()
    controller.signUp = router.goToSignup
    controller.authenticate = router.goToLogin
    return controller
}
