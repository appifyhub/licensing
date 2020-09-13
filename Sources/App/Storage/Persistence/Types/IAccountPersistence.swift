import Foundation
import NIO

extension AccountDbm : HasPersistenceKey {
    typealias KeyType = Int
    
    var persistenceKey: Int { ID ?? 0 }
}

class IAccountPersistence : IPersistence<AccountDbm> {
    
    let timeProvider: TimeProvider
    
    init(timeProvider: TimeProvider) {
        self.timeProvider = timeProvider
    }
    
    func findAllByName(_ name: String) throws -> NIO.EventLoopFuture<[AccountDbm]> { unsupported() }
    
    func findAllByOwnerName(_ ownerName: String) throws -> NIO.EventLoopFuture<[AccountDbm]> { unsupported() }
    
    func findOneByEmail(_ email: String) throws -> NIO.EventLoopFuture<AccountDbm?> { unsupported() }
    
    func findAllByType(_ type: AccountDbm.AccountType) throws -> NIO.EventLoopFuture<[AccountDbm]> { unsupported() }
    
    func findAllByAuthority(_ authority: AccountDbm.AccountAuthority) throws -> NIO.EventLoopFuture<[AccountDbm]> { unsupported() }
    
}
