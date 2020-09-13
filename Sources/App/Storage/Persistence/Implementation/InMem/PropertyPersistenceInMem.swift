import Foundation
import NIO

class PropertyPersistenceInMem : IPropertyPersistence {
    
    private var storage: [Int : PropertyDbm] = [:]
    private var currentId = AtomicInteger(value: 0)
    
    override init(timeProvider: TimeProvider) {
        super.init(timeProvider: timeProvider)
    }
    
    // CRUD
    
    override func create(_ model: PropertyDbm) -> EventLoopFuture<PropertyDbm> {
        let newModel = model
            .tryWithChangedID(currentId.incrementAndGet())
            .withCurrentCreateTime(timeProvider)
            .withCurrentUpdateTime(timeProvider)
        storage[newModel.persistenceKey] = newModel
        return success(newModel)
    }
    
    override func read(_ key: Int) -> EventLoopFuture<PropertyDbm?> {
        return success(storage[key])
    }
    
    override func update(_ model: PropertyDbm) -> EventLoopFuture<PropertyDbm> {
        let newModel = model.withCurrentUpdateTime(timeProvider)
        storage[newModel.persistenceKey] = newModel
        return success(newModel)
    }
    
    override func delete(_ key: Int) -> EventLoopFuture<Bool> {
        let removedValue = storage.removeValue(forKey: key)
        return success(removedValue != nil)
    }
    
    // Additional queries
    
    override func findAllByService(id: Int) throws -> EventLoopFuture<[PropertyDbm]> {
        let result = filterValues { property in id == property.serviceID }
        return success(result)
    }
    
    override func findAllByName(_ name: String) -> EventLoopFuture<[PropertyDbm]> {
        let result = filterValues { property in name == property.name }
        return success(result)
    }
    
    override func findAllByType(_ type: PropertyDbm.PropertyType) throws -> EventLoopFuture<[PropertyDbm]> {
        let result = filterValues { property in type == property.type }
        return success(result)
    }
    
    override func findAllByMandatory(_ mandatory: Bool) throws -> EventLoopFuture<[PropertyDbm]> {
        let result = filterValues { property in mandatory == property.mandatory }
        return success(result)
    }
    
    // Helpers
    
    private func filterValues(_ filter: (PropertyDbm) -> Bool) -> [PropertyDbm] {
        return storage.map { key, value -> PropertyDbm in value }.filter(filter)
    }
    
}
