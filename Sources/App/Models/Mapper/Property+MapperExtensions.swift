import Foundation

private let INVALID_INT = -1

// Property conversions

extension PropertyDbm {
    
    func toDomainModel() -> Property {
        return Property(
            ID: self.ID ?? INVALID_INT,
            name: self.name,
            type: self.type.toDomainType(),
            mandatory: self.mandatory,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
}

extension Property {
    
    func toStorageModel(forService: Service) -> PropertyDbm {
        return PropertyDbm(
            ID: self.ID,
            serviceID: forService.ID,
            name: self.name,
            type: self.type.toStorageType(),
            mandatory: self.mandatory,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func toNetworkModel() -> PropertyDto {
        return PropertyDto(
            id: self.ID,
            name: self.name,
            type: self.type.toString(),
            mandatory: self.mandatory,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
}

extension PropertyDto {
    
    func toDomainModel() -> Property {
        return Property(
            ID: self.id,
            name: self.name,
            type: Property.PropertyType.find(self.type),
            mandatory: self.mandatory,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
}

// PropertyType conversions

extension PropertyDbm.PropertyType {
    
    func toDomainType() -> Property.PropertyType {
        switch self {
            case .integer: return .integer
            case .string: return .string
            case .boolean: return .boolean
            case .double: return .double
        }
    }
    
}

extension Property.PropertyType {
    
    static func find(
        _ stringValue: String,
        default: Property.PropertyType = .string
    ) -> Property.PropertyType {
        switch stringValue {
            case "integer": return .integer
            case "string": return .string
            case "boolean": return .boolean
            case "double": return .double
            default: return `default`
        }
    }
    
    func toStorageType() -> PropertyDbm.PropertyType {
        switch self {
            case .integer: return .integer
            case .string: return .string
            case .boolean: return .boolean
            case .double: return .double
        }
    }
    
    func toString() -> String {
        switch self {
            case .integer: return "integer"
            case .string: return "string"
            case .boolean: return "boolean"
            case .double: return "double"
        }
    }
    
}
