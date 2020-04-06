import Foundation

final class Project : Codable {
    
    enum ProjectType : Int, Codable {
        case opensource
        case commercial
        case free
    }
    
    enum ProjectStatus : Int, Codable {
        case review
        case active
        case blocked
        case suspended
    }
    
    let ID: Int?
    let accountID: Int
    let name: String
    let type: ProjectType
    let status: ProjectStatus
    let createdAt: Int64
    let updatedAt: Int64
    
    init(
        ID: Int? = nil,
        accountID: Int,
        name: String,
        type: ProjectType,
        status: ProjectStatus,
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
    
}

// safe modifiers
extension Project {
    
    func withChangedName(_ newName: String) -> Project {
        return Project(
            ID: self.ID,
            accountID: self.accountID,
            name: newName,
            type: self.type,
            status: self.status,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func withChangedType(_ newType: ProjectType) -> Project {
        return Project(
            ID: self.ID,
            accountID: self.accountID,
            name: self.name,
            type: newType,
            status: self.status,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func withChangedStatus(_ newStatus: ProjectStatus) -> Project {
        return Project(
            ID: self.ID,
            accountID: self.accountID,
            name: self.name,
            type: self.type,
            status: newStatus,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func withCurrentUpdateTime(_ timeProvider: TimeProvider) -> Project {
        return Project(
            ID: self.ID,
            accountID: self.accountID,
            name: self.name,
            type: self.type,
            status: self.status,
            createdAt: self.createdAt,
            updatedAt: timeProvider.epochMillis()
        )
    }
    
}

extension Project : Comparable {
    
    static func == (lhs: Project, rhs: Project) -> Bool {
        return lhs.ID == rhs.ID &&
            lhs.accountID == rhs.accountID &&
            lhs.name == rhs.name &&
            lhs.type == rhs.type &&
            lhs.status == rhs.status
    }
    
    static func < (lhs: Project, rhs: Project) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func <= (lhs: Project, rhs: Project) -> Bool {
        return lhs.name <= rhs.name
    }
    
    static func >= (lhs: Project, rhs: Project) -> Bool {
        return lhs.name >= rhs.name
    }
    
    static func > (lhs: Project, rhs: Project) -> Bool {
        return lhs.name > rhs.name
    }
    
}
