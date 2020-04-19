import Foundation
import Vapor

class PersistenceFactory {
    
    private let config: PersistenceConfig
    private let timeProvider: TimeProvider
    private let lock = DispatchSemaphore(value: 1)
    
    // In-mem instances
    
    private var account: IAccountPersistence? = nil
    
    init(
        config: PersistenceConfig,
        timeProvider: TimeProvider 
    ) {
        self.config = config
        self.timeProvider = timeProvider
    }
    
    func accountPersistenceFor(request: Request) -> IAccountPersistence {
        switch config.type {
            case .mysql:
                return AccountPersistenceMySQL(timeProvider: timeProvider, request: request)
            case .inmem:
                createAccountInMem()
                return AccountPersistenceInMem(timeProvider: timeProvider)
        }
    }
    
    // Helpers
    
    private func createAccountInMem() {
        lock.wait()
        defer { lock.signal() }
        
        if (account == nil) {
            account = AccountPersistenceInMem(timeProvider: timeProvider)
        }
    }
    
}
