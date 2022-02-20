import XCTest
import Presenter

public final class EmailValidatorAdapter: EmailValidator {
    private let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    public func isValid(email: String) -> Bool {
        let range = NSRange(location: 0, length: email.utf16.count)
        let regex = try! NSRegularExpression(pattern: pattern)
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }
}

class EmailValidatorAdapterTests: XCTestCase {

    func test_invalid_emails(){
        let sut = makeSut()
        XCTAssertFalse(sut.isValid(email: "ee"))
        XCTAssertFalse(sut.isValid(email: "ee@"))
        XCTAssertFalse(sut.isValid(email: "ee@ee"))
        XCTAssertFalse(sut.isValid(email: "eee@ee."))
        XCTAssertFalse(sut.isValid(email: ""))
    }
    
    func test_valid_emails(){
        let sut = makeSut()
        XCTAssertTrue(sut.isValid(email: "email@email.com"))
        XCTAssertTrue(sut.isValid(email: "email@email.com.br"))
        XCTAssertTrue(sut.isValid(email: "email@email.co"))
    }

}

extension EmailValidatorAdapterTests {
    func makeSut() -> EmailValidatorAdapter{
        return EmailValidatorAdapter()
    }
}
