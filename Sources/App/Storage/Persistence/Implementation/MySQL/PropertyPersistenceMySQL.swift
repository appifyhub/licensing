import Foundation
import Vapor
import MySQL

extension PropertyDbm : SQLTable {
    static var sqlTableIdentifierString: String = "Property"
}

class PropertyPersistenceMySQL : IPropertyPersistence {
    
    private let request: Request
    
    init(
        timeProvider: TimeProvider,
        request: Request
    ) {
        self.request = request
        super.init(timeProvider: timeProvider)
    }
    
    // CRUD
    
    override func create(_ model: PropertyDbm) throws -> EventLoopFuture<PropertyDbm> {
        let newModel = model
            .withCurrentCreateTime(timeProvider)
            .withCurrentUpdateTime(timeProvider)
        return onConnected { connection in
            try connection
                .insert(into: PropertyDbm.self)
                .value(newModel)
                .run()
                .flatMap { _ in try self.read( (connection.lastMetadata?.lastInsertID(as: Int.self))! )}
                .unwrap(or: "Model not found by its ID")
        }
    }
    
    override func read(_ key: Int) throws -> EventLoopFuture<PropertyDbm?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(PropertyDbm.self)
                .where(\PropertyDbm.ID == key)
                .limit(1)
                .all(decoding: PropertyDbm.self)
                .map { results in results.first }
        }
    }
    
    override func update(_ model: PropertyDbm) throws -> EventLoopFuture<PropertyDbm> {
        let newModel = model.withCurrentUpdateTime(timeProvider)
        return onConnected { connection in
            connection
                .update(PropertyDbm.self)
                .set(newModel)
                .where(\PropertyDbm.ID == newModel.ID!)
                .run()
                .flatMap { _ in try self.read(newModel.ID!) }
                .unwrap(or: "Model ID not found by its ID")
        }
    }
    
    override func delete(_ key: Int) throws -> EventLoopFuture<Bool> {
        return onConnected { connection in
            connection
                .delete(from: PropertyDbm.self)
                .where(\PropertyDbm.ID == key)
                .run()
                .map { _ in true }
        }
    }
    
    // Additional queries
    
    override func findAllByService(id: Int) throws -> EventLoopFuture<[PropertyDbm]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(PropertyDbm.self)
                .where(\PropertyDbm.serviceID == id)
                .all(decoding: PropertyDbm.self)
        }
    }
    
    override func findAllByName(_ name: String) throws -> EventLoopFuture<[PropertyDbm]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(PropertyDbm.self)
                .where(\PropertyDbm.name == name)
                .all(decoding: PropertyDbm.self)
        }
    }
    
    override func findAllByType(_ type: PropertyDbm.PropertyType) throws -> EventLoopFuture<[PropertyDbm]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(PropertyDbm.self)
                .where(\PropertyDbm.type == type)
                .all(decoding: PropertyDbm.self)
        }
    }
    
    override func findAllByMandatory(_ mandatory: Bool) throws -> EventLoopFuture<[PropertyDbm]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(PropertyDbm.self)
                .where(\PropertyDbm.mandatory == mandatory)
                .all(decoding: PropertyDbm.self)
        }
    }
    
    // Helpers
    
    private func onConnected<T>(_ closure: @escaping (MySQLConnection) throws -> EventLoopFuture<T>) -> EventLoopFuture<T> {
        return request.withPooledConnection(to: .mysql, closure: closure)
    }
    
}
