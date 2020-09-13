import Foundation

final class ServiceDbm : Codable {
    
    let ID: Int?
    let name: String
    let description: String
    let createdAt: Int64
    let updatedAt: Int64
    
    init(
        ID: Int? = nil,
        name: String,
        description: String,
        createdAt: Int64 = 0,
        updatedAt: Int64 = 0
    ) {
        self.ID = ID
        self.name = name
        self.description = description
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    private enum CodingKeys : String, CodingKey {
        case ID = "id"
        case name = "name"
        case description = "description"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
}

// safe modifiers
extension ServiceDbm {
    
    func tryWithChangedID(_ newID: Int) -> ServiceDbm {
        let ID: Int
        if let oldID = self.ID {
            ID = oldID
        } else {
            ID = newID
        }
        
        return ServiceDbm(
            ID: ID,
            name: self.name,
            description: self.description,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func withChangedName(_ newName: String) -> ServiceDbm {
        return ServiceDbm(
            ID: self.ID,
            name: newName,
            description: description,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func withChangedDescription(_ newDescription: String) -> ServiceDbm {
        return ServiceDbm(
            ID: self.ID,
            name: self.name,
            description: newDescription,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func withCurrentCreateTime(_ timeProvider: TimeProvider) -> ServiceDbm {
        return ServiceDbm(
            ID: self.ID,
            name: self.name,
            description: self.description,
            createdAt: timeProvider.epochMillis(),
            updatedAt: self.updatedAt
        )
    }
    
    func withCurrentUpdateTime(_ timeProvider: TimeProvider) -> ServiceDbm {
        return ServiceDbm(
            ID: self.ID,
            name: self.name,
            description: self.description,
            createdAt: self.createdAt,
            updatedAt: timeProvider.epochMillis()
        )
    }
    
}

extension ServiceDbm : Comparable {
    
    static func == (lhs: ServiceDbm, rhs: ServiceDbm) -> Bool {
        return lhs.ID == rhs.ID &&
            lhs.name == rhs.name &&
            lhs.description == rhs.description
    }
    
    static func < (lhs: ServiceDbm, rhs: ServiceDbm) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func <= (lhs: ServiceDbm, rhs: ServiceDbm) -> Bool {
        return lhs.name <= rhs.name
    }
    
    static func >= (lhs: ServiceDbm, rhs: ServiceDbm) -> Bool {
        return lhs.name >= rhs.name
    }
    
    static func > (lhs: ServiceDbm, rhs: ServiceDbm) -> Bool {
        return lhs.name > rhs.name
    }
    
}
