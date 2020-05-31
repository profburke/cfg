import XCTest
@testable import CFG

final class CFGTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CFG().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
