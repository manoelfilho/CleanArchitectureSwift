/*
 
    SUT -> System under Test. Serve para identificar a classe que está sendo testada
    Spy -> Duble de teste -> Versao mokada de um teste que queremos testar
    Stub
 
 */

import XCTest
import Domain

class RemoteAddAccount {
    private let url: URL
    private let httpClient: HttpPostClient
    
    init(url: URL, httpClient: HttpPostClient){
        self.url = url
        self.httpClient = httpClient
    }
    func add(addAccountModel: AddAccountModel){
        let data = try? JSONEncoder().encode(addAccountModel)
        httpClient.post(to: url, with: data)
    }
}

protocol HttpPostClient {
    func post(to url: URL, with data: Data?)
}

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
        
        let url = URL(string: "http://any-url.com")!
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        let addAccountModel = AddAccountModel(
            name: "name",
            email: "email@email.com",
            password: "password",
            passwordConfirmation: "password"
        )
        sut.add(addAccountModel: addAccountModel)
        XCTAssertEqual(httpClientSpy.url, url)
    
    }
    
    /*
        Testa se o model encaminhado pelo SUT (RemoteAddAccount) para o HttpClient corresponde ao Data de HttpClient apos convertido
     */
    func test_add_should_call_http_client_with_correct_data() throws {
        
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: URL(string: "http://any-url.com")!, httpClient: httpClientSpy)
        let addAccountModel = AddAccountModel(
            name: "name",
            email: "email@email.com",
            password: "password",
            passwordConfirmation: "password"
        )
        sut.add(addAccountModel: addAccountModel)
        
        let data = try? JSONEncoder().encode(addAccountModel)
        
        XCTAssertEqual(httpClientSpy.data, data)
    
    }

}

extension RemoteAddAccountTests {
    
    class HttpClientSpy: HttpPostClient {
        var url: URL?
        var data: Data?
        
        func post(to url: URL, with data: Data?) {
            self.url = url
            self.data = data
        }
    }
    
}
