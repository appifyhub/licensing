import Foundation
import NIO

extension Account : HasPersistenceKey {
    typealias KeyType = Int
    
    var persistenceKey: Int { ID ?? 0 }
}

class IAccountPersistence : IPersistence<Account> {
    
    let timeProvider: TimeProvider
    
    init(timeProvider: TimeProvider) {
        self.timeProvider = timeProvider
    }
    
    func findAllByName(_ name: String) throws -> NIO.EventLoopFuture<[Account]> { unsupported() }
    
    func findAllByOwnerName(_ ownerName: String) throws -> NIO.EventLoopFuture<[Account]> { unsupported() }
    
    func findOneByEmail(_ email: String) throws -> NIO.EventLoopFuture<Account?> { unsupported() }
    
    func findAllByType(_ type: Account.AccountType) throws -> NIO.EventLoopFuture<[Account]> { unsupported() }
    
    func findAllByAuthority(_ authority: Account.AccountAuthority) throws -> NIO.EventLoopFuture<[Account]> { unsupported() }
    
}
