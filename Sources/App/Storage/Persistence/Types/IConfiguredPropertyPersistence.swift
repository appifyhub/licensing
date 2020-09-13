import Foundation
import NIO

extension ConfiguredPropertyDbm : HasPersistenceKey {
    typealias KeyType = Int
    
    var persistenceKey: Int { ID ?? 0 }
}

class IConfiguredPropertyPersistence : IPersistence<ConfiguredPropertyDbm> {
    
    let timeProvider: TimeProvider
    
    init(timeProvider: TimeProvider) {
        self.timeProvider = timeProvider
    }
    
    func findAllByAssignedService(id: Int) throws -> NIO.EventLoopFuture<[ConfiguredPropertyDbm]> { unsupported() }
    
    func findOneByAssignedService(id: Int) throws -> NIO.EventLoopFuture<ConfiguredPropertyDbm?> { unsupported() }
    
    func findAllByProperty(id: Int) throws -> NIO.EventLoopFuture<[ConfiguredPropertyDbm]> { unsupported() }
    
    func findOneByProperty(id: Int) throws -> NIO.EventLoopFuture<ConfiguredPropertyDbm?> { unsupported() }
    
    func findAllByAssignedServiceAndProperty(assignedServiceID: Int, propertyID: Int) throws -> NIO.EventLoopFuture<[ConfiguredPropertyDbm]> { unsupported() }
    
    func findOneByAssignedServiceAndProperty(assignedServiceID: Int, propertyID: Int) throws -> NIO.EventLoopFuture<ConfiguredPropertyDbm?> { unsupported() }
    
    func findAllByValue(value: String) throws -> NIO.EventLoopFuture<[ConfiguredPropertyDbm]> { unsupported() }
    
    func findOneByValue(value: String) throws -> NIO.EventLoopFuture<ConfiguredPropertyDbm?> { unsupported() }
    
}
