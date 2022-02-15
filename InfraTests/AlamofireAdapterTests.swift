/*
    No módulo Data/Http criamos um HttpPostClient que é um protocolo que diz como deve ser feita as requisicoes Post. Ao mesmo tempo, usaremos uma biblioteca de terceiro (Alamofire) que tem os seus recursos de requisicoes. O Adapter é uma intermediacao entre esses dois. AlamofireAdapterTests serve para testar esse adapter a ser criado
                        
 */

import XCTest
import Alamofire

class AlamoFireAdapter {
    
    private let session: Session
    
    init(session: Session = .default){
        self.session = session
    }
    func post(to url: URL, with data: Data){
        let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        session.request(url, method: .post, parameters: json, encoding: JSONEncoding.default).resume()
    }
}

class AlamofireAdapterTests: XCTestCase {

    /*
        Garatir que o Alamofire recebe a URL correta
     */
    func test_post_should_make_request_with_valid_url_and_method(){
        
        let url = makeUrl()
        
        //definimos uma configuracao customizada para o Session do Alamofire.
        //assim ele não faz a conexao padrao e sim uma fake
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: configuration)
        let sut = AlamoFireAdapter(session: session)
        sut.post(to: url, with: makeValidData())
        let exp = expectation(description: "waiting")
        UrlProtocolStub.observeRequest { request in
            XCTAssertEqual(url, request.url) // verifica se a URL é igual no AlamofireAdapter e na Session
            XCTAssertEqual("POST", request.httpMethod) // verifica se o tipo de requisicao é do tipo post
            XCTAssertNotNil(request.httpBodyStream) // verifica se o body da requisicao nao esta vazio
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
    
    static func observeRequest(completion: @escaping (URLRequest) -> Void) {
        UrlProtocolStub.emit = completion
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
    }
    
    override open func stopLoading() {
        
    }
}
