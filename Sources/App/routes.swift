import Vapor
import MySQL

/// Called when application is ready to set up endpoints.
public func routes(_ router: Router) throws {
    
    router.get("/") { req in try req.view().render("index.html") }
    
    var counter = 0
    let count: () -> Int = {
        counter += 1
        return counter
    }
    
    router.get("/proj/c") { req in
        return try DI.shared().getProjectPersistence(for: req)
            .create(
                Project(
                    accountID: 4,
                    name: "project_\(count())",
                    type: .commercial,
                    status: .active,
                    createdAt: 0,
                    updatedAt: 0
                )
        )
            .map { project in ProjectResponse(project) }
    }
    
    router.get("/proj/r") { req in
        return try DI.shared().getProjectPersistence(for: req)
            .read(2)
            .map { project in ProjectResponse(project!) }
    }
    
    router.get("/proj/u") { req in
        return try DI.shared().getProjectPersistence(for: req)
            .read(2)
            .flatMap { project in
                return try DI.shared().getProjectPersistence(for: req)
                    .update(
                        project!
                            .withChangedName("project_\(count())")
                            .withChangedType(.opensource)
                            .withChangedStatus(.suspended)
                )
        }
        .map { project in ProjectResponse(project) }
    }
    
    router.get("/proj/d") { req in
        return try DI.shared().getProjectPersistence(for: req)
            .delete(1)
            .map { result in MessageResponse(message: "Result = \(result)") }
    }
    
}

private struct ProjectResponse : Content {
    
    let ID: Int
    let accountID: Int
    let name: String
    let type: Project.ProjectType
    let status: Project.ProjectStatus
    let createdAt: Int64
    let updatedAt: Int64
    
    init (
        ID: Int,
        accountID: Int,
        name: String,
        type: Project.ProjectType,
        status: Project.ProjectStatus,
        createdAt: Int64,
        updatedAt: Int64
    ) {
        self.ID = ID
        self.accountID = accountID
        self.name = name
        self.type = type
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init(_ project: Project) {
        self.init(
            ID : project.ID!,
            accountID : project.accountID,
            name : project.name,
            type : project.type,
            status : project.status,
            createdAt : project.createdAt,
            updatedAt : project.updatedAt
        )
    }
    
}
