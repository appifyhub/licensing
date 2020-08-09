import Foundation
import NIO

class ProjectPersistenceInMem : IProjectPersistence {
    
    private var storage: [Int : Project] = [:]
    private var currentId = AtomicInteger(value: 0)
    
    override init(timeProvider: TimeProvider) {
        super.init(timeProvider: timeProvider)
    }
    
    // CRUD
    
    override func create(_ model: Project) -> EventLoopFuture<Project> {
        let newModel = model
            .tryWithChangedID(currentId.incrementAndGet())
            .withCurrentCreateTime(timeProvider)
            .withCurrentUpdateTime(timeProvider)
        storage[newModel.persistenceKey] = newModel
        return success(newModel)
    }
    
    override func read(_ key: Int) -> EventLoopFuture<Project?> {
        return success(storage[key])
    }
    
    override func update(_ model: Project) -> EventLoopFuture<Project> {
        let newModel = model.withCurrentUpdateTime(timeProvider)
        storage[newModel.persistenceKey] = newModel
        return success(newModel)
    }
    
    override func delete(_ key: Int) -> EventLoopFuture<Bool> {
        let removedValue = storage.removeValue(forKey: key)
        return success(removedValue != nil)
    }
    
    // Additional queries
    
    override func findAllByAccount(id: Int) throws -> EventLoopFuture<[Project]> {
        let result = filterValues { project in id == project.accountID }
        return success(result)
    }
    
    override func findOneByAccount(id: Int) throws -> EventLoopFuture<Project?> {
        let result = filterValues { project in id == project.accountID }
        return success(result.first)
    }
    
    override func findAllByName(_ name: String) -> EventLoopFuture<[Project]> {
        let result = filterValues { project in name == project.name }
        return success(result)
    }
    
    override func findAllByType(_ type: Project.ProjectType) throws -> EventLoopFuture<[Project]> {
        let result = filterValues { project in type == project.type }
        return success(result)
    }
    
    override func findAllByStatus(_ status: Project.ProjectStatus) throws -> EventLoopFuture<[Project]> {
        let result = filterValues { project in status == project.status }
        return success(result)
    }
    
    // Helpers
    
    private func filterValues(_ filter: (Project) -> Bool) -> [Project] {
        return storage.map { key, value -> Project in value }.filter(filter)
    }
    
}
