import XCTest
import Validation

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
