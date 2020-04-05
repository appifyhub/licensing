import Foundation

final class Service : Codable {
    
    let ID: Int?
    let name: String
    let createdAt: Int64
    let updatedAt: Int64
    
    init(
        ID: Int? = nil,
        name: String,
        createdAt: Int64,
        updatedAt: Int64
    ) {
        self.ID = ID
        self.name = name
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
}

// safe modifiers
extension Service {
    
    func withChangedName(_ newName: String) -> Service {
        return Service(
            ID: self.ID,
            name: newName,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func withCurrentUpdateTime(_ timeProvider: TimeProvider) -> Service {
        return Service(
            ID: self.ID,
            name: self.name,
            createdAt: self.createdAt,
            updatedAt: timeProvider.epochMillis()
        )
    }
    
}

extension Service : Comparable {
    
    static func == (lhs: Service, rhs: Service) -> Bool {
        return lhs.ID == rhs.ID &&
            lhs.name == rhs.name
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
