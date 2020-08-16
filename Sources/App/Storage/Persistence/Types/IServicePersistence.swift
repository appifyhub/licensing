import Foundation
import NIO

extension Service : HasPersistenceKey {
    typealias KeyType = Int
    
    var persistenceKey: Int { ID ?? 0 }
}

class IServicePersistence : IPersistence<Service> {
    
    let timeProvider: TimeProvider
    
    init(timeProvider: TimeProvider) {
        self.timeProvider = timeProvider
    }
    
    func findOneByName(_ name: String) throws -> NIO.EventLoopFuture<Service?> { unsupported() }
    
}
