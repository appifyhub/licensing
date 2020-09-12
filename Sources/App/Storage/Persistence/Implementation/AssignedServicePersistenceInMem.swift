import Foundation
import NIO

class AssignedServicePersistenceInMem : IAssignedServicePersistence {
    
    private var storage: [Int : AssignedService] = [:]
    private var currentId = AtomicInteger(value: 0)
    
    override init(timeProvider: TimeProvider) {
        super.init(timeProvider: timeProvider)
    }
    
    // CRUD
    
    override func create(_ model: AssignedService) -> EventLoopFuture<AssignedService> {
        let newModel = model
            .tryWithChangedID(currentId.incrementAndGet())
            .withCurrentAssignmentTime(timeProvider)
        storage[newModel.persistenceKey] = newModel
        return success(newModel)
    }
    
    override func read(_ key: Int) -> EventLoopFuture<AssignedService?> {
        return success(storage[key])
    }
    
    override func update(_ model: AssignedService) -> EventLoopFuture<AssignedService> {
        return success(model)
    }
    
    override func delete(_ key: Int) -> EventLoopFuture<Bool> {
        let removedValue = storage.removeValue(forKey: key)
        return success(removedValue != nil)
    }
    
    // Additional queries
    
    override func findAllByProject(id: Int) throws -> NIO.EventLoopFuture<[AssignedService]> {
        let result = filterValues { assignedService in id == assignedService.projectID }
        return success(result)
    }
    
    override func findOneByProject(id: Int) throws -> NIO.EventLoopFuture<AssignedService?> {
        let result = filterValues { assignedService in id == assignedService.projectID }
        return success(result.first)
    }
    
    override func findAllByService(id: Int) throws -> NIO.EventLoopFuture<[AssignedService]> {
        let result = filterValues { assignedService in id == assignedService.serviceID }
        return success(result)
    }
    
    override func findOneByService(id: Int) throws -> NIO.EventLoopFuture<AssignedService?> {
        let result = filterValues { assignedService in id == assignedService.serviceID }
        return success(result.first)
    }
    
    override func findAllByProjectAndService(projectID: Int, serviceID: Int) throws -> NIO.EventLoopFuture<[AssignedService]> {
        let result = filterValues { assignedService in projectID == assignedService.projectID && serviceID == assignedService.serviceID }
        return success(result)
    }
    
    override func findOneByProjectAndService(projectID: Int, serviceID: Int) throws -> NIO.EventLoopFuture<AssignedService?> {
        let result = filterValues { assignedService in projectID == assignedService.projectID && serviceID == assignedService.serviceID }
        return success(result.first)
    }
    
    // Helpers
    
    private func filterValues(_ filter: (AssignedService) -> Bool) -> [AssignedService] {
        return storage.map { key, value -> AssignedService in value }.filter(filter)
    }
    
}
