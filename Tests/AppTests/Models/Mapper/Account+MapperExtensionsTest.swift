import XCTest

@testable import App

class AccountMapperExtensionsTest : XCTestCase {
    
    func testConversion_storageToDomain() throws {
        let storage = Account.stubStorage()
        let result = storage.toDomainModel()
        
        XCTAssertEqual(result.ID, 1)
        XCTAssertEqual(result.name, "name")
        XCTAssertEqual(result.ownerName, "ownerName")
        XCTAssertEqual(result.email, "email")
        XCTAssertEqual(result.phashed, "phashed")
        XCTAssertEqual(result.type, .personal)
        XCTAssertEqual(result.authority, .normal)
        XCTAssertEqual(result.createdAt, 10)
        XCTAssertEqual(result.updatedAt, 20)
        XCTAssertEqual(result.accesses, [])
        XCTAssertEqual(result.projects, [])
    }
    
    func testConversion_domainToStorage() throws {
        let storage = Account.stub()
        let result = storage.toStorageModel()
        
        XCTAssertEqual(result.ID, 1)
        XCTAssertEqual(result.name, "name")
        XCTAssertEqual(result.ownerName, "ownerName")
        XCTAssertEqual(result.email, "email")
        XCTAssertEqual(result.phashed, "phashed")
        XCTAssertEqual(result.type, .personal)
        XCTAssertEqual(result.authority, .normal)
        XCTAssertEqual(result.createdAt, 10)
        XCTAssertEqual(result.updatedAt, 20)
    }
    
    func testConversion_domainToNetwork() throws {
        let storage = Account.stub()
        let result = storage.toNetworkModel()
        
        XCTAssertEqual(result.id, 1)
        XCTAssertEqual(result.name, "name")
        XCTAssertEqual(result.ownerName, "ownerName")
        XCTAssertEqual(result.email, "email")
        XCTAssertEqual(result.type, "personal")
        XCTAssertEqual(result.authority, "normal")
        XCTAssertEqual(result.createdAt, 10)
        XCTAssertEqual(result.updatedAt, 20)
        XCTAssertEqual(result.projects, [Project.stubNetwork()])
    }
    
    func testConversion_networkToDomain() throws {
        let storage = Account.stubNetwork()
        let result = storage.toDomainModel()
        
        XCTAssertEqual(result.ID, 1)
        XCTAssertEqual(result.name, "name")
        XCTAssertEqual(result.ownerName, "ownerName")
        XCTAssertEqual(result.email, "email")
        XCTAssertEqual(result.phashed, "<empty>")
        XCTAssertEqual(result.type, .personal)
        XCTAssertEqual(result.authority, .normal)
        XCTAssertEqual(result.createdAt, 10)
        XCTAssertEqual(result.updatedAt, 20)
        XCTAssertEqual(result.accesses, [])
        XCTAssertEqual(result.projects, [Project.stub()])
    }
    
    // Test config
    
    static let allTests = [
        ("testConversion_storageToDomain", testConversion_storageToDomain),
        ("testConversion_domainToStorage", testConversion_domainToStorage),
        ("testConversion_domainToNetwork", testConversion_domainToNetwork),
        ("testConversion_networkToDomain", testConversion_networkToDomain)
    ]
    
}
