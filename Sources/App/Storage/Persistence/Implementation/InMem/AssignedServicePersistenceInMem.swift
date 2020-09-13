import Foundation
import NIO

class AssignedServicePersistenceInMem : IAssignedServicePersistence {
    
    private var storage: [Int : AssignedServiceDbm] = [:]
    private var currentId = AtomicInteger(value: 0)
    
    override init(timeProvider: TimeProvider) {
        super.init(timeProvider: timeProvider)
    }
    
    // CRUD
    
    override func create(_ model: AssignedServiceDbm) -> EventLoopFuture<AssignedServiceDbm> {
        let newModel = model
            .tryWithChangedID(currentId.incrementAndGet())
            .withCurrentAssignmentTime(timeProvider)
        storage[newModel.persistenceKey] = newModel
        return success(newModel)
    }
    
    override func read(_ key: Int) -> EventLoopFuture<AssignedServiceDbm?> {
        return success(storage[key])
    }
    
    override func update(_ model: AssignedServiceDbm) -> EventLoopFuture<AssignedServiceDbm> {
        let newModel = model.withCurrentAssignmentTime(timeProvider)
        storage[newModel.persistenceKey] = newModel
        return success(newModel)
    }
    
    override func delete(_ key: Int) -> EventLoopFuture<Bool> {
        let removedValue = storage.removeValue(forKey: key)
        return success(removedValue != nil)
    }
    
    // Additional queries
    
    override func findAllByProject(id: Int) throws -> NIO.EventLoopFuture<[AssignedServiceDbm]> {
        let result = filterValues { assignedService in id == assignedService.projectID }
        return success(result)
    }
    
    override func findOneByProject(id: Int) throws -> NIO.EventLoopFuture<AssignedServiceDbm?> {
        let result = filterValues { assignedService in id == assignedService.projectID }
        return success(result.first)
    }
    
    override func findAllByService(id: Int) throws -> NIO.EventLoopFuture<[AssignedServiceDbm]> {
        let result = filterValues { assignedService in id == assignedService.serviceID }
        return success(result)
    }
    
    override func findOneByService(id: Int) throws -> NIO.EventLoopFuture<AssignedServiceDbm?> {
        let result = filterValues { assignedService in id == assignedService.serviceID }
        return success(result.first)
    }
    
    override func findAllByProjectAndService(projectID: Int, serviceID: Int) throws -> NIO.EventLoopFuture<[AssignedServiceDbm]> {
        let result = filterValues { assignedService in projectID == assignedService.projectID && serviceID == assignedService.serviceID }
        return success(result)
    }
    
    override func findOneByProjectAndService(projectID: Int, serviceID: Int) throws -> NIO.EventLoopFuture<AssignedServiceDbm?> {
        let result = filterValues { assignedService in projectID == assignedService.projectID && serviceID == assignedService.serviceID }
        return success(result.first)
    }
    
    // Helpers
    
    private func filterValues(_ filter: (AssignedServiceDbm) -> Bool) -> [AssignedServiceDbm] {
        return storage.map { key, value -> AssignedServiceDbm in value }.filter(filter)
    }
    
}
