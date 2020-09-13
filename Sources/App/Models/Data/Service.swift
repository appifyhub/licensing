import Foundation

final class Service : Codable {
    
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
extension Service {
    
    func tryWithChangedID(_ newID: Int) -> Service {
        let ID: Int
        if let oldID = self.ID {
            ID = oldID
        } else {
            ID = newID
        }
        
        return Service(
            ID: ID,
            name: self.name,
            description: self.description,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func withChangedName(_ newName: String) -> Service {
        return Service(
            ID: self.ID,
            name: newName,
            description: description,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func withChangedDescription(_ newDescription: String) -> Service {
        return Service(
            ID: self.ID,
            name: self.name,
            description: newDescription,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func withCurrentCreateTime(_ timeProvider: TimeProvider) -> Service {
        return Service(
            ID: self.ID,
            name: self.name,
            description: self.description,
            createdAt: timeProvider.epochMillis(),
            updatedAt: self.updatedAt
        )
    }
    
    func withCurrentUpdateTime(_ timeProvider: TimeProvider) -> Service {
        return Service(
            ID: self.ID,
            name: self.name,
            description: self.description,
            createdAt: self.createdAt,
            updatedAt: timeProvider.epochMillis()
        )
    }
    
}

extension Service : Comparable {
    
    static func == (lhs: Service, rhs: Service) -> Bool {
        return lhs.ID == rhs.ID &&
            lhs.name == rhs.name &&
            lhs.description == rhs.description
    }
    
    static func < (lhs: Service, rhs: Service) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func <= (lhs: Service, rhs: Service) -> Bool {
        return lhs.name <= rhs.name
    }
    
    static func >= (lhs: Service, rhs: Service) -> Bool {
        return lhs.name >= rhs.name
    }
    
    static func > (lhs: Service, rhs: Service) -> Bool {
        return lhs.name > rhs.name
    }
    
}
