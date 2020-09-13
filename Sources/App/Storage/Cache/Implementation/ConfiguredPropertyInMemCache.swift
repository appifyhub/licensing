import Foundation

class ConfiguredPropertyInMemCache : IConfiguredPropertyCache {
    
    private let storage: ICache<ConfiguredPropertyDbm>
    
    init(maxSize: Int) {
        storage = LRUCache(maxSize: maxSize)
    }
    
    override func put(_ model: ConfiguredPropertyDbm) -> ConfiguredPropertyDbm {
        return storage.put(model)
    }
    
    override func get(_ key: AnyHashable) -> ConfiguredPropertyDbm? {
        return storage.get(key)
    }
    
    override func evict(_ key: AnyHashable) -> ConfiguredPropertyDbm? {
        return storage.evict(key)
    }
    
    override func findFirst(_ filter: (ConfiguredPropertyDbm) -> Bool) -> ConfiguredPropertyDbm? {
        return storage.findFirst(filter)
    }
    
    override func findAll(_ filter: (ConfiguredPropertyDbm) -> Bool) -> [ConfiguredPropertyDbm] {
        return storage.findAll(filter)
    }
    
}
