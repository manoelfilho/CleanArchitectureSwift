import Foundation
import Data
import Infra
import Domain


final class UseCaseFactory {
    static func makeRemoteAddAccount() -> AddAccount {
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "\(K.api_url)/users")!
        return RemoteAddAccount(url: url, httpClient: alamofireAdapter)
    }
}
