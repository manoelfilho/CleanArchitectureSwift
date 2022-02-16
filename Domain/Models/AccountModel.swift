public struct AccountModel: Model {

    public var id: Int
    public var username: String
    public var email: String
    public var provider: String
    public var confirmed: Bool
    public var blocked: Bool
    public var createdAt: String
    public var updatedAt: String
    
    public init(id: Int, username: String, email: String, provider: String, confirmed: Bool, blocked: Bool, createdAt: String, updatedAt: String){
        self.id = id
        self.username = username
        self.email = email
        self.provider = provider
        self.confirmed = confirmed
        self.blocked = blocked
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
}
