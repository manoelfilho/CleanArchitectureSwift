import Foundation
import XCTest

extension XCTestCase {
    
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #filePath, line: UInt = #line){
        //addTeardownBlock é chamado no final de todos os testes. a instancia deve ser weak
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
    
    func makeInvalidData() -> Data{
        return Data("invalid_data".utf8)
    }

    func makeUrl() -> URL {
        return URL(string: "http://any-url.com.br")!
    }
}