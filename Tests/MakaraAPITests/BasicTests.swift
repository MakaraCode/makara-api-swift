import XCTest
@testable import MakaraAPI

final class MakaraAPI_BasicTests: XCTestCase {
    
    func testCreateHuman() {
        
        let expectation = XCTestExpectation()
        
        Human.create(
            name: HumanName([
                HumanNameComponent(1, "Barack"),
                HumanNameComponent(2, "Obama")
            ]),
            email: TestUtility.createTestEmail(),
            secret: TestUtility.testHumanSecret,
            session: nil,
            then: { error, human in
                XCTAssertNil(error)
                XCTAssertNotNil(human)
                expectation.fulfill()
                return
            }
        )
        
        wait(for: [expectation], timeout: 5)
        
        return
        
    }
    
    func testCreateSession() {
        
        let expectation = XCTestExpectation()
        
        let email = TestUtility.createTestEmail()
        let secret = "somethinggood"
        
        Human.create(
            name: HumanName([
                HumanNameComponent(1, "Barack"),
                HumanNameComponent(2, "Obama")
            ]),
            email: email,
            secret: secret,
            session: nil,
            then: { error, human in
                XCTAssertNil(error)
                XCTAssertNotNil(human)
                Session.create(
                    email: email,
                    secret: secret,
                    then: { (error, session) in
                        XCTAssertNil(error)
                        XCTAssertNotNil(session)
                        expectation.fulfill()
                        return
                    }
                )
            }
        )
        
        wait(for: [expectation], timeout: 5)
        
        return
        
    }

    static var allTests = [
        ("testCreateHuman", testCreateHuman),
    ]
}

