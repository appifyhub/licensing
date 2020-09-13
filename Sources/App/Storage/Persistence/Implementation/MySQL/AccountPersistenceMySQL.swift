import Foundation
import Vapor
import MySQL

extension AccountDbm : SQLTable {
    static var sqlTableIdentifierString: String = "Account"
}

class AccountPersistenceMySQL : IAccountPersistence {
    
    private let request: Request
    
    init(
        timeProvider: TimeProvider,
        request: Request
    ) {
        self.request = request
        super.init(timeProvider: timeProvider)
    }
    
    // CRUD
    
    override func create(_ model: AccountDbm) throws -> EventLoopFuture<AccountDbm> {
        let newModel = model
            .withCurrentCreateTime(timeProvider)
            .withCurrentUpdateTime(timeProvider)
        return onConnected { connection in
            try connection
                .insert(into: AccountDbm.self)
                .value(newModel)
                .run()
                .flatMap { _ in try self.read( (connection.lastMetadata?.lastInsertID(as: Int.self))! )}
                .unwrap(or: "Model not found by its ID")
        }
    }
    
    override func read(_ key: Int) throws -> EventLoopFuture<AccountDbm?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(AccountDbm.self)
                .where(\AccountDbm.ID == key)
                .limit(1)
                .all(decoding: AccountDbm.self)
                .map { results in results.first }
        }
    }
    
    override func update(_ model: AccountDbm) throws -> EventLoopFuture<AccountDbm> {
        let newModel = model.withCurrentUpdateTime(timeProvider)
        return onConnected { connection in
            connection
                .update(AccountDbm.self)
                .set(newModel)
                .where(\AccountDbm.ID == newModel.ID!)
                .run()
                .flatMap { _ in try self.read(newModel.ID!) }
                .unwrap(or: "Model ID not found by its ID")
        }
    }
    
    override func delete(_ key: Int) throws -> EventLoopFuture<Bool> {
        return onConnected { connection in
            connection
                .delete(from: AccountDbm.self)
                .where(\AccountDbm.ID == key)
                .run()
                .map { _ in true }
        }
    }
    
    // Additional queries
    
    override func findAllByName(_ name: String) throws -> EventLoopFuture<[AccountDbm]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(AccountDbm.self)
                .where(\AccountDbm.name == name)
                .all(decoding: AccountDbm.self)
        }
    }
    
    override func findAllByOwnerName(_ ownerName: String) throws -> EventLoopFuture<[AccountDbm]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(AccountDbm.self)
                .where(\AccountDbm.ownerName == ownerName)
                .all(decoding: AccountDbm.self)
        }
    }
    
    override func findOneByEmail(_ email: String) throws -> EventLoopFuture<AccountDbm?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(AccountDbm.self)
                .where(\AccountDbm.email == email)
                .limit(1)
                .all(decoding: AccountDbm.self)
                .map { results in results.first }
        }
    }
    
    override func findAllByType(_ type: AccountDbm.AccountType) throws -> EventLoopFuture<[AccountDbm]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(AccountDbm.self)
                .where(\AccountDbm.type == type)
                .all(decoding: AccountDbm.self)
        }
    }
    
    override func findAllByAuthority(_ authority: AccountDbm.AccountAuthority) throws -> EventLoopFuture<[AccountDbm]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(AccountDbm.self)
                .where(\AccountDbm.authority == authority)
                .all(decoding: AccountDbm.self)
        }
    }
    
    // Helpers
    
    private func onConnected<T>(_ closure: @escaping (MySQLConnection) throws -> EventLoopFuture<T>) -> EventLoopFuture<T> {
        return request.withPooledConnection(to: .mysql, closure: closure)
    }
    
}
