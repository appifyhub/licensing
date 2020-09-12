import Foundation

class AssignedServiceInMemCache : IAssignedServiceCache {
    
    private let storage: ICache<AssignedService>
    
    init(maxSize: Int) {
        storage = LRUCache(maxSize: maxSize)
    }
    
    override func put(_ model: AssignedService) -> AssignedService {
        return storage.put(model)
    }
    
    override func get(_ key: AnyHashable) -> AssignedService? {
        return storage.get(key)
    }
    
    override func evict(_ key: AnyHashable) -> AssignedService? {
        return storage.evict(key)
    }
    
    override func findFirst(_ filter: (AssignedService) -> Bool) -> AssignedService? {
        return storage.findFirst(filter)
    }
    
    override func findAll(_ filter: (AssignedService) -> Bool) -> [AssignedService] {
        return storage.findAll(filter)
    }
    
}
