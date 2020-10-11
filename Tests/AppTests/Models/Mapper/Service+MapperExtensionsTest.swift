import XCTest

@testable import App

class ServiceMapperExtensionsTest : XCTestCase {
    
    func testConversion_storageToDomain() throws {
        let storage = Service.stubStorage()
        let result = storage.toDomainModel()
        
        XCTAssertEqual(result.ID, 1)
        XCTAssertEqual(result.name, "name")
        XCTAssertEqual(result.description, "description")
        XCTAssertEqual(result.createdAt, 10)
        XCTAssertEqual(result.updatedAt, 20)
        XCTAssertEqual(result.assignedServices, [])
        XCTAssertEqual(result.properties, [])
    }
    
    func testConversion_domainToStorage() throws {
        let storage = Service.stub()
        let result = storage.toStorageModel()
        
        XCTAssertEqual(result.ID, 1)
        XCTAssertEqual(result.name, "name")
        XCTAssertEqual(result.description, "description")
        XCTAssertEqual(result.createdAt, 10)
        XCTAssertEqual(result.updatedAt, 20)
    }
    
    func testConversion_domainToNetwork() throws {
        let storage = Service.stub()
        let result = storage.toNetworkModel()
        
        XCTAssertEqual(result.id, 1)
        XCTAssertEqual(result.name, "name")
        XCTAssertEqual(result.description, "description")
        XCTAssertEqual(result.createdAt, 10)
        XCTAssertEqual(result.updatedAt, 20)
        XCTAssertEqual(result.properties, [Property.stubNetwork()])
    }
    
    func testConversion_networkToDomain() throws {
        let storage = Service.stubNetwork()
        let result = storage.toDomainModel()
        
        XCTAssertEqual(result.ID, 1)
        XCTAssertEqual(result.name, "name")
        XCTAssertEqual(result.description, "description")
        XCTAssertEqual(result.createdAt, 10)
        XCTAssertEqual(result.updatedAt, 20)
        XCTAssertEqual(result.assignedServices, [])
        XCTAssertEqual(result.properties, [Property.stub()])
    }
    
    // Test config
    
    static let allTests = [
        ("testConversion_storageToDomain", testConversion_storageToDomain),
        ("testConversion_domainToStorage", testConversion_domainToStorage),
        ("testConversion_domainToNetwork", testConversion_domainToNetwork),
        ("testConversion_networkToDomain", testConversion_networkToDomain)
    ]
    
}
