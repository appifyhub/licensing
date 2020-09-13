import Foundation
import NIO

extension ConfiguredProperty : HasPersistenceKey {
    typealias KeyType = Int
    
    var persistenceKey: Int { ID ?? 0 }
}

class IConfiguredPropertyPersistence : IPersistence<ConfiguredProperty> {
    
    let timeProvider: TimeProvider
    
    init(timeProvider: TimeProvider) {
        self.timeProvider = timeProvider
    }
    
    func findAllByAssignedService(id: Int) throws -> NIO.EventLoopFuture<[ConfiguredProperty]> { unsupported() }
    
    func findOneByAssignedService(id: Int) throws -> NIO.EventLoopFuture<ConfiguredProperty?> { unsupported() }
    
    func findAllByProperty(id: Int) throws -> NIO.EventLoopFuture<[ConfiguredProperty]> { unsupported() }
    
    func findOneByProperty(id: Int) throws -> NIO.EventLoopFuture<ConfiguredProperty?> { unsupported() }
    
    func findAllByAssignedServiceAndProperty(assignedServiceID: Int, propertyID: Int) throws -> NIO.EventLoopFuture<[ConfiguredProperty]> { unsupported() }
    
    func findOneByAssignedServiceAndProperty(assignedServiceID: Int, propertyID: Int) throws -> NIO.EventLoopFuture<ConfiguredProperty?> { unsupported() }
    
    func findAllByValue(value: String) throws -> NIO.EventLoopFuture<[ConfiguredProperty]> { unsupported() }
    
    func findOneByValue(value: String) throws -> NIO.EventLoopFuture<ConfiguredProperty?> { unsupported() }
    
}
