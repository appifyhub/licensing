import Foundation
import Vapor
import MySQL

extension Account : SQLTable {}

class AccountPersistenceMySQL : IAccountPersistence {
    
    private var storage: [Int : Account] = [:]
    private let request: Request
    
    init(
        timeProvider: TimeProvider,
        request: Request
    ) {
        self.request = request
        super.init(timeProvider: timeProvider)
    }
    
    // CRUD
    
    override func create(_ model: Account) throws -> EventLoopFuture<Account> {
        let newModel = model
            .withCurrentCreateTime(timeProvider)
            .withCurrentUpdateTime(timeProvider)
        return onConnected { connection in
            try connection
                .insert(into: Account.self)
                .value(newModel)
                .run()
                .flatMap { _ in try self.read( (connection.lastMetadata?.lastInsertID(as: Int.self))! )}
                .unwrap(or: "Model not found by its ID")
        }
    }
    
    override func read(_ key: Int) throws -> EventLoopFuture<Account?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(Account.self)
                .where(\Account.ID == key)
                .limit(1)
                .all(decoding: Account.self)
                .map { results in results.first }
        }
    }
    
    override func update(_ model: Account) throws -> EventLoopFuture<Account> {
        return onConnected { connection in
            connection
                .update(Account.self)
                .set(model)
                .where(\Account.ID == model.ID!)
                .run()
                .flatMap { _ in try self.read(model.ID!) }
                .unwrap(or: "Model ID not found by its ID")
        }
    }
    
    override func delete(_ key: Int) throws -> EventLoopFuture<Bool> {
        return onConnected { connection in
            connection
                .delete(from: Account.self)
                .where(\Account.ID == key)
                .run()
                .map { _ in true }
        }
    }
    
    // Additional queries
    
    override func findAllByName(_ name: String) throws -> EventLoopFuture<[Account]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(Account.self)
                .where(\Account.name == name)
                .all(decoding: Account.self)
        }
    }
    
    override func findAllByOwnerName(_ ownerName: String) throws -> EventLoopFuture<[Account]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(Account.self)
                .where(\Account.ownerName == ownerName)
                .all(decoding: Account.self)
        }
    }
    
    override func findOneByEmail(_ email: String) throws -> EventLoopFuture<Account?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(Account.self)
                .where(\Account.email == email)
                .limit(1)
                .all(decoding: Account.self)
                .map { results in results.first }
        }
    }
    
    override func findAllByType(_ type: Account.AccountType) throws -> EventLoopFuture<[Account]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(Account.self)
                .where(\Account.type == type)
                .all(decoding: Account.self)
        }
    }
    
    override func findAllByAuthority(_ authority: Account.AccountAuthority) throws -> EventLoopFuture<[Account]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(Account.self)
                .where(\Account.authority == authority)
                .all(decoding: Account.self)
        }
    }
    
    // Helpers
    
    private func onConnected<T>(_ closure: @escaping (MySQLConnection) throws -> EventLoopFuture<T>) -> EventLoopFuture<T> {
        return request.withPooledConnection(to: .mysql, closure: closure)
    }
    
}
