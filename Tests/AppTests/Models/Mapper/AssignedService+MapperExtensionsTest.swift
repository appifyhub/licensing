import XCTest

@testable import App

class AssignedServiceMapperExtensionsTest : XCTestCase {
    
    func testConversion_storageToDomain() throws {
        let storage = AssignedService.stubStorage()
        let result = storage.toDomainModel()
        
        XCTAssertEqual(result.ID, 1)
        XCTAssertEqual(result.assignedAt, 10)
        XCTAssertEqual(result.configuredProperties, [])
    }
    
    func testConversion_domainToStorage() throws {
        let storage = AssignedService.stub()
        let result = storage.toStorageModel(forProject: Project.stub(), forService: Service.stub())
        
        XCTAssertEqual(result.ID, 1)
        XCTAssertEqual(result.projectID, 1)
        XCTAssertEqual(result.serviceID, 1)
        XCTAssertEqual(result.assignedAt, 10)
    }
    
    func testConversion_domainToNetwork() throws {
        let storage = AssignedService.stub()
        let result = storage.toNetworkModel()
        
        XCTAssertEqual(result.id, 1)
        XCTAssertEqual(result.assignedAt, 10)
        XCTAssertEqual(result.configuredProperties, [ConfiguredProperty.stubNetwork()])
    }
    
    func testConversion_networkToDomain() throws {
        let storage = AssignedService.stubNetwork()
        let result = storage.toDomainModel()
        
        XCTAssertEqual(result.ID, 1)
        XCTAssertEqual(result.assignedAt, 10)
        XCTAssertEqual(result.configuredProperties, [ConfiguredProperty.stub()])
    }
    
    // Test config
    
    static let allTests = [
        ("testConversion_storageToDomain", testConversion_storageToDomain),
        ("testConversion_domainToStorage", testConversion_domainToStorage),
        ("testConversion_domainToNetwork", testConversion_domainToNetwork),
        ("testConversion_networkToDomain", testConversion_networkToDomain)
    ]
    
}
