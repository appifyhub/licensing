import Foundation

struct ConfiguredPropertyDbm : Codable {
    
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
extension ConfiguredPropertyDbm {
    
    func tryWithChangedID(_ newID: Int) -> ConfiguredPropertyDbm {
        let ID: Int
        if let oldID = self.ID {
            ID = oldID
        } else {
            ID = newID
        }
        
        return ConfiguredPropertyDbm(
            ID: ID,
            assignedServiceID: self.assignedServiceID,
            propertyID: self.propertyID,
            value: self.value,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func withChangedValue(_ newValue: String) -> ConfiguredPropertyDbm {
        return ConfiguredPropertyDbm(
            ID: self.ID,
            assignedServiceID: self.assignedServiceID,
            propertyID: self.propertyID,
            value: newValue,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func withCurrentCreateTime(_ timeProvider: TimeProvider) -> ConfiguredPropertyDbm {
        return ConfiguredPropertyDbm(
            ID: self.ID,
            assignedServiceID: self.assignedServiceID,
            propertyID: self.propertyID,
            value: self.value,
            createdAt: timeProvider.epochMillis(),
            updatedAt: self.updatedAt
        )
    }
    
    func withCurrentUpdateTime(_ timeProvider: TimeProvider) -> ConfiguredPropertyDbm {
        return ConfiguredPropertyDbm(
            ID: self.ID,
            assignedServiceID: self.assignedServiceID,
            propertyID: self.propertyID,
            value: self.value,
            createdAt: self.createdAt,
            updatedAt: timeProvider.epochMillis()
        )
    }
    
}

extension ConfiguredPropertyDbm : Comparable {
    
    static func == (lhs: ConfiguredPropertyDbm, rhs: ConfiguredPropertyDbm) -> Bool {
        return lhs.ID == rhs.ID &&
            lhs.value == rhs.value
    }
    
    static func < (lhs: ConfiguredPropertyDbm, rhs: ConfiguredPropertyDbm) -> Bool {
        return lhs.value < rhs.value
    }
    
    static func <= (lhs: ConfiguredPropertyDbm, rhs: ConfiguredPropertyDbm) -> Bool {
        return lhs.value <= rhs.value
    }
    
    static func >= (lhs: ConfiguredPropertyDbm, rhs: ConfiguredPropertyDbm) -> Bool {
        return lhs.value >= rhs.value
    }
    
    static func > (lhs: ConfiguredPropertyDbm, rhs: ConfiguredPropertyDbm) -> Bool {
        return lhs.value > rhs.value
    }
    
}
