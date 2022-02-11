/*
 
    SUT -> System under Test. Serve para identificar a classe que está sendo testada
    Spy -> Duble de teste -> Versao mokada de um teste que queremos testar
    Stub
 
 */

import XCTest

class RemoteAddAccount {
    private let url: URL
    private let httpClient: HttpClient
    
    init(url: URL, httpClient: HttpClient){
        self.url = url
        self.httpClient = httpClient
    }
    func add(){
        httpClient.post(url: self.url)
    }
}

protocol HttpClient {
    func post(url: URL)
}

class RemoteAddAccountTests: XCTestCase {

    
    /*
        Informacoes importantes:
        ------------------------
        
        url:URL e httpClient: HttpClientSpy está como parametro da classe RemoteAddAccount por que ela é uma implementacao do Protocolo AddAccount. A responsabilidade de criar esse tipo é o construtor da classe. Devemos focar apenas na assinatura do protocolo e nada mais.
     
        
     
     */
    
    func test_() throws {
        
        let url = URL(string: "http://any-url.com")!
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        sut.add()
        
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    class HttpClientSpy: HttpClient {
        var url: URL?
        func post(url: URL) {
            self.url = url
        }
    }

}
