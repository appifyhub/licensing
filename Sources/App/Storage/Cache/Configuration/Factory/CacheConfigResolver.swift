import Foundation
import Vapor

final class CacheConfigResolver {
    
    private static let DEFAULT_SIZE: Int = 10
    
    private static let KEY_CACHE_SIZE = "MAX_CACHE_ITEMS"
    
    private init() {}
    
    static func resolve() -> CacheConfig {
        let envSizeRaw = Environment.get(KEY_CACHE_SIZE)?.trim() ?? ""
        let envSize = Int(envSizeRaw) ?? DEFAULT_SIZE
        
        // at the moment only in-mem caches are supported
        return CacheConfig(maxStoredItems: envSize)
    }
    
}
