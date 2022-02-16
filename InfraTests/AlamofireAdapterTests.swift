/*
    No módulo Data/Http criamos um HttpPostClient que é um protocolo que diz como deve ser feita as requisicoes Post. Ao mesmo tempo, usaremos uma biblioteca de terceiro (Alamofire) que tem os seus recursos de requisicoes. O Adapter é uma intermediacao entre esses dois. AlamofireAdapterTests serve para testar esse adapter a ser criado
                        
 */

import XCTest
import Alamofire
import Data
import Domain

class AlamoFireAdapter {
    
    private let session: Session
    
    init(session: Session = .default){
        self.session = session
    }
    
    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpError>) -> Void){
        session.request(url, method: .post, parameters: data?.toJson(), encoding: JSONEncoding.default).responseData { dataResponse in
            switch dataResponse.result {
            case .failure: completion(.failure(.noConnectivity))
            case .success: break
            }
        }
    }
}

class AlamofireAdapterTests: XCTestCase {

    /*
        Garatir que o Alamofire recebe a URL correta
     */
    func test_post_should_make_request_with_valid_url_and_method(){
        let url = makeUrl()
        testRequestFor(url: url, data: makeValidData()){ request in
            XCTAssertEqual(url, request.url) // verifica se a URL é igual no AlamofireAdapter e na Session
            XCTAssertEqual("POST", request.httpMethod) // verifica se o tipo de requisicao é do tipo post
            XCTAssertNotNil(request.httpBodyStream) // verifica se o body da requisicao nao esta vazio
        }
    }
    
    func test_post_should_make_request_with_no_data(){
        testRequestFor(url: makeUrl(), data: makeInvalidData()){ request in
            XCTAssertNil(request.httpBodyStream) // verifica se o body da requisicao nao esta vazio
        }
    }
    
    func test_post_should_complete_with_error_when_request_completes_with_error(){
        let sut = makeSut()
        UrlProtocolStub.simulate(data: nil, response: nil, error: makeError())
        let exp = expectation(description: "waiting")
        sut.post(to: makeUrl(), with: makeValidData()){ result in
            switch result {
            case .failure(let error): XCTAssertEqual(error, .noConnectivity)
            case .success: XCTFail("Expected error. Got a \(result) instead")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

}

/*
 
    Os teste que correspondem as respostas do Alamofire devem responder as seguintes situacoes
    considerando: data | response | error
    
    válidos:
    
    OK  OK  X
    X   X   OK
 
    inválido:
    
    OK  OK  OK
    OK  X   OK
    OK  X   X
    X   OK  OK
    X   OK  X
    X   X   X
 
 */
extension AlamofireAdapterTests {
    
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> AlamoFireAdapter {
        //definimos uma configuracao customizada para o Session do Alamofire.
        //assim ele não faz a conexao padrao e sim uma fake
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: configuration)
        let sut = AlamoFireAdapter(session: session)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    func testRequestFor(url: URL, data: Data?, action: @escaping (URLRequest) -> Void){
        let sut = makeSut()
        sut.post(to: url, with: data){ _ in }
        
        let exp = expectation(description: "waiting")
        UrlProtocolStub.observeRequest { request in
            action(request)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
    
}
/*
    UrlProtocolStub é interceptador de requisicoes. É usado pelo Alamofire como configuração. Evita requisições reais na internet. Pode ser usado pelo URL Session também. Ou qualquer outra ferramenta que precise de um mock
 */
class UrlProtocolStub: URLProtocol {
    
    static var emit: ((URLRequest) -> Void)?
    
    static var data: Data?
    static var response: HTTPURLResponse?
    static var error: Error?
    
    static func observeRequest(completion: @escaping (URLRequest) -> Void) {
        UrlProtocolStub.emit = completion
    }
    
    static func simulate(data: Data?, response: HTTPURLResponse?, error: Error?) {
        UrlProtocolStub.data = data
        UrlProtocolStub.response = response
        UrlProtocolStub.error = error
    }
    
    override open class func canInit(with request: URLRequest) -> Bool {
        return true // -> aqui afirmo que tudo deve ser interceptado
    }
    
    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    //override open class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {}
    
    override open func startLoading() {
        UrlProtocolStub.emit?(request)
        if let data = UrlProtocolStub.data {
            client?.urlProtocol(self, didLoad: data)
        }
        if let response = UrlProtocolStub.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        if let error = UrlProtocolStub.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override open func stopLoading() {
        
    }
}
