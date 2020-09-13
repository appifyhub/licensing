import Foundation
import NIO

extension AssignedServiceDbm : HasPersistenceKey {
    typealias KeyType = Int
    
    var persistenceKey: Int { ID ?? 0 }
}

class IAssignedServicePersistence : IPersistence<AssignedServiceDbm> {
    
    let timeProvider: TimeProvider
    
    init(timeProvider: TimeProvider) {
        self.timeProvider = timeProvider
    }
    
    func findAllByProject(id: Int) throws -> NIO.EventLoopFuture<[AssignedServiceDbm]> { unsupported() }
    
    func findOneByProject(id: Int) throws -> NIO.EventLoopFuture<AssignedServiceDbm?> { unsupported() }
    
    func findAllByService(id: Int) throws -> NIO.EventLoopFuture<[AssignedServiceDbm]> { unsupported() }
    
    func findOneByService(id: Int) throws -> NIO.EventLoopFuture<AssignedServiceDbm?> { unsupported() }
    
    func findAllByProjectAndService(projectID: Int, serviceID: Int) throws -> NIO.EventLoopFuture<[AssignedServiceDbm]> { unsupported() }
    
    func findOneByProjectAndService(projectID: Int, serviceID: Int) throws -> NIO.EventLoopFuture<AssignedServiceDbm?> { unsupported() }
    
}
