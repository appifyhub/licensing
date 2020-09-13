import Foundation
import Vapor
import MySQL

extension AssignedServiceDbm : SQLTable {
    static var sqlTableIdentifierString: String = "AssignedService"
}

class AssignedServicePersistenceMySQL : IAssignedServicePersistence {
    
    private let request: Request
    
    init(
        timeProvider: TimeProvider,
        request: Request
    ) {
        self.request = request
        super.init(timeProvider: timeProvider)
    }
    
    // CRUD
    
    override func create(_ model: AssignedServiceDbm) throws -> EventLoopFuture<AssignedServiceDbm> {
        let newModel = model
            .withCurrentAssignmentTime(timeProvider)
        return onConnected { connection in
            try connection
                .insert(into: AssignedServiceDbm.self)
                .value(newModel)
                .run()
                .flatMap { _ in try self.read( (connection.lastMetadata?.lastInsertID(as: Int.self))! )}
                .unwrap(or: "Model not found by its ID")
        }
    }
    
    override func read(_ key: Int) throws -> EventLoopFuture<AssignedServiceDbm?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(AssignedServiceDbm.self)
                .where(\AssignedServiceDbm.ID == key)
                .limit(1)
                .all(decoding: AssignedServiceDbm.self)
                .map { results in results.first }
        }
    }
    
    override func update(_ model: AssignedServiceDbm) throws -> EventLoopFuture<AssignedServiceDbm> {
        let newModel = model.withCurrentAssignmentTime(timeProvider)
        return onConnected { connection in
            connection
                .update(AssignedServiceDbm.self)
                .set(newModel)
                .where(\AssignedServiceDbm.ID == newModel.ID!)
                .run()
                .flatMap { _ in try self.read(newModel.ID!) }
                .unwrap(or: "Model ID not found by its ID")
        }
    }
    
    override func delete(_ key: Int) throws -> EventLoopFuture<Bool> {
        return onConnected { connection in
            connection
                .delete(from: AssignedServiceDbm.self)
                .where(\AssignedServiceDbm.ID == key)
                .run()
                .map { _ in true }
        }
    }
    
    // Additional queries
    
    override func findAllByProject(id: Int) throws -> EventLoopFuture<[AssignedServiceDbm]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(AssignedServiceDbm.self)
                .where(\AssignedServiceDbm.projectID == id)
                .all(decoding: AssignedServiceDbm.self)
        }
    }
    
    override func findOneByProject(id: Int) throws -> EventLoopFuture<AssignedServiceDbm?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(AssignedServiceDbm.self)
                .where(\AssignedServiceDbm.projectID == id)
                .limit(1)
                .all(decoding: AssignedServiceDbm.self)
                .map { results in results.first }
        }
    }
    
    override func findAllByService(id: Int) throws -> EventLoopFuture<[AssignedServiceDbm]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(AssignedServiceDbm.self)
                .where(\AssignedServiceDbm.serviceID == id)
                .all(decoding: AssignedServiceDbm.self)
        }
    }
    
    override func findOneByService(id: Int) throws -> EventLoopFuture<AssignedServiceDbm?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(AssignedServiceDbm.self)
                .where(\AssignedServiceDbm.serviceID == id)
                .limit(1)
                .all(decoding: AssignedServiceDbm.self)
                .map { results in results.first }
        }
    }
    
    override func findAllByProjectAndService(projectID: Int, serviceID: Int) throws -> EventLoopFuture<[AssignedServiceDbm]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(AssignedServiceDbm.self)
                .where(\AssignedServiceDbm.projectID == projectID)
                .where(\AssignedServiceDbm.serviceID == serviceID)
                .all(decoding: AssignedServiceDbm.self)
        }
    }
    
    override func findOneByProjectAndService(projectID: Int, serviceID: Int) throws -> EventLoopFuture<AssignedServiceDbm?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(AssignedServiceDbm.self)
                .where(\AssignedServiceDbm.projectID == projectID)
                .where(\AssignedServiceDbm.serviceID == serviceID)
                .limit(1)
                .all(decoding: AssignedServiceDbm.self)
                .map { results in results.first }
        }
    }
    
    // Helpers
    
    private func onConnected<T>(_ closure: @escaping (MySQLConnection) throws -> EventLoopFuture<T>) -> EventLoopFuture<T> {
        return request.withPooledConnection(to: .mysql, closure: closure)
    }
    
}
