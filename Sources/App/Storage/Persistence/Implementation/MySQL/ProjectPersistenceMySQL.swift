import Foundation
import Vapor
import MySQL

extension ProjectDbm : SQLTable {
    static var sqlTableIdentifierString: String = "Project"
}

class ProjectPersistenceMySQL : IProjectPersistence {
    
    private let request: Request
    
    init(
        timeProvider: TimeProvider,
        request: Request
    ) {
        self.request = request
        super.init(timeProvider: timeProvider)
    }
    
    // CRUD
    
    override func create(_ model: ProjectDbm) throws -> EventLoopFuture<ProjectDbm> {
        let newModel = model
            .withCurrentCreateTime(timeProvider)
            .withCurrentUpdateTime(timeProvider)
        return onConnected { connection in
            try connection
                .insert(into: ProjectDbm.self)
                .value(newModel)
                .run()
                .flatMap { _ in try self.read( (connection.lastMetadata?.lastInsertID(as: Int.self))! )}
                .unwrap(or: "Model not found by its ID")
        }
    }
    
    override func read(_ key: Int) throws -> EventLoopFuture<ProjectDbm?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ProjectDbm.self)
                .where(\ProjectDbm.ID == key)
                .limit(1)
                .all(decoding: ProjectDbm.self)
                .map { results in results.first }
        }
    }
    
    override func update(_ model: ProjectDbm) throws -> EventLoopFuture<ProjectDbm> {
        let newModel = model.withCurrentUpdateTime(timeProvider)
        return onConnected { connection in
            connection
                .update(ProjectDbm.self)
                .set(newModel)
                .where(\ProjectDbm.ID == newModel.ID!)
                .run()
                .flatMap { _ in try self.read(newModel.ID!) }
                .unwrap(or: "Model ID not found by its ID")
        }
    }
    
    override func delete(_ key: Int) throws -> EventLoopFuture<Bool> {
        return onConnected { connection in
            connection
                .delete(from: ProjectDbm.self)
                .where(\ProjectDbm.ID == key)
                .run()
                .map { _ in true }
        }
    }
    
    // Additional queries
    
    override func findAllByAccount(id: Int) throws -> EventLoopFuture<[ProjectDbm]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ProjectDbm.self)
                .where(\ProjectDbm.accountID == id)
                .all(decoding: ProjectDbm.self)
        }
    }
    
    override func findOneByAccount(id: Int) throws -> EventLoopFuture<ProjectDbm?> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ProjectDbm.self)
                .where(\ProjectDbm.accountID == id)
                .limit(1)
                .all(decoding: ProjectDbm.self)
                .map { results in results.first }
        }
    }
    
    override func findAllByName(_ name: String) throws -> EventLoopFuture<[ProjectDbm]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ProjectDbm.self)
                .where(\ProjectDbm.name == name)
                .all(decoding: ProjectDbm.self)
        }
    }
    
    override func findAllByType(_ type: ProjectDbm.ProjectType) throws -> EventLoopFuture<[ProjectDbm]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ProjectDbm.self)
                .where(\ProjectDbm.type == type)
                .all(decoding: ProjectDbm.self)
        }
    }
    
    override func findAllByStatus(_ status: ProjectDbm.ProjectStatus) throws -> EventLoopFuture<[ProjectDbm]> {
        return onConnected { connection in
            connection
                .select()
                .all()
                .from(ProjectDbm.self)
                .where(\ProjectDbm.status == status)
                .all(decoding: ProjectDbm.self)
        }
    }
    
    // Helpers
    
    private func onConnected<T>(_ closure: @escaping (MySQLConnection) throws -> EventLoopFuture<T>) -> EventLoopFuture<T> {
        return request.withPooledConnection(to: .mysql, closure: closure)
    }
    
}
