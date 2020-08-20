import Foundation

class PropertyInMemCache : IPropertyCache {
    
    private let storage: ICache<Property>
    
    init(maxSize: Int) {
        storage = LRUCache(maxSize: maxSize)
    }
    
    override func put(_ model: Property) -> Property {
        return storage.put(model)
    }
    
    override func get(_ key: AnyHashable) -> Property? {
        return storage.get(key)
    }
    
    override func evict(_ key: AnyHashable) -> Property? {
        return storage.evict(key)
    }
    
    override func findFirst(_ filter: (Property) -> Bool) -> Property? {
        return storage.findFirst(filter)
    }
    
    override func findAll(_ filter: (Property) -> Bool) -> [Property] {
        return storage.findAll(filter)
    }
    
}
