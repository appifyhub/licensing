import Foundation

class AccessInMemCache : IAccessCache {
    
    private let storage: ICache<AccessDbm>
    
    init(maxSize: Int) {
        storage = LRUCache(maxSize: maxSize)
    }
    
    override func put(_ model: AccessDbm) -> AccessDbm {
        return storage.put(model)
    }
    
    override func get(_ key: AnyHashable) -> AccessDbm? {
        return storage.get(key)
    }
    
    override func evict(_ key: AnyHashable) -> AccessDbm? {
        return storage.evict(key)
    }
    
    override func findFirst(_ filter: (AccessDbm) -> Bool) -> AccessDbm? {
        return storage.findFirst(filter)
    }
    
    override func findAll(_ filter: (AccessDbm) -> Bool) -> [AccessDbm] {
        return storage.findAll(filter)
    }
    
}
