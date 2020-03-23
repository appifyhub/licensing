import XCTest

@testable import App

class OptionalStringExtensionsTest : XCTestCase {
    
    func testNullOrBlank_isNull() throws {
        let text: String? = nil
        
        XCTAssertTrue(text.isNullOrBlank())
    }
    
    func testNullOrBlank_nonBlank() throws {
        let text: String? = " \n \t .   "
        
        XCTAssertTrue(text.isNotNullNorBlank())
    }
    
    // Test config
    
    static let allTests = [
        ("testNullOrBlank_isNull", testNullOrBlank_isNull),
        ("testNullOrBlank_nonBlank", testNullOrBlank_nonBlank)
    ]
    
}
