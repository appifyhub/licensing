import Foundation
import NIO

class ServicePersistenceInMem : IServicePersistence {
    
    private var storage: [Int : ServiceDbm] = [:]
    private var currentId = AtomicInteger(value: 0)
    
    override init(timeProvider: TimeProvider) {
        super.init(timeProvider: timeProvider)
    }
    
    // CRUD
    
    override func create(_ model: ServiceDbm) -> EventLoopFuture<ServiceDbm> {
        let newModel = model
            .tryWithChangedID(currentId.incrementAndGet())
            .withCurrentCreateTime(timeProvider)
            .withCurrentUpdateTime(timeProvider)
        storage[newModel.persistenceKey] = newModel
        return success(newModel)
    }
    
    override func read(_ key: Int) -> EventLoopFuture<ServiceDbm?> {
        return success(storage[key])
    }
    
    override func update(_ model: ServiceDbm) -> EventLoopFuture<ServiceDbm> {
        let newModel = model.withCurrentUpdateTime(timeProvider)
        storage[newModel.persistenceKey] = newModel
        return success(newModel)
    }
    
    override func delete(_ key: Int) -> EventLoopFuture<Bool> {
        let removedValue = storage.removeValue(forKey: key)
        return success(removedValue != nil)
    }
    
    // Additional queries
    
    override func findOneByName(_ name: String) -> EventLoopFuture<ServiceDbm?> {
        let result = filterValues { Service in name == Service.name }
        return success(result.first)
    }
    
    // Helpers
    
    private func filterValues(_ filter: (ServiceDbm) -> Bool) -> [ServiceDbm] {
        return storage.map { key, value -> ServiceDbm in value }.filter(filter)
    }
    
}
