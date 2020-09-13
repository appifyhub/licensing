import Foundation

class AssignedServiceInMemCache : IAssignedServiceCache {
    
    private let storage: ICache<AssignedServiceDbm>
    
    init(maxSize: Int) {
        storage = LRUCache(maxSize: maxSize)
    }
    
    override func put(_ model: AssignedServiceDbm) -> AssignedServiceDbm {
        return storage.put(model)
    }
    
    override func get(_ key: AnyHashable) -> AssignedServiceDbm? {
        return storage.get(key)
    }
    
    override func evict(_ key: AnyHashable) -> AssignedServiceDbm? {
        return storage.evict(key)
    }
    
    override func findFirst(_ filter: (AssignedServiceDbm) -> Bool) -> AssignedServiceDbm? {
        return storage.findFirst(filter)
    }
    
    override func findAll(_ filter: (AssignedServiceDbm) -> Bool) -> [AssignedServiceDbm] {
        return storage.findAll(filter)
    }
    
}
