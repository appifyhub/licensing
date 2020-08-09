import Foundation
import NIO

extension Project : HasPersistenceKey {
    typealias KeyType = Int
    
    var persistenceKey: Int { ID ?? 0 }
}

class IProjectPersistence : IPersistence<Project> {
    
    let timeProvider: TimeProvider
    
    init(timeProvider: TimeProvider) {
        self.timeProvider = timeProvider
    }
    
    func findAllByAccount(id: Int) throws -> NIO.EventLoopFuture<[Project]> { unsupported() }
    
    func findOneByAccount(id: Int) throws -> NIO.EventLoopFuture<Project?> { unsupported() }
    
    func findAllByName(_ name: String) throws -> NIO.EventLoopFuture<[Project]> { unsupported() }
    
    func findAllByType(_ type: Project.ProjectType) throws -> NIO.EventLoopFuture<[Project]> { unsupported() }
    
    func findAllByStatus(_ status: Project.ProjectStatus) throws -> NIO.EventLoopFuture<[Project]> { unsupported() }
    
}
