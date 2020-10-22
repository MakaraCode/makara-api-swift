import XCTest
@testable import MakaraAPI

final class MakaraAPITests: XCTestCase {
    
    func testCreateHuman() {
        
        let expectation = XCTestExpectation()
        
        let emailSeed = String(Int.random(in: 1..<9999999999))
        
        Human.create(
            name: HumanName([
                HumanNameComponent(1, "Barack"),
                HumanNameComponent(2, "Obama")
            ]),
            email: emailSeed + "@makara.test.nil",
            secret: "somethinggood",
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

    static var allTests = [
        ("testCreateHuman", testCreateHuman),
    ]
}

