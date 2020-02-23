import Foundation

struct ConfiguredProperty : Hashable {
    
    let assignedServiceID: Int
    let propertyID: Int
    let value: String // storing all as String for simplicity
    let createdAt: Int64
    let updatedAt: Int64
    
    func withChangedValue(_ newValue: String) -> ConfiguredProperty {
        return ConfiguredProperty(
            assignedServiceID: assignedServiceID,
            propertyID: propertyID,
            value: newValue,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
    
    func withCurrentUpdateTime(_ timeProvider: TimeProvider) -> ConfiguredProperty {
        return ConfiguredProperty(
            assignedServiceID: assignedServiceID,
            propertyID: propertyID,
            value: value,
            createdAt: createdAt,
            updatedAt: timeProvider.epochMillis()
        )
    }
    
}

extension ConfiguredProperty : Comparable {
    
    static func < (lhs: ConfiguredProperty, rhs: ConfiguredProperty) -> Bool {
        return lhs.assignedServiceID < rhs.assignedServiceID &&
            lhs.propertyID < rhs.propertyID &&
            lhs.updatedAt < rhs.updatedAt
    }
    
    static func <= (lhs: ConfiguredProperty, rhs: ConfiguredProperty) -> Bool {
        return lhs.assignedServiceID <= rhs.assignedServiceID &&
            lhs.propertyID <= rhs.propertyID &&
            lhs.updatedAt <= rhs.updatedAt
    }
    
    static func >= (lhs: ConfiguredProperty, rhs: ConfiguredProperty) -> Bool {
        return lhs.assignedServiceID >= rhs.assignedServiceID &&
            lhs.propertyID >= rhs.propertyID &&
            lhs.updatedAt >= rhs.updatedAt
    }
    
    static func > (lhs: ConfiguredProperty, rhs: ConfiguredProperty) -> Bool {
        return lhs.assignedServiceID > rhs.assignedServiceID &&
            lhs.propertyID > rhs.propertyID &&
            lhs.updatedAt > rhs.updatedAt
    }
    
}
