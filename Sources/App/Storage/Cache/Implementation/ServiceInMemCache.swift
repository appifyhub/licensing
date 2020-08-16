import Foundation

class ServiceInMemCache : IServiceCache {
    
    private let storage: ICache<Service>
    
    init(maxSize: Int) {
        storage = LRUCache(maxSize: maxSize)
    }
    
    override func put(_ model: Service) -> Service {
        return storage.put(model)
    }
    
    override func get(_ key: AnyHashable) -> Service? {
        return storage.get(key)
    }
    
    override func evict(_ key: AnyHashable) -> Service? {
        return storage.evict(key)
    }
    
    override func findFirst(_ filter: (Service) -> Bool) -> Service? {
        return storage.findFirst(filter)
    }
    
    override func findAll(_ filter: (Service) -> Bool) -> [Service] {
        return storage.findAll(filter)
    }
    
}
