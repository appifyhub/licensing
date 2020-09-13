import Foundation
import NIO

class AccountPersistenceInMem : IAccountPersistence {
    
    private var storage: [Int : AccountDbm] = [:]
    private var currentId = AtomicInteger(value: 0)
    
    override init(timeProvider: TimeProvider) {
        super.init(timeProvider: timeProvider)
    }
    
    // CRUD
    
    override func create(_ model: AccountDbm) -> EventLoopFuture<AccountDbm> {
        let newModel = model
            .tryWithChangedID(currentId.incrementAndGet())
            .withCurrentCreateTime(timeProvider)
            .withCurrentUpdateTime(timeProvider)
        storage[newModel.persistenceKey] = newModel
        return success(newModel)
    }
    
    override func read(_ key: Int) -> EventLoopFuture<AccountDbm?> {
        return success(storage[key])
    }
    
    override func update(_ model: AccountDbm) -> EventLoopFuture<AccountDbm> {
        let newModel = model.withCurrentUpdateTime(timeProvider)
        storage[newModel.persistenceKey] = newModel
        return success(newModel)
    }
    
    override func delete(_ key: Int) -> EventLoopFuture<Bool> {
        let removedValue = storage.removeValue(forKey: key)
        return success(removedValue != nil)
    }
    
    // Additional queries
    
    override func findAllByName(_ name: String) -> EventLoopFuture<[AccountDbm]> {
        let result = filterValues { account in name == account.name }
        return success(result)
    }
    
    override func findAllByOwnerName(_ ownerName: String) -> EventLoopFuture<[AccountDbm]> {
        let result = filterValues { account in ownerName == account.ownerName }
        return success(result)
    }
    
    override func findOneByEmail(_ email: String) -> EventLoopFuture<AccountDbm?> {
        let result = filterValues { account in email == account.email }
        return success(result.first)
    }
    
    override func findAllByType(_ type: AccountDbm.AccountType) -> EventLoopFuture<[AccountDbm]> {
        let result = filterValues { account in type == account.type }
        return success(result)
    }
    
    override func findAllByAuthority(_ authority: AccountDbm.AccountAuthority) -> EventLoopFuture<[AccountDbm]> {
        let result = filterValues { account in authority == account.authority }
        return success(result)
    }
    
    // Helpers
    
    private func filterValues(_ filter: (AccountDbm) -> Bool) -> [AccountDbm] {
        return storage.map { key, value -> AccountDbm in value }.filter(filter)
    }
    
}
