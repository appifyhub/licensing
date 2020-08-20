import Foundation
import NIO

class PropertyPersistenceInMem : IPropertyPersistence {
    
    private var storage: [Int : Property] = [:]
    private var currentId = AtomicInteger(value: 0)
    
    override init(timeProvider: TimeProvider) {
        super.init(timeProvider: timeProvider)
    }
    
    // CRUD
    
    override func create(_ model: Property) -> EventLoopFuture<Property> {
        let newModel = model
            .tryWithChangedID(currentId.incrementAndGet())
            .withCurrentCreateTime(timeProvider)
            .withCurrentUpdateTime(timeProvider)
        storage[newModel.persistenceKey] = newModel
        return success(newModel)
    }
    
    override func read(_ key: Int) -> EventLoopFuture<Property?> {
        return success(storage[key])
    }
    
    override func update(_ model: Property) -> EventLoopFuture<Property> {
        let newModel = model.withCurrentUpdateTime(timeProvider)
        storage[newModel.persistenceKey] = newModel
        return success(newModel)
    }
    
    override func delete(_ key: Int) -> EventLoopFuture<Bool> {
        let removedValue = storage.removeValue(forKey: key)
        return success(removedValue != nil)
    }
    
    // Additional queries
    
    override func findAllByService(id: Int) throws -> EventLoopFuture<[Property]> {
        let result = filterValues { property in id == property.serviceID }
        return success(result)
    }
    
    override func findAllByName(_ name: String) -> EventLoopFuture<[Property]> {
        let result = filterValues { property in name == property.name }
        return success(result)
    }
    
    override func findAllByType(_ type: Property.PropertyType) throws -> EventLoopFuture<[Property]> {
        let result = filterValues { property in type == property.type }
        return success(result)
    }
    
    override func findAllByMandatory(_ mandatory: Bool) throws -> EventLoopFuture<[Property]> {
        let result = filterValues { property in mandatory == property.mandatory }
        return success(result)
    }
    
    // Helpers
    
    private func filterValues(_ filter: (Property) -> Bool) -> [Property] {
        return storage.map { key, value -> Property in value }.filter(filter)
    }
    
}
