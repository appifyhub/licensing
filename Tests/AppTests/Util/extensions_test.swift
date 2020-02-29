import XCTest

@testable import App

class ExtensionsTest : XCTestCase {
    
    func testStringTrim_withSpace() throws {
        let untrimmed = " \n \t text \n \t "
        
        let trimmed = untrimmed.trim()
        
        XCTAssertEqual(trimmed, "text")
    }
    
    func testStringTrim_noSpace() throws {
        let untrimmed = "text"
        
        let trimmed = untrimmed.trim()
        
        XCTAssertEqual(trimmed, untrimmed)
    }
    
    func testStringIsBlank_blank() throws {
        let text = "  \n \t  "
        
        XCTAssertTrue(text.isBlank())
    }
    
    func testStringIsNotBlank_nonBlank() throws {
        let text = " \n \t .   "
        
        XCTAssertTrue(text.isNotBlank())
    }
    
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
        ("testStringTrim_withSpace", testStringTrim_withSpace),
        ("testStringTrim_noSpace", testStringTrim_noSpace),
        ("testStringIsBlank_blank", testStringIsBlank_blank),
        ("testStringIsNotBlank_nonBlank", testStringIsNotBlank_nonBlank),
        ("testNullOrBlank_isNull", testNullOrBlank_isNull),
        ("testNullOrBlank_nonBlank", testNullOrBlank_nonBlank)
    ]
    
}
