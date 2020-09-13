import Foundation

struct ConfiguredProperty : Codable {
    
    let ID: Int?
    let assignedServiceID: Int
    let propertyID: Int
    let value: String // storing all as String for simplicity
    let createdAt: Int64
    let updatedAt: Int64
    
    init(
        ID: Int? = nil,
        assignedServiceID: Int,
        propertyID: Int,
        value: String,
        createdAt: Int64 = 0,
        updatedAt: Int64 = 0
    ) {
        self.ID = ID
        self.assignedServiceID = assignedServiceID
        self.propertyID = propertyID
        self.value = value
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    private enum CodingKeys : String, CodingKey {
        case ID = "id"
        case assignedServiceID = "assigned_service_id"
        case propertyID = "property_id"
        case value = "value"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
}

// safe modifiers
extension ConfiguredProperty {
    
    func tryWithChangedID(_ newID: Int) -> ConfiguredProperty {
        let ID: Int
        if let oldID = self.ID {
            ID = oldID
        } else {
            ID = newID
        }
        
        return ConfiguredProperty(
            ID: ID,
            assignedServiceID: self.assignedServiceID,
            propertyID: self.propertyID,
            value: self.value,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func withChangedValue(_ newValue: String) -> ConfiguredProperty {
        return ConfiguredProperty(
            ID: self.ID,
            assignedServiceID: self.assignedServiceID,
            propertyID: self.propertyID,
            value: newValue,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func withCurrentCreateTime(_ timeProvider: TimeProvider) -> ConfiguredProperty {
        return ConfiguredProperty(
            ID: self.ID,
            assignedServiceID: self.assignedServiceID,
            propertyID: self.propertyID,
            value: self.value,
            createdAt: timeProvider.epochMillis(),
            updatedAt: self.updatedAt
        )
    }
    
    func withCurrentUpdateTime(_ timeProvider: TimeProvider) -> ConfiguredProperty {
        return ConfiguredProperty(
            ID: self.ID,
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
        return lhs.ID == rhs.ID &&
            lhs.value == rhs.value
    }
    
    static func < (lhs: ConfiguredProperty, rhs: ConfiguredProperty) -> Bool {
        return lhs.value < rhs.value
    }
    
    static func <= (lhs: ConfiguredProperty, rhs: ConfiguredProperty) -> Bool {
        return lhs.value <= rhs.value
    }
    
    static func >= (lhs: ConfiguredProperty, rhs: ConfiguredProperty) -> Bool {
        return lhs.value >= rhs.value
    }
    
    static func > (lhs: ConfiguredProperty, rhs: ConfiguredProperty) -> Bool {
        return lhs.value > rhs.value
    }
    
}
