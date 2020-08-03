import Foundation

class AccessInMemCache : IAccessCache {
    
    private let storage: ICache<Access>
    
    init(maxSize: Int) {
        storage = LRUCache(maxSize: maxSize)
    }
    
    override func put(_ model: Access) -> Access {
        return storage.put(model)
    }
    
    override func get(_ key: AnyHashable) -> Access? {
        return storage.get(key)
    }
    
    override func evict(_ key: AnyHashable) -> Access? {
        return storage.evict(key)
    }
    
    override func findFirst(_ filter: (Access) -> Bool) -> Access? {
        return storage.findFirst(filter)
    }
    
    override func findAll(_ filter: (Access) -> Bool) -> [Access] {
        return storage.findAll(filter)
    }
    
}
