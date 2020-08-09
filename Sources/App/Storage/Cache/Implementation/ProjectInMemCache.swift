import Foundation

class ProjectInMemCache : IProjectCache {
    
    private let storage: ICache<Project>
    
    init(maxSize: Int) {
        storage = LRUCache(maxSize: maxSize)
    }
    
    override func put(_ model: Project) -> Project {
        return storage.put(model)
    }
    
    override func get(_ key: AnyHashable) -> Project? {
        return storage.get(key)
    }
    
    override func evict(_ key: AnyHashable) -> Project? {
        return storage.evict(key)
    }
    
    override func findFirst(_ filter: (Project) -> Bool) -> Project? {
        return storage.findFirst(filter)
    }
    
    override func findAll(_ filter: (Project) -> Bool) -> [Project] {
        return storage.findAll(filter)
    }
    
}
