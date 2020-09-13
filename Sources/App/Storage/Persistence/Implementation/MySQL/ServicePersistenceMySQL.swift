import Foundation
import Vapor
import MySQL

extension ServiceDbm : SQLTable {
    static var sqlTableIdentifierString: String = "Service"
}

class ServicePersistenceMySQL : IServicePersistence {
    
    private let request: Request
    
    init(
        timeProvider: TimeProvider,
        request: Request
    ) {
        self.request = request
        super.init(timeProvider: timeProvider)
    }
    
    // CRUD
    
    override func create(_ model: ServiceDbm) throws -> EventLoopFuture<ServiceDbm> {
        let newModel = model
            .withCurrentCreateTime(timeProvider)
            .withCurrentUpdateTime(timeProvider)
        return onConnected { connection in
            try connection
                .insert(into: ServiceDbm.self)
                .value(newModel)
                .run()
                .flatMap { _ in try self.read( (connection.lastMetadata?.lastInsertID(as: Int.self))! )}
                .unwrap(or: "Model not found by its ID")
        }
    }
    
    override func read(_ key: Int) throws -> EventLoopFuture<ServiceDbm?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ServiceDbm.self)
                .where(\ServiceDbm.ID == key)
                .limit(1)
                .all(decoding: ServiceDbm.self)
                .map { results in results.first }
        }
    }
    
    override func update(_ model: ServiceDbm) throws -> EventLoopFuture<ServiceDbm> {
        let newModel = model.withCurrentUpdateTime(timeProvider)
        return onConnected { connection in
            connection
                .update(ServiceDbm.self)
                .set(newModel)
                .where(\ServiceDbm.ID == newModel.ID!)
                .run()
                .flatMap { _ in try self.read(newModel.ID!) }
                .unwrap(or: "Model ID not found by its ID")
        }
    }
    
    override func delete(_ key: Int) throws -> EventLoopFuture<Bool> {
        return onConnected { connection in
            connection
                .delete(from: ServiceDbm.self)
                .where(\ServiceDbm.ID == key)
                .run()
                .map { _ in true }
        }
    }
    
    // Additional queries
    
    override func findOneByName(_ name: String) throws -> EventLoopFuture<ServiceDbm?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ServiceDbm.self)
                .where(\ServiceDbm.name == name)
                .limit(1)
                .all(decoding: ServiceDbm.self)
                .map { results in results.first }
        }
    }
    
    // Helpers
    
    private func onConnected<T>(_ closure: @escaping (MySQLConnection) throws -> EventLoopFuture<T>) -> EventLoopFuture<T> {
        return request.withPooledConnection(to: .mysql, closure: closure)
    }
    
}
