import Foundation
import NIO

extension ServiceDbm : HasPersistenceKey {
    typealias KeyType = Int
    
    var persistenceKey: Int { ID ?? 0 }
}

class IServicePersistence : IPersistence<ServiceDbm> {
    
    let timeProvider: TimeProvider
    
    init(timeProvider: TimeProvider) {
        self.timeProvider = timeProvider
    }
    
    func findOneByName(_ name: String) throws -> NIO.EventLoopFuture<ServiceDbm?> { unsupported() }
    
}
