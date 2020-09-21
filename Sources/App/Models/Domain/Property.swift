import Foundation

struct Property {
    
    enum PropertyType : UInt8, CaseIterable {
        case integer = 1
        case string = 2
        case boolean = 3
        case double = 4
    }
    
    var ID: Int
    var name: String
    var type: PropertyType
    var mandatory: Bool
    var createdAt: Int64
    var updatedAt: Int64
    
}

extension Property : Comparable {
    
    static func == (lhs: Property, rhs: Property) -> Bool {
        return lhs.ID == rhs.ID
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
