import XCTest

@testable import App

class AccountInMemCacheTest : XCTestCase {
    
    private var cache: IAccountCache = AccountInMemCache(maxSize: 10)
    
    func test_emptyCache_get_isNil() throws {
        let invalidKey = AnyHashable("invalid")
        let getResult = cache.get(invalidKey)
        XCTAssertNil(getResult)
    }
    
    func test_put_get_bothValid() throws {
        let account = createNew()
        
        let putResult = cache.put(account)
        XCTAssertEqual(putResult, account)
        
        let getResult = cache.get(account.cacheKey)
        XCTAssertEqual(getResult, account)
    }
    
    func test_evict() throws {
        let account = createNew()
        cache.put(account)
        
        let evictResult = cache.evict(account.cacheKey)
        XCTAssertEqual(evictResult, account)
        
        let getResult = cache.get(account.cacheKey)
        XCTAssertNil(getResult)
    }
    
    func test_findFirst_found() throws {
        let account1 = createNew(ID: 1, name: "one")
        let account2 = createNew(ID: 2, name: "two")
        let account3 = createNew(ID: 3, name: "one")
        cache.put(account1)
        cache.put(account2)
        cache.put(account3)
        
        let findResult = cache.findFirst { account -> Bool in
            account.name == "one"
        }
        
        XCTAssertNotNil(findResult)
        XCTAssertEqual(findResult!.name, "one")
    }
    
    func test_findFirst_notFound() throws {
        let account = createNew()
        cache.put(account)
        
        let findResult = cache.findFirst { account -> Bool in
            account.name == "invalid"
        }
        
        XCTAssertNil(findResult)
    }
    
    func test_findAll_found() throws {
        let account1 = createNew(ID: 1, name: "one")
        let account2 = createNew(ID: 2, name: "two")
        let account3 = createNew(ID: 3, name: "one")
        cache.put(account1)
        cache.put(account2)
        cache.put(account3)
        
        let findResult = cache.findAll { account -> Bool in
            account.name == "one"
        }
        
        XCTAssertTrue(!findResult.isEmpty)
        XCTAssertEqual(findResult.count, 2)
        XCTAssertTrue(
            findResult.allSatisfy{ account -> Bool in
                account.name == "one"
            }
        )
    }
    
    func test_findAll_notFound() throws {
        let account = createNew()
        cache.put(account)
        
        let findResult = cache.findAll { account -> Bool in
            account.name == "invalid"
        }
        
        XCTAssertTrue(findResult.isEmpty)
    }
    
    func test_cacheFull_putRemovesFirst() throws {
        cache = AccountInMemCache(maxSize: 2)
        let account1 = createNew(ID: 1)
        let account2 = createNew(ID: 2)
        cache.put(account1)
        cache.put(account2)
        
        // make account1 least recently used
        cache.get(account1.cacheKey)
        cache.get(account2.cacheKey)
        
        let account3 = createNew(ID: 3)
        cache.put(account3)
        
        let get1Result = cache.get(account1.cacheKey)
        XCTAssertNil(get1Result)
        
        let get2Result = cache.get(account2.cacheKey)
        let get3Result = cache.get(account3.cacheKey)
        XCTAssertEqual(get2Result, account2)
        XCTAssertEqual(get3Result, account3)
    }
    
    // Helpers
    
    private func createNew(
        ID: Int = 1,
        name: String = "name",
        ownerName: String = "owner",
        email: String = "email",
        phashed: String = "phashed",
        type: Account.AccountType = .personal,
        authority: Account.AccountAuthority = .normal,
        createdAt: Int64 = 1,
        updatedAt: Int64 = 2
    ) -> Account {
        return Account(
            ID: ID,
            name: name,
            ownerName: ownerName,
            email: email,
            phashed: phashed,
            type: type,
            authority: authority,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
    
    // Test config
    
    static let allTests = [
        ("test_emptyCache_get_isNil", test_emptyCache_get_isNil),
        ("test_put_get_bothValid", test_put_get_bothValid),
        ("test_evict", test_evict),
        ("test_findFirst_found", test_findFirst_found),
        ("test_findFirst_notFound", test_findFirst_notFound),
        ("test_findAll_found", test_findAll_found),
        ("test_findAll_notFound", test_findAll_notFound),
        ("test_cacheFull_putRemovesFirst", test_cacheFull_putRemovesFirst)
    ]
    
}
