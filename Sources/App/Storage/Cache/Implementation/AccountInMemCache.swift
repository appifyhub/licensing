import Foundation

class AccountInMemCache : IAccountCache {
    
    private let storage: ICache<Account>
    
    init(maxSize: Int) {
        storage = LRUCache(maxSize: maxSize)
    }
    
    override func put(_ model: Account) -> Account {
        return storage.put(model)
    }
    
    override func get(_ key: AnyHashable) -> Account? {
        return storage.get(key)
    }
    
    override func evict(_ key: AnyHashable) -> Account? {
        return storage.evict(key)
    }
    
    override func findFirst(_ filter: (Account) -> Bool) -> Account? {
        return storage.findFirst(filter)
    }
    
    override func findAll(_ filter: (Account) -> Bool) -> [Account] {
        return storage.findAll(filter)
    }
    
}
