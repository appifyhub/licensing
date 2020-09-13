import Foundation
import MySQL

final class Project : Codable {
    
    enum ProjectType : UInt8, Codable, CaseIterable, ReflectionDecodable {
        case opensource = 1
        case commercial = 2
        case free = 3
    }
    
    enum ProjectStatus : UInt8, Codable, CaseIterable, ReflectionDecodable {
        case review = 1
        case active = 2
        case blocked = 3
        case suspended = 4
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
        createdAt: Int64 = 0,
        updatedAt: Int64 = 0
    ) {
        self.ID = ID
        self.accountID = accountID
        self.name = name
        self.type = type
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    private enum CodingKeys : String, CodingKey {
        case ID = "id"
        case accountID = "account_id"
        case name = "name"
        case type = "type"
        case status = "status"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
}

// safe modifiers
extension Project {
    
    func tryWithChangedID(_ newID: Int) -> Project {
        let ID: Int
        if let oldID = self.ID {
            ID = oldID
        } else {
            ID = newID
        }
        
        return Project(
            ID: ID,
            accountID: self.accountID,
            name: self.name,
            type: self.type,
            status: self.status,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
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
    
    func withCurrentCreateTime(_ timeProvider: TimeProvider) -> Project {
        return Project(
            ID: self.ID,
            accountID: self.accountID,
            name: self.name,
            type: self.type,
            status: self.status,
            createdAt: timeProvider.epochMillis(),
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
