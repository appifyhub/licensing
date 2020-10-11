import XCTest

@testable import App

class PropertyMapperExtensionsTest : XCTestCase {
    
    func testConversion_storageToDomain() throws {
        let storage = Property.stubStorage()
        let result = storage.toDomainModel()
        
        XCTAssertEqual(result.ID, 1)
        XCTAssertEqual(result.name, "name")
        XCTAssertEqual(result.type, .string)
        XCTAssertEqual(result.mandatory, true)
        XCTAssertEqual(result.createdAt, 10)
        XCTAssertEqual(result.updatedAt, 20)
    }
    
    func testConversion_domainToStorage() throws {
        let storage = Property.stub()
        let result = storage.toStorageModel(forService: Service.stub())
        
        XCTAssertEqual(result.ID, 1)
        XCTAssertEqual(result.serviceID, 1)
        XCTAssertEqual(result.name, "name")
        XCTAssertEqual(result.type, .string)
        XCTAssertEqual(result.mandatory, true)
        XCTAssertEqual(result.createdAt, 10)
        XCTAssertEqual(result.updatedAt, 20)
    }
    
    func testConversion_domainToNetwork() throws {
        let storage = Property.stub()
        let result = storage.toNetworkModel()
        
        XCTAssertEqual(result.id, 1)
        XCTAssertEqual(result.name, "name")
        XCTAssertEqual(result.type, "string")
        XCTAssertEqual(result.mandatory, true)
        XCTAssertEqual(result.createdAt, 10)
        XCTAssertEqual(result.updatedAt, 20)
    }
    
    func testConversion_networkToDomain() throws {
        let storage = Property.stubNetwork()
        let result = storage.toDomainModel()
        
        XCTAssertEqual(result.ID, 1)
        XCTAssertEqual(result.name, "name")
        XCTAssertEqual(result.type, .string)
        XCTAssertEqual(result.mandatory, true)
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
