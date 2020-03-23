import Foundation

struct Property : Hashable {
    
    enum PropertyType : Int {
        case integer
        case string
        case boolean
        case double
    }
    
    let ID: Int
    let serviceID: Int
    let name: String
    let type: PropertyType
    let mandatory: Bool
    let createdAt: Int64
    let updatedAt: Int64
    
    func withChangedMandatory(_ newMandatory: Bool) -> Property {
        return Property(
            ID: ID,
            serviceID: serviceID,
            name: name,
            type: type,
            mandatory: newMandatory,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
    
    func withCurrentUpdateTime(_ timeProvider: TimeProvider) -> Property {
        return Property(
            ID: ID,
            serviceID: serviceID,
            name: name,
            type: type,
            mandatory: mandatory,
            createdAt: createdAt,
            updatedAt: timeProvider.epochMillis()
        )
    }
    
}

extension Property : Comparable {
    
    static func < (lhs: Property, rhs: Property) -> Bool {
        return lhs.ID < rhs.ID
    }
    
    static func <= (lhs: Property, rhs: Property) -> Bool {
        return lhs.ID <= rhs.ID
    }
    
    static func >= (lhs: Property, rhs: Property) -> Bool {
        return lhs.ID >= rhs.ID
    }
    
    static func > (lhs: Property, rhs: Property) -> Bool {
        return lhs.ID > rhs.ID
    }
    
}
