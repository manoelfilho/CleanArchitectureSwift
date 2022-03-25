import Foundation
import Domain

public final class RemoteAddAccount: AddAccount {
    
    private let url: URL
    private let httpClient: HttpPostClient
    
    public init(url: URL, httpClient: HttpPostClient){
        self.url = url
        self.httpClient = httpClient
    }
    
    public func add(addAccountModel: AddAccountModel, completion: @escaping (AddAccount.Result) -> Void){
        
        httpClient.post(to: url, with: addAccountModel.toData()) { [weak self] result in
            
            guard self != nil else { return } //se self for nulo retorna.
            
            /*
                Com uma declaracao desse tipo: var x = self.url obrigamos a instancia de RemoteAddAccount a existir sempre. Mesmo com o fim da closure. Definir a propria classe como weak evita memory leaks -> [weak self]
             */
            
            switch result {
                case .success(let data):
                    if let model: AccountModel = data?.toModel() {
                        completion(.success(model))
                    } else {
                        completion(.failure(.unexpected))
                    }
                case .failure(let error):
                    switch error{
                        case .forbiden:
                            completion(.failure(.emailInUse))
                        default:
                            completion(.failure(.unexpected))
                    }
            }
        }
    }
    
}
