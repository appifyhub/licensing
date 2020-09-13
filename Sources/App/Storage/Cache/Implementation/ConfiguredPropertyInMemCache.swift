import Foundation

class ConfiguredPropertyInMemCache : IConfiguredPropertyCache {
    
    private let storage: ICache<ConfiguredProperty>
    
    init(maxSize: Int) {
        storage = LRUCache(maxSize: maxSize)
    }
    
    override func put(_ model: ConfiguredProperty) -> ConfiguredProperty {
        return storage.put(model)
    }
    
    override func get(_ key: AnyHashable) -> ConfiguredProperty? {
        return storage.get(key)
    }
    
    override func evict(_ key: AnyHashable) -> ConfiguredProperty? {
        return storage.evict(key)
    }
    
    override func findFirst(_ filter: (ConfiguredProperty) -> Bool) -> ConfiguredProperty? {
        return storage.findFirst(filter)
    }
    
    override func findAll(_ filter: (ConfiguredProperty) -> Bool) -> [ConfiguredProperty] {
        return storage.findAll(filter)
    }
    
}
