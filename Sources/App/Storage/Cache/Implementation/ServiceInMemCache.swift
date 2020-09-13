import Foundation

class ServiceInMemCache : IServiceCache {
    
    private let storage: ICache<ServiceDbm>
    
    init(maxSize: Int) {
        storage = LRUCache(maxSize: maxSize)
    }
    
    override func put(_ model: ServiceDbm) -> ServiceDbm {
        return storage.put(model)
    }
    
    override func get(_ key: AnyHashable) -> ServiceDbm? {
        return storage.get(key)
    }
    
    override func evict(_ key: AnyHashable) -> ServiceDbm? {
        return storage.evict(key)
    }
    
    override func findFirst(_ filter: (ServiceDbm) -> Bool) -> ServiceDbm? {
        return storage.findFirst(filter)
    }
    
    override func findAll(_ filter: (ServiceDbm) -> Bool) -> [ServiceDbm] {
        return storage.findAll(filter)
    }
    
}
