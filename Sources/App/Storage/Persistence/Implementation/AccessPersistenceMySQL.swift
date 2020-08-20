import Foundation
import Vapor
import MySQL

extension Access : SQLTable {}

class AccessPersistenceMySQL : IAccessPersistence {
    
    private let request: Request
    
    init(
        timeProvider: TimeProvider,
        request: Request
    ) {
        self.request = request
        super.init(timeProvider: timeProvider)
    }
    
    // CRUD
    
    override func create(_ model: Access) throws -> EventLoopFuture<Access> {
        if (model.token == nil) {
            return error("Token value cannot be auto-generated")
        }
        
        let newModel = model
            .withCurrentCreateTime(timeProvider)
        return onConnected { connection in
            try connection
                .insert(into: Access.self)
                .value(newModel)
                .run()
                .map { _ in newModel }
        }
    }
    
    override func read(_ key: String) throws -> EventLoopFuture<Access?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(Access.self)
                .where(\Access.token == key)
                .limit(1)
                .all(decoding: Access.self)
                .map { results in results.first }
        }
    }
    
    override func update(_ model: Access) throws -> EventLoopFuture<Access> {
        return onConnected { connection in
            connection
                .update(Access.self)
                .set(model)
                .where(\Access.token == model.token!)
                .run()
                .flatMap { _ in try self.read(model.token!) }
                .unwrap(or: "Model ID not found by its ID")
        }
    }
    
    override func delete(_ key: String) throws -> EventLoopFuture<Bool> {
        return onConnected { connection in
            connection
                .delete(from: Access.self)
                .where(\Access.token == key)
                .run()
                .map { _ in true }
        }
    }
    
    // Additional queries
    
    override func findAllByAccount(id: Int) throws -> EventLoopFuture<[Access]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(Access.self)
                .where(\Access.accountID == id)
                .all(decoding: Access.self)
        }
    }
    
    override func findOneByAccount(id: Int) throws -> EventLoopFuture<Access?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(Access.self)
                .where(\Access.accountID == id)
                .limit(1)
                .all(decoding: Access.self)
                .map { results in results.first }
        }
    }
    
    // Helpers
    
    private func onConnected<T>(_ closure: @escaping (MySQLConnection) throws -> EventLoopFuture<T>) -> EventLoopFuture<T> {
        return request.withPooledConnection(to: .mysql, closure: closure)
    }
    
}
