import Foundation

class PropertyInMemCache : IPropertyCache {
    
    private let storage: ICache<PropertyDbm>
    
    init(maxSize: Int) {
        storage = LRUCache(maxSize: maxSize)
    }
    
    override func put(_ model: PropertyDbm) -> PropertyDbm {
        return storage.put(model)
    }
    
    override func get(_ key: AnyHashable) -> PropertyDbm? {
        return storage.get(key)
    }
    
    override func evict(_ key: AnyHashable) -> PropertyDbm? {
        return storage.evict(key)
    }
    
    override func findFirst(_ filter: (PropertyDbm) -> Bool) -> PropertyDbm? {
        return storage.findFirst(filter)
    }
    
    override func findAll(_ filter: (PropertyDbm) -> Bool) -> [PropertyDbm] {
        return storage.findAll(filter)
    }
    
}
