import Foundation
import NIO

extension Access : HasPersistenceKey {
    typealias KeyType = String
    
    var persistenceKey: String { token ?? "invalid" }
}

class IAccessPersistence : IPersistence<Access> {
    
    let timeProvider: TimeProvider
    
    init(timeProvider: TimeProvider) {
        self.timeProvider = timeProvider
    }
    
    func findAllByAccountID(_ accountID: Int) throws -> NIO.EventLoopFuture<[Access]> { unsupported() }
    
    func findOneByAccountID(_ accountID: Int) throws -> NIO.EventLoopFuture<Access?> { unsupported() }
    
}