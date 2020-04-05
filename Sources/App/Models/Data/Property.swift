import Foundation

final class Property : Codable {
    
    enum PropertyType : Int, Codable {
        case integer
        case string
        case boolean
        case double
    }
    
    let ID: Int?
    let serviceID: Int
    let name: String
    let type: PropertyType
    let mandatory: Bool
    let createdAt: Int64
    let updatedAt: Int64
    
    init(
        ID: Int? = nil,
        serviceID: Int,
        name: String,
        type: PropertyType,
        mandatory: Bool,
        createdAt: Int64,
        updatedAt: Int64
    ) {
        self.ID = ID
        self.serviceID = serviceID
        self.name = name
        self.type = type
        self.mandatory = mandatory
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
}

// safe modifiers
extension Property {
    
    func withChangedMandatory(_ newMandatory: Bool) -> Property {
        return Property(
            ID: self.ID,
            serviceID: self.serviceID,
            name: self.name,
            type: self.type,
            mandatory: newMandatory,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func withCurrentUpdateTime(_ timeProvider: TimeProvider) -> Property {
        return Property(
            ID: self.ID,
            serviceID: self.serviceID,
            name: self.name,
            type: self.type,
            mandatory: self.mandatory,
            createdAt: self.createdAt,
            updatedAt: timeProvider.epochMillis()
        )
    }
    
}

extension Property : Comparable {
    
    static func == (lhs: Property, rhs: Property) -> Bool {
        return lhs.ID == rhs.ID &&
            lhs.serviceID == rhs.serviceID &&
            lhs.name == rhs.name &&
            lhs.type == rhs.type &&
            lhs.mandatory == rhs.mandatory
    }
    
    static func < (lhs: Property, rhs: Property) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func <= (lhs: Property, rhs: Property) -> Bool {
        return lhs.name <= rhs.name
    }
    
    static func >= (lhs: Property, rhs: Property) -> Bool {
        return lhs.name >= rhs.name
    }
    
    static func > (lhs: Property, rhs: Property) -> Bool {
        return lhs.name > rhs.name
    }
    
}
