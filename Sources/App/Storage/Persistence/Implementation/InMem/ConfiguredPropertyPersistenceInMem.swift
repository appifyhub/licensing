import Foundation
import NIO

class ConfiguredPropertyPersistenceInMem : IConfiguredPropertyPersistence {
    
    private var storage: [Int : ConfiguredProperty] = [:]
    private var currentId = AtomicInteger(value: 0)
    
    override init(timeProvider: TimeProvider) {
        super.init(timeProvider: timeProvider)
    }
    
    // CRUD
    
    override func create(_ model: ConfiguredProperty) -> EventLoopFuture<ConfiguredProperty> {
        let newModel = model
            .tryWithChangedID(currentId.incrementAndGet())
            .withCurrentCreateTime(timeProvider)
            .withCurrentUpdateTime(timeProvider)
        storage[newModel.persistenceKey] = newModel
        return success(newModel)
    }
    
    override func read(_ key: Int) -> EventLoopFuture<ConfiguredProperty?> {
        return success(storage[key])
    }
    
    override func update(_ model: ConfiguredProperty) -> EventLoopFuture<ConfiguredProperty> {
        let newModel = model.withCurrentUpdateTime(timeProvider)
        storage[newModel.persistenceKey] = newModel
        return success(newModel)
    }
    
    override func delete(_ key: Int) -> EventLoopFuture<Bool> {
        let removedValue = storage.removeValue(forKey: key)
        return success(removedValue != nil)
    }
    
    // Additional queries
    
    override func findAllByAssignedService(id: Int) throws -> NIO.EventLoopFuture<[ConfiguredProperty]> {
        let result = filterValues { configuredProperty in id == configuredProperty.assignedServiceID }
        return success(result)
    }
    
    override func findOneByAssignedService(id: Int) throws -> NIO.EventLoopFuture<ConfiguredProperty?> {
        let result = filterValues { configuredProperty in id == configuredProperty.assignedServiceID }
        return success(result.first)
    }
    
    override func findAllByProperty(id: Int) throws -> NIO.EventLoopFuture<[ConfiguredProperty]> {
        let result = filterValues { configuredProperty in id == configuredProperty.propertyID }
        return success(result)
    }
    
    override func findOneByProperty(id: Int) throws -> NIO.EventLoopFuture<ConfiguredProperty?> {
        let result = filterValues { configuredProperty in id == configuredProperty.propertyID }
        return success(result.first)
    }
    
    override func findAllByAssignedServiceAndProperty(assignedServiceID: Int, propertyID: Int) throws -> EventLoopFuture<[ConfiguredProperty]> {
        let result = filterValues { configuredProperty in assignedServiceID == configuredProperty.assignedServiceID && propertyID == configuredProperty.propertyID }
        return success(result)
    }
    
    override func findOneByAssignedServiceAndProperty(assignedServiceID: Int, propertyID: Int) throws -> EventLoopFuture<ConfiguredProperty?> {
        let result = filterValues { configuredProperty in assignedServiceID == configuredProperty.assignedServiceID && propertyID == configuredProperty.propertyID }
        return success(result.first)
    }
    
    override func findAllByValue(value: String) throws -> NIO.EventLoopFuture<[ConfiguredProperty]> {
        let result = filterValues { configuredProperty in value == configuredProperty.value }
        return success(result)
    }
    
    override func findOneByValue(value: String) throws -> NIO.EventLoopFuture<ConfiguredProperty?> {
        let result = filterValues { configuredProperty in value == configuredProperty.value }
        return success(result.first)
    }
    
    // Helpers
    
    private func filterValues(_ filter: (ConfiguredProperty) -> Bool) -> [ConfiguredProperty] {
        return storage.map { key, value -> ConfiguredProperty in value }.filter(filter)
    }
    
}
