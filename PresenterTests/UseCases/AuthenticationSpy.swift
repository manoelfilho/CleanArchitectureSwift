import Foundation
import Presenter
import Domain

class AuthenticationSpy: Authentication {

    var authenticationModel: AuthenticationModel?
    var completion: ((Authentication.Result)->Void)?
    
    func authenticate(authenticationModel: AuthenticationModel, completion: @escaping (Authentication.Result) -> Void) {
        self.authenticationModel = authenticationModel
        self.completion = completion
    }
    func completeWithError(_ error: DomainError){
        completion?(.failure(error))
    }
    func completeWithAccount(_ account: AccountModel){
        completion?(.success(account))
    }
    
}
