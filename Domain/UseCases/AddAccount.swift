import Foundation

public protocol AddAccount {
    func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void)
}

public struct AddAccountModel: Model {
    
    public var confirmed: Bool
    public var blocked: Bool
    public var username: String
    public var email: String
    public var password: String
    public var role: Int
    public var provider: String
    
    public init(confirmed: Bool, blocked: Bool, username: String, email: String, password: String, role: Int, provider: String){
        self.confirmed = confirmed
        self.blocked = blocked
        self.username = username
        self.email = email
        self.password = password
        self.role = role
        self.provider = provider
    }
    
}
