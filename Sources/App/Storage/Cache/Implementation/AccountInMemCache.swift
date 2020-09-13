import Foundation

class AccountInMemCache : IAccountCache {
    
    private let storage: ICache<AccountDbm>
    
    init(maxSize: Int) {
        storage = LRUCache(maxSize: maxSize)
    }
    
    override func put(_ model: AccountDbm) -> AccountDbm {
        return storage.put(model)
    }
    
    override func get(_ key: AnyHashable) -> AccountDbm? {
        return storage.get(key)
    }
    
    override func evict(_ key: AnyHashable) -> AccountDbm? {
        return storage.evict(key)
    }
    
    override func findFirst(_ filter: (AccountDbm) -> Bool) -> AccountDbm? {
        return storage.findFirst(filter)
    }
    
    override func findAll(_ filter: (AccountDbm) -> Bool) -> [AccountDbm] {
        return storage.findAll(filter)
    }
    
}
