import Foundation
import Vapor
import MySQL

extension ConfiguredPropertyDbm : SQLTable {
    static var sqlTableIdentifierString: String = "ConfiguredProperty"
}

class ConfiguredPropertyPersistenceMySQL : IConfiguredPropertyPersistence {
    
    private let request: Request
    
    init(
        timeProvider: TimeProvider,
        request: Request
    ) {
        self.request = request
        super.init(timeProvider: timeProvider)
    }
    
    // CRUD
    
    override func create(_ model: ConfiguredPropertyDbm) throws -> EventLoopFuture<ConfiguredPropertyDbm> {
        let newModel = model
            .withCurrentCreateTime(timeProvider)
            .withCurrentUpdateTime(timeProvider)
        return onConnected { connection in
            try connection
                .insert(into: ConfiguredPropertyDbm.self)
                .value(newModel)
                .run()
                .flatMap { _ in try self.read( (connection.lastMetadata?.lastInsertID(as: Int.self))! )}
                .unwrap(or: "Model not found by its ID")
        }
    }
    
    override func read(_ key: Int) throws -> EventLoopFuture<ConfiguredPropertyDbm?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ConfiguredPropertyDbm.self)
                .where(\ConfiguredPropertyDbm.ID == key)
                .limit(1)
                .all(decoding: ConfiguredPropertyDbm.self)
                .map { results in results.first }
        }
    }
    
    override func update(_ model: ConfiguredPropertyDbm) throws -> EventLoopFuture<ConfiguredPropertyDbm> {
        let newModel = model.withCurrentUpdateTime(timeProvider)
        return onConnected { connection in
            connection
                .update(ConfiguredPropertyDbm.self)
                .set(newModel)
                .where(\ConfiguredPropertyDbm.ID == newModel.ID!)
                .run()
                .flatMap { _ in try self.read(newModel.ID!) }
                .unwrap(or: "Model ID not found by its ID")
        }
    }
    
    override func delete(_ key: Int) throws -> EventLoopFuture<Bool> {
        return onConnected { connection in
            connection
                .delete(from: ConfiguredPropertyDbm.self)
                .where(\ConfiguredPropertyDbm.ID == key)
                .run()
                .map { _ in true }
        }
    }
    
    // Additional queries
    
    override func findAllByAssignedService(id: Int) throws -> EventLoopFuture<[ConfiguredPropertyDbm]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ConfiguredPropertyDbm.self)
                .where(\ConfiguredPropertyDbm.assignedServiceID == id)
                .all(decoding: ConfiguredPropertyDbm.self)
        }
    }
    
    override func findOneByAssignedService(id: Int) throws -> EventLoopFuture<ConfiguredPropertyDbm?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ConfiguredPropertyDbm.self)
                .where(\ConfiguredPropertyDbm.assignedServiceID == id)
                .limit(1)
                .all(decoding: ConfiguredPropertyDbm.self)
                .map { results in results.first }
        }
    }
    
    override func findAllByProperty(id: Int) throws -> EventLoopFuture<[ConfiguredPropertyDbm]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ConfiguredPropertyDbm.self)
                .where(\ConfiguredPropertyDbm.propertyID == id)
                .all(decoding: ConfiguredPropertyDbm.self)
        }
    }
    
    override func findOneByProperty(id: Int) throws -> EventLoopFuture<ConfiguredPropertyDbm?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ConfiguredPropertyDbm.self)
                .where(\ConfiguredPropertyDbm.propertyID == id)
                .limit(1)
                .all(decoding: ConfiguredPropertyDbm.self)
                .map { results in results.first }
        }
    }
    
    override func findAllByAssignedServiceAndProperty(assignedServiceID: Int, propertyID: Int) throws -> EventLoopFuture<[ConfiguredPropertyDbm]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ConfiguredPropertyDbm.self)
                .where(\ConfiguredPropertyDbm.assignedServiceID == assignedServiceID)
                .where(\ConfiguredPropertyDbm.propertyID == propertyID)
                .all(decoding: ConfiguredPropertyDbm.self)
        }
    }
    
    override func findOneByAssignedServiceAndProperty(assignedServiceID: Int, propertyID: Int) throws -> EventLoopFuture<ConfiguredPropertyDbm?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ConfiguredPropertyDbm.self)
                .where(\ConfiguredPropertyDbm.assignedServiceID == assignedServiceID)
                .where(\ConfiguredPropertyDbm.propertyID == propertyID)
                .limit(1)
                .all(decoding: ConfiguredPropertyDbm.self)
                .map { results in results.first }
        }
    }
    
    override func findAllByValue(value: String) throws -> EventLoopFuture<[ConfiguredPropertyDbm]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ConfiguredPropertyDbm.self)
                .where(\ConfiguredPropertyDbm.value == value)
                .all(decoding: ConfiguredPropertyDbm.self)
        }
    }
    
    override func findOneByValue(value: String) throws -> EventLoopFuture<ConfiguredPropertyDbm?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ConfiguredPropertyDbm.self)
                .where(\ConfiguredPropertyDbm.value == value)
                .limit(1)
                .all(decoding: ConfiguredPropertyDbm.self)
                .map { results in results.first }
        }
    }
    
    // Helpers
    
    private func onConnected<T>(_ closure: @escaping (MySQLConnection) throws -> EventLoopFuture<T>) -> EventLoopFuture<T> {
        return request.withPooledConnection(to: .mysql, closure: closure)
    }
    
}
