import XCTest

@testable import App

class AccessMapperExtensionsTest : XCTestCase {
    
    func testConversion_storageToDomain() throws {
        let storage = Access.stubStorage()
        let result = storage.toDomainModel()
        
        XCTAssertEqual(result.token, "token")
        XCTAssertEqual(result.createdAt, 10)
    }
    
    func testConversion_domainToStorage() throws {
        let storage = Access.stub()
        let result = storage.toStorageModel(forAccount: Account.stub())
        
        XCTAssertEqual(result.token, "token")
        XCTAssertEqual(result.createdAt, 10)
        XCTAssertEqual(result.accountID, 1)
    }
    
    func testConversion_domainToNetwork() throws {
        let storage = Access.stub()
        let result = storage.toNetworkModel()
        
        XCTAssertEqual(result.value, "token")
        XCTAssertEqual(result.createdAt, 10)
    }
    
    func testConversion_networkToDomain() throws {
        let storage = Access.stubNetwork()
        let result = storage.toDomainModel()
        
        XCTAssertEqual(result.token, "token")
        XCTAssertEqual(result.createdAt, 10)
    }
    
    // Test config
    
    static let allTests = [
        ("testConversion_storageToDomain", testConversion_storageToDomain),
        ("testConversion_domainToStorage", testConversion_domainToStorage),
        ("testConversion_domainToNetwork", testConversion_domainToNetwork),
        ("testConversion_networkToDomain", testConversion_networkToDomain)
    ]
    
}
