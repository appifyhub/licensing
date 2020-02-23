import Foundation

struct Project : Hashable {
    
    enum ProjectType : Int {
        case opensource
        case commercial
        case free
    }
    
    enum ProjectStatus : Int {
        case review
        case active
        case blocked
        case suspended
    }
    
    let ID: Int
    let accountID: Int
    let name: String
    let type: ProjectType
    let status: ProjectStatus
    let createdAt: Int64
    let updatedAt: Int64
    
    func withChangedName(_ newName: String) -> Project {
        return Project(
            ID: ID,
            accountID: accountID,
            name: newName,
            type: type,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
    
    func withChangedType(_ newType: ProjectType) -> Project {
        return Project(
            ID: ID,
            accountID: accountID,
            name: name,
            type: newType,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
    
    func withChangedStatus(_ newStatus: ProjectStatus) -> Project {
        return Project(
            ID: ID,
            accountID: accountID,
            name: name,
            type: type,
            status: newStatus,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
    
    func withCurrentUpdateTime(_ timeProvider: TimeProvider) -> Project {
        return Project(
            ID: ID,
            accountID: accountID,
            name: name,
            type: type,
            status: status,
            createdAt: createdAt,
            updatedAt: timeProvider.epochMillis()
        )
    }
    
}

extension Project : Comparable {
    
    static func < (lhs: Project, rhs: Project) -> Bool {
        return lhs.ID < rhs.ID
    }
    
    static func <= (lhs: Project, rhs: Project) -> Bool {
        return lhs.ID <= rhs.ID
    }
    
    static func >= (lhs: Project, rhs: Project) -> Bool {
        return lhs.ID >= rhs.ID
    }
    
    static func > (lhs: Project, rhs: Project) -> Bool {
        return lhs.ID > rhs.ID
    }
    
}
