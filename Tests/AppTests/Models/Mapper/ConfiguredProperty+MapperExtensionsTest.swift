import XCTest

@testable import App

class ConfiguredPropertyMapperExtensionsTest : XCTestCase {
    
    func testConversion_storageToDomain() throws {
        let storage = ConfiguredProperty.stubStorage()
        let result = storage.toDomainModel()
        
        XCTAssertEqual(result.ID, 1)
        XCTAssertEqual(result.value, "value")
        XCTAssertEqual(result.createdAt, 10)
        XCTAssertEqual(result.updatedAt, 20)
    }
    
    func testConversion_domainToStorage() throws {
        let storage = ConfiguredProperty.stub()
        let result = storage.toStorageModel(forAssignedService: AssignedService.stub(), forProperty: Property.stub())
        
        XCTAssertEqual(result.ID, 1)
        XCTAssertEqual(result.propertyID, 1)
        XCTAssertEqual(result.assignedServiceID, 1)
        XCTAssertEqual(result.value, "value")
        XCTAssertEqual(result.createdAt, 10)
        XCTAssertEqual(result.updatedAt, 20)
    }
    
    func testConversion_domainToNetwork() throws {
        let storage = ConfiguredProperty.stub()
        let result = storage.toNetworkModel()
        
        XCTAssertEqual(result.id, 1)
        XCTAssertEqual(result.value, "value")
        XCTAssertEqual(result.createdAt, 10)
        XCTAssertEqual(result.updatedAt, 20)
    }
    
    func testConversion_networkToDomain() throws {
        let storage = ConfiguredProperty.stubNetwork()
        let result = storage.toDomainModel()
        
        XCTAssertEqual(result.ID, 1)
        XCTAssertEqual(result.value, "value")
        XCTAssertEqual(result.createdAt, 10)
        XCTAssertEqual(result.updatedAt, 20)
    }
    
    // Test config
    
    static let allTests = [
        ("testConversion_storageToDomain", testConversion_storageToDomain),
        ("testConversion_domainToStorage", testConversion_domainToStorage),
        ("testConversion_domainToNetwork", testConversion_domainToNetwork),
        ("testConversion_networkToDomain", testConversion_networkToDomain)
    ]
    
}
