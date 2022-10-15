import XCTest
import Data
import Infra
import Domain

class AddAccounIntegrationTests: XCTestCase {

    func test_add_account(){
        let url = URL(string: "http://192.168.1.8:3001/signup_clean_app1")!
        let alamofireAdapter = AlamofireAdapter()
        let sut = RemoteAddAccount(url: url, httpClient: alamofireAdapter)
        let addAccountModel = AddAccountModel(confirmed: true, blocked: false, username: "manoel", email: "email@email.com", password: "senha", role: 1, provider: "local")
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: addAccountModel) { result in
            switch result {
            case .failure: XCTFail("Expect succcess got \(result) instead")
            case .success(let account):
                XCTAssertNotNil(account.id)
                XCTAssertEqual(account.username, addAccountModel.username)
                XCTAssertEqual(account.email, addAccountModel.email)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }

}
