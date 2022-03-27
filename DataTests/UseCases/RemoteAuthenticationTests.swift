import XCTest
import Domain
import Data

class RemoteAuthenticationTests: XCTestCase {
    
    func test_auth_should_call_http_client_with_correct_url() throws {
        let url = makeUrl()
        let (sut, httpClientSpy) = makeSut()
        sut.authenticate(authenticationModel: makeAuthenticationModel()){ _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_auth_should_call_http_client_with_correct_data() throws {
        let (sut, httpClientSpy) = makeSut()
        let authenticationModel = makeAuthenticationModel()
        sut.authenticate(authenticationModel: authenticationModel){ _ in }
        XCTAssertEqual(httpClientSpy.data, authenticationModel.toData())
    }
    
    func test_auth_should_complete_with_error_if_clients_completes_with_error(){
        let (sut, httpClientSpy) = makeSut()
        expec(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completeWithError(.noConnectivity)
        })
    }
    
    func test_auth_should_complete_with_expired_session_if_client_completes_with_unauthorized(){
        let (sut, httpClientSpy) = makeSut()
        expec(sut, completeWith: .failure(.expiredSession), when: {
            httpClientSpy.completeWithError(.unauthorized)
        })
    }
    
}

extension RemoteAuthenticationTests {
    
    func makeSut(url: URL = URL(string: "http://any-url.com.br")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteAuthentication, httpClientSpy: HttpClientSpy){
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAuthentication(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        return (sut, httpClientSpy)
    }
    
    func expec(_ sut: RemoteAuthentication, completeWith expectResult: Authentication.Result, when action:() -> Void, file: StaticString = #filePath, line: UInt = #line){
        let exp = expectation(description: "waiting")
        sut.authenticate(authenticationModel: makeAuthenticationModel()) { receivedResult in
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
