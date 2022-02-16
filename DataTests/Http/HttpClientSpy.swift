import Foundation
import Domain
import Data

//Simula um HttpPost. É um mok de alguma classe que nao existe
public class HttpClientSpy: HttpPostClient {
    var urls = [URL]()
    var data: Data?
    var completion: ((Result<Data?, HttpError>) -> Void)?

    public func post(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        self.urls.append(url)
        self.data = data
        self.completion = completion
    }

    /*
        Simula completions / closures com erros
     */
    func completeWithError( _ error: HttpError){
        completion?(.failure(error))
    }
    func completeWithData( _ data: Data){
        completion?(.success(data))
    }
}
