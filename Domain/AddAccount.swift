import Foundation

struct AddAccountModel {
    var name: String
    var email: String
    var password: String
    var passwordConfirmation: String
}

protocol AddAccount {
    func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, Error>) -> Void)
}
