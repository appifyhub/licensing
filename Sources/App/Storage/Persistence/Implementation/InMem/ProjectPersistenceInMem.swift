import Foundation
import NIO

class ProjectPersistenceInMem : IProjectPersistence {
    
    private var storage: [Int : ProjectDbm] = [:]
    private var currentId = AtomicInteger(value: 0)
    
    override init(timeProvider: TimeProvider) {
        super.init(timeProvider: timeProvider)
    }
    
    // CRUD
    
    override func create(_ model: ProjectDbm) -> EventLoopFuture<ProjectDbm> {
        let newModel = model
            .tryWithChangedID(currentId.incrementAndGet())
            .withCurrentCreateTime(timeProvider)
            .withCurrentUpdateTime(timeProvider)
        storage[newModel.persistenceKey] = newModel
        return success(newModel)
    }
    
    override func read(_ key: Int) -> EventLoopFuture<ProjectDbm?> {
        return success(storage[key])
    }
    
    override func update(_ model: ProjectDbm) -> EventLoopFuture<ProjectDbm> {
        let newModel = model.withCurrentUpdateTime(timeProvider)
        storage[newModel.persistenceKey] = newModel
        return success(newModel)
    }
    
    override func delete(_ key: Int) -> EventLoopFuture<Bool> {
        let removedValue = storage.removeValue(forKey: key)
        return success(removedValue != nil)
    }
    
    // Additional queries
    
    override func findAllByAccount(id: Int) throws -> EventLoopFuture<[ProjectDbm]> {
        let result = filterValues { project in id == project.accountID }
        return success(result)
    }
    
    override func findOneByAccount(id: Int) throws -> EventLoopFuture<ProjectDbm?> {
        let result = filterValues { project in id == project.accountID }
        return success(result.first)
    }
    
    override func findAllByName(_ name: String) -> EventLoopFuture<[ProjectDbm]> {
        let result = filterValues { project in name == project.name }
        return success(result)
    }
    
    override func findAllByType(_ type: ProjectDbm.ProjectType) throws -> EventLoopFuture<[ProjectDbm]> {
        let result = filterValues { project in type == project.type }
        return success(result)
    }
    
    override func findAllByStatus(_ status: ProjectDbm.ProjectStatus) throws -> EventLoopFuture<[ProjectDbm]> {
        let result = filterValues { project in status == project.status }
        return success(result)
    }
    
    // Helpers
    
    private func filterValues(_ filter: (ProjectDbm) -> Bool) -> [ProjectDbm] {
        return storage.map { key, value -> ProjectDbm in value }.filter(filter)
    }
    
}
