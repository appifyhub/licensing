import XCTest

@testable import App

class ProjectMapperExtensionsTest : XCTestCase {
    
    func testConversion_storageToDomain() throws {
        let storage = Project.stubStorage()
        let result = storage.toDomainModel()
        
        XCTAssertEqual(result.ID, 1)
        XCTAssertEqual(result.name, "name")
        XCTAssertEqual(result.type, .commercial)
        XCTAssertEqual(result.status, .review)
        XCTAssertEqual(result.createdAt, 10)
        XCTAssertEqual(result.updatedAt, 20)
        XCTAssertEqual(result.assignedServices, [])
    }
    
    func testConversion_domainToStorage() throws {
        let storage = Project.stub()
        let result = storage.toStorageModel(forAccount: Account.stub())
        
        XCTAssertEqual(result.ID, 1)
        XCTAssertEqual(result.accountID, 1)
        XCTAssertEqual(result.name, "name")
        XCTAssertEqual(result.type, .commercial)
        XCTAssertEqual(result.status, .review)
        XCTAssertEqual(result.createdAt, 10)
        XCTAssertEqual(result.updatedAt, 20)
    }
    
    func testConversion_domainToNetwork() throws {
        let storage = Project.stub()
        let result = storage.toNetworkModel()
        
        XCTAssertEqual(result.id, 1)
        XCTAssertEqual(result.name, "name")
        XCTAssertEqual(result.type, "commercial")
        XCTAssertEqual(result.status, "review")
        XCTAssertEqual(result.createdAt, 10)
        XCTAssertEqual(result.updatedAt, 20)
        XCTAssertEqual(result.assignedServices, [AssignedService.stubNetwork()])
    }
    
    func testConversion_networkToDomain() throws {
        let storage = Project.stubNetwork()
        let result = storage.toDomainModel()
        
        XCTAssertEqual(result.ID, 1)
        XCTAssertEqual(result.name, "name")
        XCTAssertEqual(result.type, .commercial)
        XCTAssertEqual(result.status, .review)
        XCTAssertEqual(result.createdAt, 10)
        XCTAssertEqual(result.updatedAt, 20)
        XCTAssertEqual(result.assignedServices, [AssignedService.stub()])
    }
    
    // Test config
    
    static let allTests = [
        ("testConversion_storageToDomain", testConversion_storageToDomain),
        ("testConversion_domainToStorage", testConversion_domainToStorage),
        ("testConversion_domainToNetwork", testConversion_domainToNetwork),
        ("testConversion_networkToDomain", testConversion_networkToDomain)
    ]
    
}
