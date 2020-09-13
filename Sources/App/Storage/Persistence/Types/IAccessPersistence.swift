import Foundation
import NIO

extension AccessDbm : HasPersistenceKey {
    typealias KeyType = String
    
    var persistenceKey: String { token ?? "invalid" }
}

class IAccessPersistence : IPersistence<AccessDbm> {
    
    let timeProvider: TimeProvider
    
    init(timeProvider: TimeProvider) {
        self.timeProvider = timeProvider
    }
    
    func findAllByAccount(id: Int) throws -> NIO.EventLoopFuture<[AccessDbm]> { unsupported() }
    
    func findOneByAccount(id: Int) throws -> NIO.EventLoopFuture<AccessDbm?> { unsupported() }
    
}
