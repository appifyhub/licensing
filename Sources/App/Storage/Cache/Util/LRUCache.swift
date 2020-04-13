import Foundation

// Inspired by & based on raywenderlich/swift-algorithm-club

class LRUCache<Model : HasCacheKey> : ICache<Model> {
    
    private let maxSize: Int
    private var cache: [AnyHashable : Model] = [:]
    private var priority: LinkedList<AnyHashable> = LinkedList<AnyHashable>()
    private var key2node: [AnyHashable : LinkedList<AnyHashable>.Node] = [:]
    let semaphore = DispatchSemaphore(value: 1)
    
    public init(maxSize: Int) {
        self.maxSize = maxSize
    }
    
    @discardableResult
    override func put(_ model: Model) -> Model {
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        defer { semaphore.signal() }
        
        // remove and add to update the usage index
        if cache[model.cacheKey] != nil {
            remove(model.cacheKey)
        } else if priority.count >= maxSize, let keyToRemove = priority.last?.value {
            remove(keyToRemove)
        }
        
        insert(model)
        return model
    }
    
    @discardableResult
    override func evict(_ key: AnyHashable) -> Model? {
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        defer { semaphore.signal() }
        
        return remove(key)
    }
    
    @discardableResult
    override func get(_ key: AnyHashable) -> Model? {
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        defer { semaphore.signal() }
        
        return fetch(key)
    }
    
    @discardableResult
    override func findFirst(_ filter: (Model) -> Bool) -> Model? {
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        defer { semaphore.signal() }
        
        return lookup(filter).first
    }
    
    @discardableResult
    override func findAll(_ filter: (Model) -> Bool) -> [Model] {
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        defer { semaphore.signal() }
        
        return lookup(filter)
    }
    
    // Helpers
    
    @discardableResult
    private func remove(_ key: AnyHashable) -> Model? {
        let removedValue = cache.removeValue(forKey: key)
        guard let node = key2node[key] else {
            return removedValue
        }
        priority.remove(node: node)
        key2node.removeValue(forKey: key)
        return removedValue
    }
    
    private func insert(_ model: Model) {
        cache[model.cacheKey] = model
        let newNode = LinkedList<AnyHashable>.Node(value: model.cacheKey)
        priority.insert(newNode, at: 0)
        key2node[model.cacheKey] = newNode
    }
    
    private func fetch(_ key: AnyHashable) -> Model? {
        guard let val = cache[key] else {
            return nil
        }
        
        // remove and add to update the usage index
        remove(key)
        insert(val)
        
        return val
    }
    
    private func lookup(_ filter: (Model) -> Bool) -> [Model] {
        return cache.values.filter(filter).map { model -> Model in
            fetch(model.cacheKey)! // do this to update priorities
        }
    }
    
}
