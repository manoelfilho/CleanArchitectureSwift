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
        let url = makeUrl()
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
    
    /*
        Testa se o arquivo de producao (SUT) completa com erro no caso do Client HTTPCLientPost falhar
        No swift usamos os closures/ escaping para lidar com acoes assim, portanto são assincronas.
        Para simular o retorno de um closure, devemos colocar a funcao que simula o erro no Spy e no teste
        usar o recurso do expectation
     
     metodo modificado para usar a abstracao abaixo...
    
     func test_add_should_complete_with_error_if_clients_completes_with_error(){
        let (sut, httpClientSpy) = makeSut()
        let addAccountModel = makeAddAccountModel()
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: addAccountModel) { result in
            switch result {
                case .failure(let error): XCTAssertEqual(error, .unexpected)
                case .success: XCTFail("Expected error and receive a result \(result) instead")
            }
            exp.fulfill()
        }
        httpClientSpy.completeWithError(.noConnectivity)
        wait(for: [exp], timeout: 1)
    }
    */
    
    func test_add_should_complete_with_error_if_clients_completes_with_error(){
        let (sut, httpClientSpy) = makeSut()
        expec(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completeWithError(.noConnectivity)
        })
    }
    
    /*
        Simula um objeto válido de AccountModel -> que provém do makeAccountModel
        Utiliza desse mode para validar se um sucesso do HttpClient retorna um obj válido
     
        metodo modificado para usar a abstracao abaixo...

    func test_add_should_complete_with_account_if_clients_completes_with_valid_data(){
        let (sut, httpClientSpy) = makeSut()
        let addAccountModel = makeAddAccountModel()
        let exp = expectation(description: "waiting")
        
        let expectedAccount = makeAccountModel()
        
        sut.add(addAccountModel: addAccountModel) { result in
            switch result {
                case .failure: XCTFail("Expected error and receive a result \(result) instead")
                case .success(let receivedAccount): XCTAssertEqual(receivedAccount, expectedAccount)
            }
            exp.fulfill()
        }
        httpClientSpy.completeWithData(expectedAccount.toData()!)
        wait(for: [exp], timeout: 1)
    }
     
     */
    
    func test_add_should_complete_with_account_if_clients_completes_with_valid_data(){
        let (sut, httpClientSpy) = makeSut()
        let account = makeAccountModel()
        expec(sut, completeWith: .success(account), when: {
            httpClientSpy.completeWithData(account.toData()!)
        })
    }

     
    /*
     
    metodo modificado para usar a abstracao abaixo...

    func test_add_should_complete_with_account_if_clients_completes_with_invalid_data(){
        let (sut, httpClientSpy) = makeSut()
        let addAccountModel = makeAddAccountModel()
        let exp = expectation(description: "waiting")
                
        sut.add(addAccountModel: addAccountModel) { result in
            switch result {
            case .failure(let error): XCTAssertEqual(error, .unexpected)
            case .success: XCTFail("Expected error and receive a result \(result) instead")
            }
            exp.fulfill()
        }
        httpClientSpy.completeWithData(makeInvalidData())
        wait(for: [exp], timeout: 1)
    }
     
    */

    func test_add_should_complete_with_account_if_clients_completes_with_invalid_data(){
        let (sut, httpClientSpy) = makeSut()
        expec(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completeWithData(makeInvalidData())
        })
    }

}

extension RemoteAddAccountTests {
    
    func makeSut(url: URL = URL(string: "http://any-url.com.br")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteAddAccount, httpClientSpy: HttpClientSpy){
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        return (sut, httpClientSpy)
    }
    
    /*
        Abstracao para testar remoteAddAccount
        SOBRE o file: StaticString = #filePath, line: UInt = #line
        Essas duas propriedades podem ser chamadas em qualquer método de uma classe de testes. Dará acesso a linha on o erro ocorreu.
    */
    func expec(_ sut: RemoteAddAccount, completeWith expectResult: Result<AccountModel, DomainError>, when action:() -> Void, file: StaticString = #filePath, line: UInt = #line){
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: makeAddAccountModel()) { receivedResult in
            switch (expectResult, receivedResult) {
                case (.failure(let expectError), .failure(let receivedError)): XCTAssertEqual(expectError, receivedError, file: file, line: line)
                case (.success(let expectAccount), .success(let receivedAccount)): XCTAssertEqual(expectAccount, receivedAccount, file: file, line: line)
                
                default: XCTFail("Expected \(expectResult) and receive a \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
    
}
