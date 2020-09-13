import Foundation
import NIO

extension ProjectDbm : HasPersistenceKey {
    typealias KeyType = Int
    
    var persistenceKey: Int { ID ?? 0 }
}

class IProjectPersistence : IPersistence<ProjectDbm> {
    
    let timeProvider: TimeProvider
    
    init(timeProvider: TimeProvider) {
        self.timeProvider = timeProvider
    }
    
    func findAllByAccount(id: Int) throws -> NIO.EventLoopFuture<[ProjectDbm]> { unsupported() }
    
    func findOneByAccount(id: Int) throws -> NIO.EventLoopFuture<ProjectDbm?> { unsupported() }
    
    func findAllByName(_ name: String) throws -> NIO.EventLoopFuture<[ProjectDbm]> { unsupported() }
    
    func findAllByType(_ type: ProjectDbm.ProjectType) throws -> NIO.EventLoopFuture<[ProjectDbm]> { unsupported() }
    
    func findAllByStatus(_ status: ProjectDbm.ProjectStatus) throws -> NIO.EventLoopFuture<[ProjectDbm]> { unsupported() }
    
}
