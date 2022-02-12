/*
 
    SUT -> System under Test. Serve para identificar a classe que está sendo testada
    Spy -> Duble de teste -> Versao mokada de um teste que queremos testar
    Stub
 
 */

import XCTest
import Domain
import Data

class RemoteAddAccountTests: XCTestCase {

    
    /*
        Informacoes importantes:
        ------------------------
        
        url:URL e httpClient: HttpClientSpy está como parametro da classe RemoteAddAccount por que ela é uma implementacao do Protocolo AddAccount. A responsabilidade de criar esse tipo é o construtor da classe. Devemos focar apenas na assinatura do protocolo e nada mais.
     
        
     */
    
    /*
     Testa se a URL encaminhada pelo SUT(RemoteAddAccount) para o HttpClient é a mesma recebida em HttpClient
     */
    func test_add_should_call_http_client_with_correct_url() throws {
        let url = URL(string: "http://any-url.com.br")!
        let (sut, httpClientSpy) = makeSut()
        sut.add(addAccountModel: makeAddAccountModel()){ _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    /*
        Testa se o model encaminhado pelo SUT (RemoteAddAccount) para o HttpClient corresponde ao Data de HttpClient apos convertido
     */
    func test_add_should_call_http_client_with_correct_data() throws {
        let (sut, httpClientSpy) = makeSut()
        let addAccountModel = makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel){ _ in }
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
    }
    
    func test_add_should_complete_with_error_if_clients_fails(){
        let (sut, httpClientSpy) = makeSut()
        let addAccountModel = makeAddAccountModel()
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: addAccountModel) { error in
            XCTAssertEqual(error, .unexpected)
            exp.fulfill()
        }
        httpClientSpy.completeWithError(.noConnectivity)
        wait(for: [exp], timeout: 1)
    }

}

extension RemoteAddAccountTests {
    
    func makeSut(url: URL = URL(string: "http://any-url.com.br")!) -> (sut: RemoteAddAccount, httpClientSpy: HttpClientSpy){
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        return (sut, httpClientSpy)
    }
    
    class HttpClientSpy: HttpPostClient {
        var urls = [URL]()
        var data: Data?
        var completion: ((HttpError) -> Void)?
        
        func post(to url: URL, with data: Data?, completion: @escaping (HttpError) -> Void) {
            self.urls.append(url)
            self.data = data
            self.completion = completion
        }
        
        /*
            Simula completions / closures com erros
         */
        func completeWithError( _ error: HttpError){
            completion?(error)
        }
    }
    
    func makeAddAccountModel() -> AddAccountModel {
        return AddAccountModel(
            name: "name",
            email: "email@email.com",
            password: "password",
            passwordConfirmation: "password"
        )
    }
    
}
