import Foundation
import NIO

extension AssignedService : HasPersistenceKey {
    typealias KeyType = Int
    
    var persistenceKey: Int { ID ?? 0 }
}

class IAssignedServicePersistence : IPersistence<AssignedService> {
    
    let timeProvider: TimeProvider
    
    init(timeProvider: TimeProvider) {
        self.timeProvider = timeProvider
    }
    
    func findAllByProject(id: Int) throws -> NIO.EventLoopFuture<[AssignedService]> { unsupported() }
    
    func findOneByProject(id: Int) throws -> NIO.EventLoopFuture<AssignedService?> { unsupported() }
    
    func findAllByService(id: Int) throws -> NIO.EventLoopFuture<[AssignedService]> { unsupported() }
    
    func findOneByService(id: Int) throws -> NIO.EventLoopFuture<AssignedService?> { unsupported() }
    
    func findAllByProjectAndService(projectID: Int, serviceID: Int) throws -> NIO.EventLoopFuture<[AssignedService]> { unsupported() }
    
    func findOneByProjectAndService(projectID: Int, serviceID: Int) throws -> NIO.EventLoopFuture<AssignedService?> { unsupported() }
    
}
