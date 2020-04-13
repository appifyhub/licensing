import Foundation

/// This can't be a protocol because associatedTypes are nonsense.
class ICache<Model : HasCacheKey> {
    
    @discardableResult
    func put(_ model: Model) -> Model { return model }
    
    @discardableResult
    func evict(_ key: AnyHashable) -> Model? { return nil }
    
    @discardableResult
    func get(_ key: AnyHashable) -> Model? { return nil }
    
    @discardableResult
    func findFirst(_ filter: (Model) -> Bool) -> Model? { return nil }
    
    @discardableResult
    func findAll(_ filter: (Model) -> Bool) -> [Model] { return [] }
    
}

protocol HasCacheKey {
    var cacheKey: AnyHashable { get }
}
