import Foundation
import Data
import Infra
import Domain


final class UseCaseFactory {
    
    private static let httpClient = AlamofireAdapter()
    private static let baseUrl = Enviroment.variable(.apiBaseUrl)
    
    private static func makeUrl(path: String) -> URL{
        return URL(string: "\(baseUrl)/\(path)")!
    }
    
    static func makeRemoteAddAccount() -> AddAccount {
        return RemoteAddAccount(url: makeUrl(path: "signup"), httpClient: httpClient)
    }
}
