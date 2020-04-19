import XCTest

@testable import App

class StorageConfigResolverTest : XCTestCase {
    
    private let KEY_TYPE = "DB_TYPE"
    private let KEY_HOST = "DB_HOST"
    private let KEY_PORT = "DB_PORT"
    private let KEY_USER = "DB_USER"
    private let KEY_PASS = "DB_PASS"
    private let KEY_NAME = "DB_NAME"
    
    func test_noEnvironmentConfig_nothingChosen() throws {
        let config = StorageConfigResolver.resolve()
        
        XCTAssertTrue(config is MySQLConfig)
    }
    
    func test_noEnvironmentConfig_inMemChosen() throws {
        setenv(KEY_TYPE, StorageType.inmem.rawValue, 1)
        
        let config = StorageConfigResolver.resolve()
        setenv(KEY_TYPE, "", 1)
        
        XCTAssertTrue(config is InMemConfig)
    }
    
    func test_noEnvironmentConfig_MySQLChosen() throws {
        setenv(KEY_TYPE, StorageType.mysql.rawValue, 1)
        
        let config = StorageConfigResolver.resolve()
        setenv(KEY_TYPE, "", 1)
        
        XCTAssertTrue(config is DebugMySQLConfig)
    }
    
    func test_withEnvironmentConfig_nothingChosen() throws {
        setenv(KEY_HOST, "external.com", 1)
        setenv(KEY_PORT, "3000", 1)
        setenv(KEY_USER, "user", 1)
        setenv(KEY_PASS, "pass", 1)
        setenv(KEY_NAME, "db-name", 1)
        
        let config = StorageConfigResolver.resolve()
        setenv(KEY_HOST, "", 1)
        setenv(KEY_PORT, "", 1)
        setenv(KEY_USER, "", 1)
        setenv(KEY_PASS, "", 1)
        setenv(KEY_NAME, "", 1)
        
        XCTAssertTrue(config is MySQLConfig)
    }
    
    func test_withEnvironmentConfig_inMemChosen() throws {
        setenv(KEY_TYPE, "inmem", 1)
        setenv(KEY_HOST, "external.com", 1)
        setenv(KEY_PORT, "3000", 1)
        setenv(KEY_USER, "user", 1)
        setenv(KEY_PASS, "pass", 1)
        setenv(KEY_NAME, "db-name", 1)
        
        let config = StorageConfigResolver.resolve()
        setenv(KEY_TYPE, "", 1)
        setenv(KEY_HOST, "", 1)
        setenv(KEY_PORT, "", 1)
        setenv(KEY_USER, "", 1)
        setenv(KEY_PASS, "", 1)
        setenv(KEY_NAME, "", 1)
        
        XCTAssertTrue(config is InMemConfig)
    }
    
    func test_withEnvironmentConfig_MySQLChosen_wrongData() throws {
        setenv(KEY_TYPE, "mysql", 1)
        setenv(KEY_HOST, " ", 1)
        setenv(KEY_PORT, "80", 1)
        setenv(KEY_USER, " ", 1)
        setenv(KEY_PASS, " ", 1)
        setenv(KEY_NAME, " ", 1)
        
        let config = StorageConfigResolver.resolve()
        setenv(KEY_TYPE, "", 1)
        setenv(KEY_HOST, "", 1)
        setenv(KEY_PORT, "", 1)
        setenv(KEY_USER, "", 1)
        setenv(KEY_PASS, "", 1)
        setenv(KEY_NAME, "", 1)
        
        XCTAssertTrue(config is DebugMySQLConfig)
    }
    
    func test_withEnvironmentConfig_MySQLChosen_noPort() throws {
        setenv(KEY_TYPE, "mysql", 1)
        setenv(KEY_HOST, "external.com", 1)
        setenv(KEY_USER, "user", 1)
        setenv(KEY_PASS, "pass", 1)
        setenv(KEY_NAME, "db-name", 1)
        
        let config = StorageConfigResolver.resolve()
        setenv(KEY_TYPE, "", 1)
        setenv(KEY_TYPE, "", 1)
        setenv(KEY_HOST, "", 1)
        setenv(KEY_USER, "", 1)
        setenv(KEY_PASS, "", 1)
        setenv(KEY_NAME, "", 1)
        
        XCTAssertTrue(config is EnvironmentMySQLConfig)
        
        let mysqlConfig = config as! EnvironmentMySQLConfig
        XCTAssertEqual(mysqlConfig.hostname, "external.com")
        XCTAssertEqual(mysqlConfig.port, 3306)
        XCTAssertEqual(mysqlConfig.username, "user")
        XCTAssertEqual(mysqlConfig.password, "pass")
        XCTAssertEqual(mysqlConfig.database, "db-name")
    }
    
    func test_withEnvironmentConfig_MySQLChosen_withPort() throws {
        setenv(KEY_TYPE, "mysql", 1)
        setenv(KEY_HOST, "external.com", 1)
        setenv(KEY_PORT, "3000", 1)
        setenv(KEY_USER, "user", 1)
        setenv(KEY_PASS, "pass", 1)
        setenv(KEY_NAME, "db-name", 1)
        
        let config = StorageConfigResolver.resolve()
        setenv(KEY_TYPE, "", 1)
        setenv(KEY_HOST, "", 1)
        setenv(KEY_PORT, "", 1)
        setenv(KEY_USER, "", 1)
        setenv(KEY_PASS, "", 1)
        setenv(KEY_NAME, "", 1)
        
        XCTAssertTrue(config is EnvironmentMySQLConfig)
        
        let mysqlConfig = config as! EnvironmentMySQLConfig
        XCTAssertEqual(mysqlConfig.hostname, "external.com")
        XCTAssertEqual(mysqlConfig.port, 3000)
        XCTAssertEqual(mysqlConfig.username, "user")
        XCTAssertEqual(mysqlConfig.password, "pass")
        XCTAssertEqual(mysqlConfig.database, "db-name")
    }
    
    // Test config
    
    static let allTests = [
        ("test_noEnvironmentConfig_nothingChosen", test_noEnvironmentConfig_nothingChosen),
        ("test_noEnvironmentConfig_inMemChosen", test_noEnvironmentConfig_inMemChosen),
        ("test_noEnvironmentConfig_MySQLChosen", test_noEnvironmentConfig_MySQLChosen),
        ("test_withEnvironmentConfig_nothingChosen", test_withEnvironmentConfig_nothingChosen),
        ("test_withEnvironmentConfig_inMemChosen", test_withEnvironmentConfig_inMemChosen),
        ("test_withEnvironmentConfig_MySQLChosen_wrongData", test_withEnvironmentConfig_MySQLChosen_wrongData),
        ("test_withEnvironmentConfig_MySQLChosen_noPort", test_withEnvironmentConfig_MySQLChosen_noPort),
        ("test_withEnvironmentConfig_MySQLChosen_withPort", test_withEnvironmentConfig_MySQLChosen_withPort)
    ]
    
}
