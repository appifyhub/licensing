import Foundation
import MySQL

final class Property : Codable {
    
    enum PropertyType : UInt8, Codable, CaseIterable, ReflectionDecodable {
        case integer = 1
        case string = 2
        case boolean = 3
        case double = 4
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
    
    private enum CodingKeys : String, CodingKey {
        case ID = "id"
        case serviceID = "service_id"
        case name = "name"
        case type = "type"
        case mandatory = "mandatory"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
}

// safe modifiers
extension Property {
    
    func tryWithChangedID(_ newID: Int) -> Property {
        let ID: Int
        if let oldID = self.ID {
            ID = oldID
        } else {
            ID = newID
        }
        
        return Property(
            ID: ID,
            serviceID: self.serviceID,
            name: self.name,
            type: self.type,
            mandatory: self.mandatory,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
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
    
    func withCurrentCreateTime(_ timeProvider: TimeProvider) -> Property {
        return Property(
            ID: self.ID,
            serviceID: self.serviceID,
            name: self.name,
            type: self.type,
            mandatory: self.mandatory,
            createdAt: timeProvider.epochMillis(),
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
