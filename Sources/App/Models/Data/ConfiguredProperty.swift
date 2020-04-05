import Foundation

struct ConfiguredProperty : Codable {
    
    let assignedServiceID: Int
    let propertyID: Int
    let value: String // storing all as String for simplicity
    let createdAt: Int64
    let updatedAt: Int64
    
    init(
        assignedServiceID: Int,
        propertyID: Int,
        value: String,
        createdAt: Int64,
        updatedAt: Int64
    ) {
        self.assignedServiceID = assignedServiceID
        self.propertyID = propertyID
        self.value = value
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
}

// safe modifiers
extension ConfiguredProperty {
    
    func withChangedValue(_ newValue: String) -> ConfiguredProperty {
        return ConfiguredProperty(
            assignedServiceID: self.assignedServiceID,
            propertyID: self.propertyID,
            value: newValue,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func withCurrentUpdateTime(_ timeProvider: TimeProvider) -> ConfiguredProperty {
        return ConfiguredProperty(
            assignedServiceID: self.assignedServiceID,
            propertyID: self.propertyID,
            value: self.value,
            createdAt: self.createdAt,
            updatedAt: timeProvider.epochMillis()
        )
    }
    
}

extension ConfiguredProperty : Comparable {
    
    static func == (lhs: ConfiguredProperty, rhs: ConfiguredProperty) -> Bool {
        return lhs.assignedServiceID == rhs.assignedServiceID &&
            lhs.propertyID == rhs.propertyID &&
            lhs.value == rhs.value
    }
    
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
