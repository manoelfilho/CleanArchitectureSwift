import XCTest
import Domain
import Data

class RemoteAuthenticationTests: XCTestCase {
    
    func test_auth_should_call_http_client_with_correct_url() throws {
        let url = makeUrl()
        let (sut, httpClientSpy) = makeSut()
        sut.authenticate(authenticationModel: makeAuthenticationModel())
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_auth_should_call_http_client_with_correct_data() throws {
        let (sut, httpClientSpy) = makeSut()
        let authenticationModel = makeAuthenticationModel()
        sut.authenticate(authenticationModel: authenticationModel)
        XCTAssertEqual(httpClientSpy.data, authenticationModel.toData())
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
    
}
