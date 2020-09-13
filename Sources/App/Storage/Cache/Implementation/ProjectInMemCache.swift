import Foundation

class ProjectInMemCache : IProjectCache {
    
    private let storage: ICache<ProjectDbm>
    
    init(maxSize: Int) {
        storage = LRUCache(maxSize: maxSize)
    }
    
    override func put(_ model: ProjectDbm) -> ProjectDbm {
        return storage.put(model)
    }
    
    override func get(_ key: AnyHashable) -> ProjectDbm? {
        return storage.get(key)
    }
    
    override func evict(_ key: AnyHashable) -> ProjectDbm? {
        return storage.evict(key)
    }
    
    override func findFirst(_ filter: (ProjectDbm) -> Bool) -> ProjectDbm? {
        return storage.findFirst(filter)
    }
    
    override func findAll(_ filter: (ProjectDbm) -> Bool) -> [ProjectDbm] {
        return storage.findAll(filter)
    }
    
}
