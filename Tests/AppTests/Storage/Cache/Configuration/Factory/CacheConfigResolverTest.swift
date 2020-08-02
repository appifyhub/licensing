import XCTest

@testable import App

class CacheConfigResolverTest : XCTestCase {
    
    private let DEFAULT_SIZE: Int = 10
    private let KEY_CACHE_SIZE = "MAX_CACHE_ITEMS"
    
    func test_noEnvironmentConfig() throws {
        let config = CacheConfigResolver.resolve()
        
        XCTAssertEqual(config.maxStoredItems, DEFAULT_SIZE)
    }
    
    func test_withEnvironmentConfig_empty() throws {
        setenv(KEY_CACHE_SIZE, "", 1)
        
        let config = CacheConfigResolver.resolve()
        setenv(KEY_CACHE_SIZE, "", 1)
        
        XCTAssertEqual(config.maxStoredItems, DEFAULT_SIZE)
    }
    
    func test_withEnvironmentConfig_invalidFormat() throws {
        setenv(KEY_CACHE_SIZE, "abcd", 1)
        
        let config = CacheConfigResolver.resolve()
        setenv(KEY_CACHE_SIZE, "", 1)
        
        XCTAssertEqual(config.maxStoredItems, DEFAULT_SIZE)
    }
    
    func test_withEnvironmentConfig_valid() throws {
        setenv(KEY_CACHE_SIZE, "111", 1)
        
        let config = CacheConfigResolver.resolve()
        setenv(KEY_CACHE_SIZE, "", 1)
        
        XCTAssertEqual(config.maxStoredItems, 111)
    }
    
    // Test config
    
    static let allTests = [
        ("test_noEnvironmentConfig", test_noEnvironmentConfig),
        ("test_withEnvironmentConfig_empty", test_withEnvironmentConfig_empty),
        ("test_withEnvironmentConfig_invalidFormat", test_withEnvironmentConfig_invalidFormat),
        ("test_withEnvironmentConfig_valid", test_withEnvironmentConfig_valid)
    ]
    
}
